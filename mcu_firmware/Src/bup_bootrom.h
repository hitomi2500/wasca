#ifndef _WL_BUP_BOOTROM_H_
#define _WL_BUP_BOOTROM_H_

#include "main.h"
#include "stm32f4xx_hal.h"

#include "satcom_lib/wasca_link.h"


/*
 * ------------------------------------------
 * - Cartridge boot ROM file access. --------
 * ------------------------------------------
 */


/**
 * bootrom_init
 *
 * Initialize boot ROM access module internals.
 *
 * Must be called on STM32 startup.
**/
void bootrom_init(void);


/**
 * bootrom_process
 *
 * Do cartridge boot ROM file access.
**/
void bootrom_process(wl_spi_pkt_t* pkt_rx, wl_spi_pkt_t* pkt_tx);





/*
 * ------------------------------------------
 * - Backup memory file access. -------------
 * ------------------------------------------
 */


/**
 * bup_init
 *
 * Initialize backup module internals.
 *
 * Must be called on STM32 startup.
**/
void bup_init(void);


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
 * bup_file_process
 *
 * Do backup memory file access according to SPI packet contents.
**/
void bup_file_process(wl_spi_pkt_t* pkt_rx, wl_spi_pkt_t* pkt_tx);


#endif // _WL_BUP_BOOTROM_H_
