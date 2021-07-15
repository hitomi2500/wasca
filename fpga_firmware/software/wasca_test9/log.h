#ifndef _WL_LOG_H_
#define _WL_LOG_H_

#include <sys/alt_stdio.h>
#include <string.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>

#include "wasca_defs.h"


/**
 * log_init
 *
 * Initialize log internals.
 * Must be called on program startup.
**/
void log_init(void);


/**
 * log_periodic_check
 *
 * Send log messages buffer to STM32 if some delay elapsed after last time
 * previous messages were sent.
 *
 * Note : Main program should call this function from time to time.
**/
#if LOG_ENABLE == 1
    void log_periodic_check(void);
#else
#   define log_periodic_check()
#endif


/**
 * logout/logflush
 *
 * logout      : Format and send (or accumulate in buffer) specified message.
 * logflush    : Force output of logs remaining in buffer.
**/
#if LOG_ENABLE == 1

void logout_internal(int to_uart, int level, const char* fmt, ... );
#   define logout(_LVL_, ...) logout_internal(0, _LVL_, __VA_ARGS__)

void logflush_internal(void);
#   define logflush() logflush_internal()

#else

#   define logout(_LVL_, ...)
#   define logflush()

#endif


/**
 * termout/log_to_uart
 *
 * Send specifed message via UART.
 * That's slow, but handy when normal logging can't be used.
 *
 * Usage examples :
 *  - Program startup, when log module or SPI is not available.
 *  - During interrupt, or at a precise timing etc.
 *
 * Note : log_to_uart is just a level-less shortcut to termout function.
 *
 * Note : log output via SPI is automatically used when UART is not instanced.
**/
#if LOG_ENABLE == 1

#ifdef __ALTERA_AVALON_UART
//#   define termout(_LVL_, ...) alt_printf(__VA_ARGS__, 0); alt_putstr("\r\n")
#   define termout(_LVL_, ...) logout_internal(1, _LVL_, __VA_ARGS__)
#else // !__ALTERA_AVALON_UART
#   define termout(_LVL_, ...) logout(_LVL_, __VA_ARGS__)
#endif // !__ALTERA_AVALON_UART

#   define log_to_uart(...) termout(WL_LOG_ERROR, __VA_ARGS__)

#else

#   define termout(_LVL_, ...)
#   define log_to_uart(...)

#endif


#endif // _WL_LOG_H_
