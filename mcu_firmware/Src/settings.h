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
     *  - 1 : error messages        (WL_LOG_ERROR      )
     *  - 2 : important messages    (WL_LOG_IMPORTANT  )
     *  - 3 : debug messages #1     (WL_LOG_DEBUGEASY  )
     *  - 6 : debug messages #2     (WL_LOG_DEBUGNORMAL)
     *  - 9 : debug messages #3     (WL_LOG_DEBUGHARD  )
     *
     * Example : when level is set to 2, error and important messages are sent.
     * Note #1 : the higher the log level the more program execution slows down.
     * Note #2 : it's not possible to stop output of error messages.
     *
     * Name : [Log]LevelS32
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

    /* Log file count.
     * When current file reachs its size limit, next file is opened until this
     * file count is reached.
     *
     * Examples :
     * -  1 : write to WASCA.LOG file only.
     * -  2 : write to WASCA01.LOG file and then to WASCA02.LOG .
     * - 20 : write to WASCA01.LOG until WASCA20.LOG .
     *
     * Name : [Log]FileCount
     */
    long log_file_count;

    /* UART log control.
     *  - 0 : disable all logs to UART, except error or direct output ones
     *  - 1 : output only logs targeted to UART
     *  - 2 : output logs targeted to UART + copy normal logs to UART
     *
     * Name : [Log]UartModeS32
     */
    long uart_mode;

    /* Log destination output flags.
     * Zero: disable, 1/else: enable
     *
     * Names :
     *  - [Log]ToUsb : output via USB port
     *  - [Log]ToSd  : output to file on SD card
     */
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
     * Name : [Log]FlushIntervalS32
     */
    long flush_interval;

    /* Time stamp output in logs :
     *  - 0 : time stamp output disabled
     *  - 1 : time stamp output enabled
     *
     * (Enabling time stamp output adds a small overhead when formatting logs)
     */
    long log_timestamp;

    /* Backup memory cartridge automatic format.
     * When enabled, backup memory file is automatically initialized
     * with appropriate header so that it's not needed to manually
     * format the cartridge from Save Data Manager.
     *
     * This is an experimental feature, don't use when cartridge is
     * used to store important save data.
     *
     * Values :
     *  -   0: don't format the backup memory data
     *  -   1: format the backup memory data during its file creation
     *
     * Name : [Bup]AutoFormat
     */
    long bup_autoformat;

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
