#ifndef _WL_STM32_LOG_H_
#define _WL_STM32_LOG_H_

#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "main.h"
#include "stm32f4xx_hal.h"

#include "satcom_lib/wasca_link.h"


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



/* Log output to MAX 10. */
#if LOG_ENABLE == 1

extern log_infos_t _log_inf_data;

/* Append specified data to logs circular buffer. */
void log_cbwrite(unsigned char* data, unsigned long datalen);

/* Return circular buffer memory total/usage. */
unsigned short log_cbmem_total(void);
unsigned short log_cbmem_use(void);

/* Read specified length from logs circular buffer. */
void log_cbread(unsigned char* data, unsigned long read_len, int update_rp);

void logout_internal(int to_uart, int to_spi, int level, const char* fmt, ... );
#   define logout(_LVL_, ...) logout_internal(0, 1, _LVL_, __VA_ARGS__)

void logflush_internal(void);
#   define logflush() logflush_internal()

#else
#   define logout(_LVL_, ...)
#   define logflush()
#endif



/* Log output directly to terminal via UART.
 * That's slow, but handy when log via SPI can't be used.
 */
#if LOG_UART_ENABLE == 1
#   define termout(_LVL_, ...) logout_internal(1, 0, _LVL_, __VA_ARGS__)
#else
#   define termout(_LVL_, ...)
#endif



#endif // _WL_STM32_LOG_H_
