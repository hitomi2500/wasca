#ifndef _SETTINGS_H_
#define _SETTINGS_H_

#include <stdio.h>

/* Inclusion of base settings for MAX 10. */
#include "wasca_defs.h"


/*
 * ------------------------------------------
 * - Public definitions.                    -
 * - (Shared with other modules)            -
 * ------------------------------------------
 */


/**
 * Settings structure.
 * This is set by this module, and read by other ones.
**/
typedef struct _wasca_settings_t
{
    /* Base settings for MAX 10. */
    wl_baseset_max_t max;

    /* Log level.
     * 
     * Name : [Log]Level
     */
    long log_level;

    /* Log file maximum size.
     * Unit : byte
     *
     * Examples :
     * -  0 : no size limit
     * - 10 : maximum 10 KB
     *
     * Name : [Log]MaxSize
     * Note : Value in ini file is written in KB unit.
     */
    long log_max_size;

    /* Log destination output flags.
     * Zero: disable, 1/else: enable
     *
     * Names :
     *  - [Log]ToUart : output to debug UART
     *  - [Log]ToUsb  : output via USB port
     *  - [Log]ToSd   : output to file on SD card
     */
    long log_to_uart;
    long log_to_usb;
    long log_to_sd;

    /* Log flush interval.
     * Maximum time until messages pending in buffer are written to SD card.
     * Unit : msec
     *
     * Examples :
     *  -   0: write log messages one by one
     *  - 500: gather and then write messages every 500 milliseconds
     *
     * Name : [Log]FlushInterval
     */
    long flush_interval;

} wasca_settings_t;

extern wasca_settings_t _wasca_set;


/**
 * settings_init
 *
 * Reset settings to default value.
 * This must be called at very beginning of application startup.
**/
void settings_init(void);


/**
 * settings_read
 *
 * Read and parse settings file.
 * This should be called during application startup, when SD card access is ready.
**/
void settings_read(void);


/*
 * ------------------------------------------
 * - Module internals customization.        -
 * - (Used in this module only)             -
 * ------------------------------------------
 */

/* Maximum length of a setting line.
 * Characters outside of this range are ignored, so this must be large enough
 * for example if setting file file name or full path etc.
 */
#define INI_LINE_MAXLEN 256

/* Setting file read buffer length.
 * The larger the faster the file is read, but it impacts stack memory usage.
 */
#define INI_READBUFF_LEN 64


#endif // _SETTINGS_H_
