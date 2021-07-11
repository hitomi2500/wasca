#include <stdio.h>
#include "log.h"

#include "sd_wrapper.h"
#include "settings.h"



/*
 * ------------------------------------------
 * - USB CDC wrapper ------------------------
 * ------------------------------------------
 */
#include "usbd_cdc_if.h"
extern USBD_HandleTypeDef hUsbDeviceFS;

int USB_write(void* buf, size_t count)
{
    static int failed = 0;

    if(hUsbDeviceFS.dev_state != USBD_STATE_CONFIGURED)
    {
        return 0;
    }

    if(failed)
    {
        if(CDC_Transmit_FS(buf, count) == USBD_OK)
        {
            failed = 0;
            return count;
        }
        return 0;
    }


    unsigned long tick0 = HAL_GetTick();
    unsigned long diff;
    do
    {
        if(hUsbDeviceFS.dev_state != USBD_STATE_CONFIGURED)
        {
            return 0;
        }

        int result = CDC_Transmit_FS(buf, count);

        if(result == USBD_OK)
        {
            return count;
        }
        if(result != USBD_BUSY)
        {
            return -1;
        }

        /* 0.5 second timeout. */
        unsigned long tick1 = HAL_GetTick();
        if(tick1 >= tick0)
        {
            diff = tick1 - tick0;
        }
        else
        {
            /* This happens once every 49.7 days. */
            diff = (0xFFFFFFFF - tick0) + tick1;
        }
    }while(diff < 500);

    failed = 1;

    return 0;
}



/*
 * ------------------------------------------
 * - Log stuff ------------------------------
 * ------------------------------------------
 */



#if LOG_ENABLE == 1

/* Buffer where to format and optionally accumulate log messages.
 *
 * Accumulation mechanism is used to improve log messages write performance
 * to SD card, so it recommended to allocate length of several SD card sectors
 * so that overhead caused by writing of incomplete sector can be reduced.
 *  Example : 8 sectors = 4KB
 *
 * Note : because this buffer is also used to format log message, its size must
 *        be larger than WL_LOG_MESSAGE_MAXLEN.
 */
char _log_buffer[MAX(4*1024, WL_LOG_MESSAGE_MAXLEN)];
unsigned short _log_bufflen = 0;
unsigned long _log_total_len = 0;
unsigned long _log_prev_flush_tick = 0;

FIL _LogFile;
int _log_file_open = 0;

#endif // LOG_ENABLE == 1


void log_init(void)
{
#if LOG_ENABLE == 1

    /* Initialize log internals. */
    memset(_log_buffer, 0, sizeof(_log_buffer));
    _log_bufflen = 0;
    _log_total_len = 0;
    _log_prev_flush_tick = HAL_GetTick();
    _log_file_open = 0;

#endif // LOG_ENABLE == 1
}


#if LOG_ENABLE == 1

/* Write log messages eventually remaining in buffer. */
void logflush_internal(void)
{
    if(_log_bufflen == 0)
    {
        return;
    }

    /* If not already done, open log file . */
    if(!_log_file_open)
    {
        int f_ret = f_open(&_LogFile, "/WASCA.LOG", FA_WRITE | FA_CREATE_ALWAYS);

        if(f_ret == FR_OK)
        {
            _log_file_open = 1;
        }
    }

    /* Write and synchronize any pending write to SD card. */
    if(_log_file_open)
    {
        UINT bytes_written = 0;
        f_write(&_LogFile, _log_buffer, _log_bufflen, &bytes_written);
        f_sync(&_LogFile);
    }

    /* Flush log messages from buffer. */
    _log_bufflen = 0;
    _log_prev_flush_tick = HAL_GetTick();
}


void log_periodic_check(void)
{
    if(_log_bufflen == 0)
    {
        return;
    }

    unsigned long tick = HAL_GetTick();
    unsigned long diff;
    if(tick >= _log_prev_flush_tick)
    {
        diff = tick - _log_prev_flush_tick;
    }
    else
    {
        /* This happens once every 49.7 days. */
        diff = (0xFFFFFFFF - _log_prev_flush_tick) + tick;
    }

    if(diff >= _wasca_set.flush_interval)
    {
        logflush_internal();

        //_log_prev_flush_tick = HAL_GetTick();
    }
}


void logout_internal(int force_to_uart, int level, const char* fmt, ... )
{
    int to_uart = (force_to_uart ? 1 : _wasca_set.log_to_uart);
    int to_usb  = _wasca_set.log_to_usb;
    int to_sd   = (_sdcard_available ? _wasca_set.log_to_uart : 0);

    /* Restrict log file size on SD card.
     * This restriction is recommended because the larger
     * the file the longer it takes to append something to it.
     */
    if((to_sd) && (_wasca_set.log_max_size != 0))
    {
        if(_log_total_len >= _wasca_set.log_max_size)
        {
            to_sd = 0;
        }
    }

    if((to_uart == 0) && (to_usb == 0) && (to_sd == 0))
    {
        return;
    }

    /* If there isn't enough room in logs buffer to
     * format current message, flush the buffer to SD card.
     */
    if((to_sd) && (_log_bufflen + WL_LOG_MESSAGE_MAXLEN) > sizeof(_log_buffer))
    {
        logflush_internal();
    }

    va_list argptr;

    /* Prepare buffer where to format log message. */
    char* format_buff = _log_buffer + _log_bufflen;
    int format_len = WL_LOG_MESSAGE_MAXLEN - 4;

    /* Print the log message to the memory. */
    unsigned short len = 0;
    va_start(argptr, fmt);
    len += vsnprintf(format_buff, format_len, fmt, argptr);
    va_end(argptr);

    /* Append line break characters. */
    format_buff[len++] = '\r';
    format_buff[len++] = '\n';
    format_buff[len  ] = '\0';

    /* Update each lengths.
     * 
     * Note : as buffer is used to accumulate log messages for
     *        writing on SD card, its length should be updated
     *        only when writing to SD card is enabled.
     */
    if(to_sd)
    {
        _log_bufflen += len;
    }
    if(_log_total_len < 0xFFFF0000)
    {
        _log_total_len += len;
    }

    if(to_uart)
    {
        /* Simply throw log message to UART.
         * That's slow, but handy when log via USB can't be used.
         */
        printf("%s", format_buff);
    }

    if(to_usb)
    {
        int usb_ret = USB_write(format_buff, len);

        /* Output error to UART when USB communication failed. */
        if(usb_ret != len)
        {
            printf
            (
                "Tick[0x%08X] USB CDC Error ! len[%u] -> ret[%d]\r\n"
                , (unsigned int)HAL_GetTick()
                , len
                , usb_ret
            );
        }
    }

    /* Extra case when flush interval is set to zero = flush logs to SD card
     * one by one. Useful when tracking where this application is crashing.
     */
    if((to_sd) && (_wasca_set.flush_interval == 0))
    {
        logflush_internal();
    }
}

#endif // LOG_ENABLE == 1

