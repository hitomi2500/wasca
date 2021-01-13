#ifndef _WL_LOG_H_
#define _WL_LOG_H_

#include <sys/alt_stdio.h>
#include <string.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>


/* Initialize log internals. */
void log_init(void);

#if LOG_ENABLE == 1

#   define logout(_LVL_, ...) alt_printf(__VA_ARGS__); alt_putstr("\r\n")
#   define logflush()

#else

#   define logout(_LVL_, ...)
#   define logflush()
#endif

#endif // _WL_LOG_H_
