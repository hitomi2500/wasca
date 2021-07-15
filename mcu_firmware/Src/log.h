#ifndef _WL_STM32_LOG_H_
#define _WL_STM32_LOG_H_

#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "main.h"
#include "stm32f4xx_hal.h"

#include "wasca_defs.h"


/* Log enable/disable switch :
 *  - 0 : disable all logs
 *  - 1 : enable logging
 */
#define LOG_ENABLE 1


/**
 * log_init
 *
 * Initialize log internals.
 * Must be called on program startup.
 *
 * Note : SD card don't need to be initialized when this function is called.
**/
#if LOG_ENABLE == 1
    void log_init(void);
#else
#   define log_init()
#endif // LOG_ENABLE == 1


/**
 * log_periodic_check
 *
 * Write log buffer contents to SD card if last write is older than a given
 * duration. Duration can be modified in settings (ini) file.
 *
 * Note : Main program should call this function from time to time.
**/
#if LOG_ENABLE == 1
    void log_periodic_check(void);
#else
#   define log_periodic_check()
#endif // LOG_ENABLE == 1


/**
 * logout/logflush
 *
 * logout   : Format and send (or accumulate in buffer) specified message.
 * logflush : Force output of logs remaining in SD card write buffer.
 *
 * Note : As logflush opens log file on SD card and appends messages to it, it
 *        should be called only when needed. Typical usage is when program is
 *        likely to crash soon after logout function is called.
**/
#if LOG_ENABLE == 1

void logout_internal(int to_uart, int level, int from_m10, const char* fmt, ... );
#   define logout(_LVL_, ...) logout_internal(0, _LVL_, 0, __VA_ARGS__)

void logflush_internal(void);
#   define logflush() logflush_internal()

#else

#   define logout(_LVL_, ...)
#   define logflush()

#endif // LOG_ENABLE == 1


/**
 * termout/log_to_uart
 *
 * Log output directly to terminal via UART.
 * That's slow, but handy when normal logging can't be used.
 *
 * Usage examples :
 *  - Program startup, when log module or SD card access is not ready.
 *  - During interrupt, or at a precise timing etc.
 *
 * Note : log_to_uart is just a level-less shortcut to termout function.
**/
#if LOG_ENABLE == 1

#   define termout(_LVL_, ...) logout_internal(1, _LVL_, 0, __VA_ARGS__)
#   define log_to_uart(...) termout(WL_LOG_ERROR, __VA_ARGS__)

#else

#   define termout(_LVL_, ...)
#   define log_to_uart(...)

#endif // LOG_ENABLE == 1



/**
 * spi_logs_process
 *
 * Separate and format log messages received from MAX 10 via SPI.
**/
void spi_logs_process(char* logs_data, unsigned short logs_datalen);


#endif // _WL_STM32_LOG_H_
