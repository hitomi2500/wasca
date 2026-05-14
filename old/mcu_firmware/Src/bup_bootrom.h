#ifndef _WL_BUP_BOOTROM_H_
#define _WL_BUP_BOOTROM_H_

#include "main.h"
#include "stm32f4xx_hal.h"

#include "wasca_defs.h"


/**
 * bup_boot_init
 *
 * Initialize boot ROM and backup memory module internals.
 *
 * Must be called on STM32 startup.
**/
void bup_boot_init(void);



/*
 * ------------------------------------------
 * - Cartridge boot ROM file access. --------
 * ------------------------------------------
 */


/**
 * bootrom_pre_process / bootrom_post_process
 *
 * Do cartridge boot ROM file access.
 *
 * "Pre" stage concerns the preparation of data block to MAX 10.
 * "Post" stage concerns the processing of data block received from MAX 10.
**/
void bootrom_pre_process(wl_spi_header_t* hdr, void* data_tx);
void bootrom_post_process(wl_spi_header_t* hdr, void* data_rx);




/*
 * ------------------------------------------
 * - Backup memory file access. -------------
 * ------------------------------------------
 */


/**
 * bup_periodic_check
 *
 * Check status of backup related buffer and eventually flush
 * its contents to SD card when necessary.
 *
 * Must be called as frequently as possible during STM32 execution.
**/
void bup_periodic_check(void);


/**
 * bup_file_pre_process / bup_file_post_process
 *
 * Do backup memory file access according to SPI packet contents.
 *
 * "Pre" stage concerns the preparation of data block to MAX 10.
 * "Post" stage concerns the processing of data block received from MAX 10.
**/
void bup_file_pre_process(wl_spi_header_t* hdr, void* data_tx);
void bup_file_post_process(wl_spi_header_t* hdr, void* data_rx);


#endif // _WL_BUP_BOOTROM_H_
