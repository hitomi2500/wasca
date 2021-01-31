#ifndef _WL_LOG_H_
#define _WL_LOG_H_

#include <sys/alt_stdio.h>
#include <string.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>

#include "wasca_defs.h"


/* Initialize log internals. */
void log_init(void);


#if LOG_ENABLE == 1

void logout_internal(int level, const char* fmt, ... );
#   define logout(...) logout_internal(WL_LOG_DEBUGNORMAL, __VA_ARGS__)

    /* Log output to UART.
     *
     * Note : This automatically uses log output via SPI when UART
     *        is not instanced on Qsys.
     */
#ifdef __ALTERA_AVALON_UART
//#   define log_to_uart(...) alt_printf(__VA_ARGS__, 0); alt_putstr("\r\n")
#   define log_to_uart(...) logout_internal(-1, __VA_ARGS__)
#else // !__ALTERA_AVALON_UART
#   define log_to_uart(...) logout(WL_LOG_DEBUGNORMAL, __VA_ARGS__)
#endif // !__ALTERA_AVALON_UART

void logflush_internal(void);
#   define logflush() logflush_internal()

#else

    /* Remove log output. */
#   define logout(...)
#   define log_to_uart(...)
#   define logflush()

#endif

#endif // _WL_LOG_H_
