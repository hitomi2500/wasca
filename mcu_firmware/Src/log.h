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

/* Log to UART enable/disable switch :
 *  - 0 : disable (recommended)
 *  - 1 : enable
 */
#define LOG_UART_ENABLE 1


/* Initialize log internals. */
void log_init(void);


/* If needed, write from log buffer to SD card.
 * Should be called from time to time.
 */
void log_periodic_check(void);


/* Log output to MAX 10. */
#if LOG_ENABLE == 1

void logout_internal(int force_to_uart, int level, const char* fmt, ... );
#   define logout(_LVL_, ...) logout_internal(0, _LVL_, __VA_ARGS__)

void logflush_internal(void);
#   define logflush() logflush_internal()

#else
#   define logout(_LVL_, ...)
#   define logflush()
#endif



/* Log output directly to terminal via UART.
 * That's slow, but handy when log via USB can't be used.
 */
#if LOG_UART_ENABLE == 1
#   define termout(_LVL_, ...) logout_internal(1, _LVL_, __VA_ARGS__)
#else
#   define termout(_LVL_, ...)
#endif



#endif // _WL_STM32_LOG_H_
