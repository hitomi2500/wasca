#ifndef _WASCA_DEFS_H_
#define _WASCA_DEFS_H_

#include <system.h>
#include <sys/alt_stdio.h>

/* Inclusion of definitions shared between MAX 10 and STM32. */
#include "../../../common/wasca_link_spi.h"


/* Log enable/disable switch :
 *  - 0 : disable all logs
 *  - 1 : enable logging
 *
 * (Disabling logs saves few KBs of memory usage)
 */
#   define LOG_ENABLE 1


#endif // _WASCA_DEFS_H_
