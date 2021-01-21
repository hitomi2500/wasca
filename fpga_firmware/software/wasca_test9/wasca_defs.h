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
 * (Disabling logs saves few KBs of memory usage)
 */
#   define LOG_ENABLE 1


#endif // _WASCA_DEFS_H_
