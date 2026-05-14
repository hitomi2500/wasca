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
unsigned short _log_bufflen  = 0;
unsigned long _log_total_len = 0;
unsigned long _log_file_id   = 0;
unsigned long _log_prev_flush_tick = 0;

FIL _LogFile;
int _log_file_open = 0;
int _log_files_rename_done = 0;



void log_init(void)
{
    /* Initialize log internals. */
    memset(_log_buffer, 0, sizeof(_log_buffer));
    _log_bufflen   = 0;
    _log_total_len = 0;
    _log_file_id   = 0;
    _log_prev_flush_tick = HAL_GetTick();
    _log_file_open = 0;
    _log_files_rename_done = 0;
}


/* Write log messages eventually remaining in buffer. */
void logflush_internal(void)
{
    if(_log_bufflen == 0)
    {
        return;
    }

    /* If not already done, open log file. */
    if(!_log_file_open)
    {
        char file_name[16];
        if(_wasca_set.log_file_count <= 1)
        {
            strcpy(file_name, "/WASCA.LOG");
        }
        else
        {
            if(!_log_files_rename_done)
            {
                /* Rename old log files.
                 * 
                 * Example with log files count set to 5 :
                 *  1. Rename WASCA04.LOG to WASCA05.LOG
                 *  2. Rename WASCA03.LOG to WASCA04.LOG
                 *  3. Rename WASCA02.LOG to WASCA03.LOG
                 *  4. Rename WASCA01.LOG to WASCA02.LOG
                 * After that, logs are written to WASCA01.LOG file.
                 */
                for(int i=_wasca_set.log_file_count-1; i>0; i--)
                {
                    char old_file_name[sizeof(file_name)];
                    sprintf(file_name    , "/WASCA%02u.LOG", (unsigned char)(i+0));
                    sprintf(old_file_name, "/WASCA%02u.LOG", (unsigned char)(i+1));
                    f_unlink(old_file_name);
                    f_rename(file_name, old_file_name);
                }

                /* Prevent to re-rename files in the case file open failed. */
                _log_files_rename_done = 1;
            }

            strcpy(file_name, "/WASCA01.LOG");
        }

        int f_ret = f_open(&_LogFile, file_name, FA_WRITE | FA_CREATE_ALWAYS);

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

    /* Indicate that data was written from buffer to SD card. */
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

unsigned int _log_prev_timestamp = 0;
void logout_internal(int to_uart, int level, int from_m10, const char* fmt, ... )
{
    int to_usb  = _wasca_set.log_to_usb;
    int to_sd   = (_sdcard_available ? 1 : 0);

    /* Log level sanity check. */
    if(level < 0)
    {
        level = 0;
    }
    else if(level > 9)
    {
        level = 9;
    }

    /* Verify log level.
     * In the case of logs from MAX 10, level was already tested so it's not
     * needed to re-test here.
     */
    if(!from_m10)
    {
        if(level > _wasca_set.log_level)
        {
            return;
        }
    }

    /* Adjust output to UART.
     *  - 0 : disable all logs to UART, except error or direct output ones
     *  - 1 : output only logs targeted to UART
     *  - 2 : output logs targeted to UART + copy normal logs to UART
     */
    if(_wasca_set.uart_mode == 0)
    {
        to_uart = 0;
    }
    else if(_wasca_set.uart_mode == 1)
    {
        /* Nothing special to change in this case. */
    }
    else // if(_wasca_set.uart_mode == 2)
    {
        to_uart = 1;
    }

    /* Restrict log file size on SD card.
     * This restriction is recommended because the larger
     * the file the longer it takes to append something to it.
     */
    if((to_sd) && (_wasca_set.log_max_size != 0))
    {
        if(_log_total_len >= _wasca_set.log_max_size)
        {
            /* Close current log file. */
            if(_log_file_open)
            {
                f_close(&_LogFile);
                _log_file_open = 0;

                /* Allow to bump log files on next access. */
                _log_files_rename_done = 0;
            }

            /* If file count settings allows it, jump to next log file. */
            _log_total_len = 0;
            _log_file_id++;

            if(_log_file_id >= _wasca_set.log_file_count)
            {
                to_sd = 0;
            }
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


    /* Set prefix with origin and log level at the beginning of each lines :
     *  - First letter  : origin 'M' = MAX 10, 'S' = STM32.
     *  - Second letter : level, from '1' (error) to '9' (debug)
     */
    unsigned short len = 0;
    char* log_ptr = _log_buffer + _log_bufflen;

    /* Check if time stamp have to be output or not. */
    if(_wasca_set.log_timestamp)
    {
        unsigned int tick = HAL_GetTick();

        /* If previous log was sent recently, output time
         * difference rather than absolute time stamp.
         */
        unsigned int diff = tick - _log_prev_timestamp;
        if(diff < 500)
        {
            len += sprintf(log_ptr, "[    +%03u]", diff);
        }
        else
        {
            len += sprintf(log_ptr, "[%08X]", tick);
        }

        _log_prev_timestamp = tick;
    }

    log_ptr[len++] = (from_m10 ? 'M' : 'S');
    log_ptr[len++] = '0' + level;
    log_ptr[len++] = '>';

    /* Print the log message to memory. */
    char* format_ptr = log_ptr + len;
    int format_len = WL_LOG_MESSAGE_MAXLEN - 8;

    va_list argptr;
    va_start(argptr, fmt);
    len += vsnprintf(format_ptr, format_len, fmt, argptr);
    va_end(argptr);

    /* Append line break characters. */
    log_ptr[len++] = '\r';
    log_ptr[len++] = '\n';
    log_ptr[len  ] = '\0';

    /* Update each lengths.
     * 
     * Note : as buffer is used to accumulate log messages for
     *        writing on SD card, its length should be updated
     *        only when writing to SD card is enabled.
     */
    if(to_sd)
    {
        _log_bufflen += len;

        if(_log_total_len < 0xFFFF0000)
        {
            _log_total_len += len;
        }
    }

    if(to_uart)
    {
        /* Simply throw log message to UART.
         * That's slow, but handy when log via USB can't be used.
         */
        printf("%s", log_ptr);
    }

    if(to_usb)
    {
        int usb_ret = USB_write(log_ptr, len);

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



/**
 * log_post_format
 *
 * Log module internal function which converts pre-formatted log message to
 * something readable by human.
 * Example : "TEST %u[10E]" -> "TEST 270"
 *
 * This weird log format exists because in order to reduce usage of hardware
 * resources on MAX 10 side, the bare mininmum regarding log format is done
 * there and the remaining is then done here.
**/
void log_post_format(char* raw_log_ptr, char* out_log_ptr)
{
    int i;
    int pos = 0;
    out_log_ptr[pos] = '\0';

    int raw_log_len = strlen(raw_log_ptr);

    for(i=0; i<raw_log_len; i++)
    {
        char c = raw_log_ptr[i];
        if(c == '%')
        {
            char fmt_tmp[16] = {'\0'};
            char val_tmp[16] = {'\0'};
            int j;
            int char_cnt = 0;
            int format_error = 0;

            /* Get format string. */
            for(j=0; j<sizeof(fmt_tmp)-4; j++)
            {
                c = raw_log_ptr[i+char_cnt];
                char_cnt++;
                if(c == '\0')
                {
                    format_error = 1;
                    break;
                }
                if(c == '[')
                {
                    break;
                }
                fmt_tmp[strlen(fmt_tmp)] = c;
            }
            if(c != '[')
            {
                format_error = 1;
            }

            if(!format_error)
            {
                /* Get value string. */
                val_tmp[0] = '0';
                val_tmp[1] = 'x';
                for(j=0; j<sizeof(val_tmp)-4; j++)
                {
                    c = raw_log_ptr[i+char_cnt];
                    char_cnt++;
                    if(c == '\0')
                    {
                        format_error = 1;
                        break;
                    }
                    if(c == ']')
                    {
                        break;
                    }
                    val_tmp[strlen(val_tmp)] = c;
                }
                if(c != ']')
                {
                    format_error = 1;
                }
            }

            /* If valid, format the string. */
            if(!format_error)
            {
                char strFormatRes[16];
                sprintf(strFormatRes, fmt_tmp, strtoul(val_tmp, NULL, 0));
                strcpy(out_log_ptr+pos, strFormatRes);
                pos += strlen(strFormatRes);
                out_log_ptr[pos] = '\0';
                i += char_cnt-1;
            }
            else
            {
                out_log_ptr[pos++] = '%';
                out_log_ptr[pos] = '\0';
            }
        }
        else
        {
            out_log_ptr[pos++] = c;
            out_log_ptr[pos] = '\0';
        }
    }
}


void spi_logs_process(char* logs_data, unsigned short logs_datalen)
{
    for(int offset=0; offset<logs_datalen; /*nothing*/)
    {
        /* Retrieve log header. */
        if((offset + sizeof(wl_log_header_t)) > logs_datalen)
        {
            break;
        }

        wl_log_header_t hdr;
        memcpy(&hdr, logs_data+offset, sizeof(wl_log_header_t));
        offset += sizeof(wl_log_header_t);


        /* Retrieve log message. */
        if((offset + hdr.len) > logs_datalen)
        {
            break;
        }

        int log_len = MIN(hdr.len, WL_LOG_MESSAGE_MAXLEN);
        char log_buff[WL_LOG_MESSAGE_MAXLEN + 16] = { '\0' };
        if(log_len > 0)
        {
            memcpy(log_buff, logs_data+offset, log_len);
            log_buff[log_len] = '\0';
        }


        /* MAX 10 does only the bare minimum regarding log message formatting.
         * For example, ("TEST %u", 51966) is received as "TEST %u[CAFE]"
         * and consequently needs to be post-processed here before being sent
         * to SD card/USB/UART/whatever.
         */
        char log_format[sizeof(log_buff)] = { '\0' };
        log_post_format(log_buff, log_format);


        /* Finally, retrieve output level. */
        int level = hdr.level;
        if(level < WL_LOG_ERROR)
        {
            level = WL_LOG_ERROR;
        }
        if(level > WL_LOG_DEBUGHARD)
        {
            level = WL_LOG_DEBUGHARD;
        }

        logout_internal(0/*to_uart*/, level, 1/*from_m10*/, "%s", log_format);

        offset += hdr.len;
    }
}


#endif // LOG_ENABLE == 1

