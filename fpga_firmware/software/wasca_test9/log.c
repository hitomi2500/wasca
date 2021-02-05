#include "log.h"
#include "spi_stm32.h"

#include "wasca_defs.h"


/*
 * ------------------------------------------
 * - Log stuff ------------------------------
 * ------------------------------------------
 */


#if LOG_ENABLE == 1
unsigned char _log_buffer[WL_LOG_BUFFER_SIZE];
unsigned short _log_buffer_len = 0;
#endif // LOG_ENABLE == 1


void log_init(void)
{
#if LOG_ENABLE == 1
    memset(_log_buffer, '\0', sizeof(_log_buffer));
    _log_buffer_len = 0;
#endif // LOG_ENABLE == 1
}

#if LOG_ENABLE == 1

void logout_internal(int level, const char* fmt, ... )
{
    /* Ensure that there is enough space available in buffer to format the log message.
     * If not, flush the log messages buffer.
     */
    if((_log_buffer_len + WL_LOG_MESSAGE_MAXLEN + 24) > WL_LOG_BUFFER_SIZE)
    {
        logflush_internal();
    }


    /* Setup pointer where to format log message.
     * First two bytes are used to store message length.
     */
    unsigned char* log_buff_start = _log_buffer + _log_buffer_len;
    unsigned short len = 0;
    char* buff = (char*)(log_buff_start + sizeof(len));

    va_list args;
    va_start(args, fmt);
    const char *w;
    char c;

    /* Process format string. */
    w = fmt;
    while ((c = *w++) != 0)
    {
        /* If not a format escape character, just print  */
        /* character.  Otherwise, process format string. */
        if (c != '%')
        {
            buff[len++] = c;
            if(_log_buffer_len >= WL_LOG_MESSAGE_MAXLEN)
            {
                break;
            }
        }
        else
        {
            /* Get format character.  If none     */
            /* available, processing is complete. */
            if ((c = *w++) != 0)
            {
                if (c == '%')
                {
                    /* Process "%" escape sequence. */
                    buff[len++] = c;
                } 
                else if (c == 'c')
                {
                    int v = va_arg(args, int);
                    buff[len++] = v;
                }
                else if (c == 's')
                {
                    /* Process string format. */
                    char *s = va_arg(args, char *);

                    while(*s)
                    {
                        buff[len++] = *s++;
                        if(_log_buffer_len >= WL_LOG_MESSAGE_MAXLEN)
                        {
                            break;
                        }
                    }
                }
                else
                {
                    /* Process hexadecimal number format.
                     * If not '%x' format, provide format and value in
                     * output string.
                     * Example : "%u[CAFE]", which should be displayed as
                     *           "51966" on PC side.
                     */
                    int direct_print = ((c == 'x') || (c == 'X') ? 1 : 0);
                    unsigned long v = va_arg(args, unsigned long);
                    unsigned long digit;
                    int digit_shift;

                    /* If not direct print, provide format in output buffer. */
                    if(!direct_print)
                    {
                        buff[len++] = '%';
                        while(1)
                        {
                            buff[len++] = c;

                            /* Don't forget to provide any eventual
                             * length specificator.
                             */
                            if((c < '0') || (c > '9'))
                            {
                                break;
                            }

                            c = *w++;
                        }

                        /* Add delimiter for value. */
                        buff[len++] = '[';
                    }

                    if (v == 0)
                    {
                        /* If the number value is zero, just print and continue. */
                        buff[len++] = '0';
                    }
                    else
                    {
                        /* Find first non-zero digit. */
                        digit_shift = 28;
                        while (!(v & (0xF << digit_shift)))
                        {
                            digit_shift -= 4;
                        }

                        /* Print digits. */
                        for (; digit_shift >= 0; digit_shift -= 4)
                        {
                            digit = (v & (0xF << digit_shift)) >> digit_shift;
                            if (digit <= 9)
                            {
                                c = '0' + digit;
                            }
                            else
                            {
                                c = 'A' + digit - 10;
                            }
                            buff[len++] = c;
                        }
                    }

                    /* If not direct print, don't forget to close value delimiter. */
                    if(!direct_print)
                    {
                        buff[len++] = ']';
                    }
                }

                if(_log_buffer_len >= WL_LOG_MESSAGE_MAXLEN)
                {
                    break;
                }
            }
            else
            {
                break;
            }
        }
    }

    if(level == -1)
    {
        /* Dirty hack to use output to UART instead of SPI. */
        char* str = ((char*)log_buff_start) + sizeof(len);
        str[len-1] = '\0';
        alt_putstr(str);
        alt_putstr("\r\n");
    }
    else
    {
        /* Indicate size taken by this log message.
         *
         * Log message itself is already written at the
         * right position, so there's no need to copy it.
         */
        len += sizeof(len);
        memcpy(log_buff_start, &len, sizeof(len));

        /* Update space taken in log messages buffer. */
        _log_buffer_len += len;
    }
}


void logflush_internal(void)
{
    if(_log_buffer_len == 0)
    {
        /* Nothing to flush. */
        return;
    }

    /* Send log messages buffer to STM32 via SPI.
     * 
     * If necessary, buffer is split into several packets
     * containing up to WL_SPI_DATA_LEN characters
     */
    unsigned char block_cnt = _log_buffer_len / WL_SPI_DATA_LEN;
    if((_log_buffer_len % WL_SPI_DATA_LEN) != 0)
    {
        block_cnt++;
    }

    wl_spicomm_logs_t log_set = {0};
    log_set.block_cnt = block_cnt;

    unsigned char block_id;
    for(block_id=0; block_id<block_cnt; block_id++)
    {
        unsigned short log_offset = block_id * WL_SPI_DATA_LEN;
        unsigned short log_len    = _log_buffer_len - log_offset;
        if(log_len > WL_SPI_DATA_LEN)
        {
            log_len = WL_SPI_DATA_LEN;
        }

        log_set.block_id  = block_id + 1;
        log_set.block_len = log_len;

        spi_send_logs(&log_set, _log_buffer + log_offset);
    }

    /* Indicate that log messages buffer is empty. */
    _log_buffer_len = 0;
}

#endif // LOG_ENABLE == 1
