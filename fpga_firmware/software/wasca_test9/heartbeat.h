#ifndef _WASCA_HEARTBEAT_H_
#define _WASCA_HEARTBEAT_H_

#include <sys/alt_stdio.h>
#include <string.h>
#include <system.h>


/*
 * ------------------------------------------
 * - Heartbeat LED control ------------------
 * ------------------------------------------
 */

/* Direct heartbeat control.
 *  Bit 0-4 : divider value
 *  Bit 5   : Reserved
 *  Bit 6   : LED force value (0:OFF  , 1:ON   )
 *  Bit 7   : LED force flag  (0:blink, 1:force)
 */
#define HEARTBEAT_CONTROL(_DIV_) IOWR(HEARTBEAT_0_BASE, 0, _DIV_)


/* Preset of several divider values :
 *  - 21 -> 54   Hz blink
 *  - 22 -> 28   Hz blink
 *  - 23 -> 14   Hz blink
 *  - 24 ->  7   Hz blink
 *  - 25 ->  3.2 Hz blink
 *  - 26 ->  1.6 Hz blink
 *  - 27 ->  0.8 Hz blink
 */
#define HEARTBEAT_SLOW()   HEARTBEAT_CONTROL(26)
#define HEARTBEAT_MEDIUM() HEARTBEAT_CONTROL(25)
#define HEARTBEAT_FAST()   HEARTBEAT_CONTROL(23)


/* Manual control of heartbeat LED.
 * (0:switch off, 1:turn on)
 */
#define HEARTBEAT_FORCE(_VAL_) IOWR(HEARTBEAT_0_BASE, 0, (1 << 7) | ((_VAL_) << 6))

#endif // _WASCA_HEARTBEAT_H_
