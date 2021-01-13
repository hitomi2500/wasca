#ifndef _WASCA_DEFS_H_
#define _WASCA_DEFS_H_

#include <system.h>
#include <sys/alt_stdio.h>

/* Link related inclusion.
 *
 * The wasca_link.h header below is shared
 * between both PC and Nios sides, hence the #define
 * below is needed.
 */
#include "satcom_lib/wasca_link.h"


/* Log enable/disable switch :
 *  - 0 : disable all logs
 *  - 1 : enable logging
 *
 * Note : this is automatically enabled when
 *        UART is instanced on Qsys.
 */
#ifdef __ALTERA_AVALON_UART
#   define LOG_ENABLE 1
#else
#   define LOG_ENABLE 0
#endif


#endif // _WASCA_DEFS_H_
