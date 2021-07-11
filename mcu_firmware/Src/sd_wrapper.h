#ifndef _WL_SD_WRAPPER_H_
#define _WL_SD_WRAPPER_H_

#include "main.h"
#include "stm32f4xx_hal.h"

#include "wasca_defs.h"

#include "fatfs.h"
#include "sd_wrapper.h"



/*
 * ------------------------------------------
 * - SD card/FatFs wrapper. -----------------
 * ------------------------------------------
 */

/* Global variable(s). */
extern int _sdcard_available;


/* Initialize SD card access. */
void sdcard_reset(void);
void sdcard_init(void);

#endif // _WL_SD_WRAPPER_H_
