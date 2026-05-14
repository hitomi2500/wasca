#include "log.h"
#include "spi_stm32.h"

#include "wasca_defs.h"
#include "settings.h"

/*
 * ------------------------------------------
 * - Log stuff ------------------------------
 * ------------------------------------------
 */


#if LOG_ENABLE == 1
unsigned char _log_buffer[WL_LOG_BUFFER_SIZE];
unsigned short _log_buffer_len = 0;
unsigned long _log_check_counter = 0;
#endif // LOG_ENABLE == 1


void log_init(void)
{
#if LOG_ENABLE == 1
    memset(_log_buffer, '\0', sizeof(_log_buffer));
    _log_buffer_len = 0;
    _log_check_counter = 0;
#endif // LOG_ENABLE == 1
}

#if LOG_ENABLE == 1

void logout_internal(int to_uart, int level, const char* fmt, ... )
{
    /* Discard logs with level above specified one. */
    if((level > _baseset.log_level) || (level <= 0))
    {
        return;
    }


    /* Ensure that there is enough space available in buffer to format the log message.
     * If not, flush the log messages buffer.
     */
    if((_log_buffer_len + sizeof(wl_log_header_t) + WL_LOG_MESSAGE_MAXLEN + 24) > WL_LOG_BUFFER_SIZE)
    {
        logflush_internal();
    }

    /* From API point of view, it's possible to select only one destination
     * among UART and SPI. So if the log is not destinated for UART then it is
     * for SPI.
     * But after that, as it is possible to tune output to UART (with setting in
     * ini file) each output status are separated.
     */
    int to_spi = (to_uart ? 0 : 1);

    /* Adjust output to UART.
     *  - 0 : disable all logs to UART, except error or direct output ones
     *  - 1 : output only logs targeted to UART
     *  - 2 : output logs targeted to UART + copy normal logs to UART
     */
    if(_baseset.uart_mode == 0)
    {
        to_uart = 0;
    }
    else if(_baseset.uart_mode == 1)
    {
        /* Nothing special to change in this case. */
    }
    else // if(_baseset.uart_mode == 2)
    {
        to_uart = 1;
    }

    if((to_uart == 0) && (to_spi == 0))
    {
        return;
    }


    /* Setup pointer where to format log message.
     * First two bytes are used to store message length.
     */
    unsigned char* log_buff_start = _log_buffer + _log_buffer_len;
    unsigned short len = 0;
    char* buff = (char*)(log_buff_start + sizeof(wl_log_header_t));

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
            if(len >= WL_LOG_MESSAGE_MAXLEN)
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
                        if(len >= WL_LOG_MESSAGE_MAXLEN)
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
                        int param_len = 0;
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

                            /* Avoid unusually long length specificator. */
                            param_len++;
                            if(param_len >= 4)
                            {
                                break;
                            }
                        }

                        /* Add delimiter for value. */
                        buff[len++] = '[';
                    }

                    if(v == 0)
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

                if(len >= WL_LOG_MESSAGE_MAXLEN)
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

    if(to_uart)
    {
        char* str = ((char*)log_buff_start) + sizeof(wl_log_header_t);
        str[len+0] = '\r';
        str[len+1] = '\n';
        str[len+2] = '\0';
        alt_putstr(str);
    }

    if(to_spi)
    {
        /* Some portions of formatted messages are appended by group of
         * characters. As a consequence message may be a bit longer than allowed
         * length, so that it's necessary to check and clamp it.
         */
        if(len > WL_LOG_MESSAGE_MAXLEN)
        {
            len = WL_LOG_MESSAGE_MAXLEN;
        }

        wl_log_header_t hdr = {0};
        hdr.len   = len;
        hdr.level = (char)level;
        memcpy(log_buff_start, &hdr, sizeof(wl_log_header_t));

        /* Update space taken in log messages buffer.
         *
         * Log message itself is already written at the right position, so
         * there's no need to copy it.
         */
        _log_buffer_len += sizeof(wl_log_header_t) + len;

        /* In the case log flush period is set to smallest value, 
         * let's send current message to STM32 right now.
         */
        if(_baseset.flush_interval == 0)
        {
            logflush_internal();
        }
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
     * SPI communication is designed to be able to send whole log buffer in a
     * single transaction, so that this buffer doesn't needs to be split into
     * several packets.
     */
    spi_send_logs(_log_buffer, _log_buffer_len);

    /* Indicate that log messages buffer is now empty. */
    _log_buffer_len = 0;
    _log_check_counter = 0;
}


void log_periodic_check(void)
{
    if(_log_buffer_len == 0)
    {
        return;
    }

    /* A "clean" implementation of this function would be to verify the time
     * elapsed until the last time log messages were sent. But as MAX 10
     * hardware resources are quite limited and pricey let's simply flush log
     * messages every nth time this function is called.
     */
    if(_log_check_counter >= _baseset.flush_interval)
    {
        logflush_internal();
    }
    else
    {
        _log_check_counter++;
    }
}


#endif // LOG_ENABLE == 1
