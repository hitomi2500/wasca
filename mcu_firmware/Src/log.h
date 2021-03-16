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



/* Log output to MAX 10. */
#if LOG_ENABLE == 1


/* Logs circular buffer size.
 *
 * The larger the more it can handle log messages between two access from PC.
 */
#define CIRCBUFF_SIZE (2*1024)

typedef struct _log_infos_t
{
    /* Circular buffer R/W pointers (address is relative from the begining of circular buffer). */
    unsigned long readptr;
    unsigned long writeptr;

    /* Circular buffer internals. */
    unsigned long buffer_size;
    unsigned long start_address;
    unsigned long end_address;

    // /* Log level.
    //  *
    //  * Need to set value #defined in WL_LOG_* macros.
    //  * Logs with level stricly higher ( > ) than this level
    //  * are discarded from output.
    //  *
    //  * Note : log output can be stopped by setting this
    //  *        level value to zero.
    //  */
    // char level;
    // 
    // /* Unused, for structure alignment purpose. */
    // unsigned char padding[3];

    /* Circular buffer used when reading/writing debug data. */
    unsigned char circbuff[CIRCBUFF_SIZE];

    /* Message format buffer, used just before appending to circular buffer.
     * First two bytes are used to store message length.
     * Message is NOT null-terminated.
     */
    unsigned char format_buff[sizeof(unsigned short) + WL_LOG_MESSAGE_MAXLEN];
} log_infos_t;



/* Append specified data to logs circular buffer. */
void log_cbwrite(unsigned char* data, unsigned long datalen);

/* Return circular buffer memory total/usage. */
unsigned short log_cbmem_total(void);
unsigned short log_cbmem_use(void);

/* Read specified length from logs circular buffer. */
void log_cbread(unsigned char* data, unsigned long read_len, int update_rp);

void logout_internal(int to_uart, int to_usb, int level, const char* fmt, ... );
#   define logout(_LVL_, ...) logout_internal(0, 1, _LVL_, __VA_ARGS__)

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
#   define termout(_LVL_, ...) logout_internal(1, 0, _LVL_, __VA_ARGS__)
#else
#   define termout(_LVL_, ...)
#endif



#endif // _WL_STM32_LOG_H_
