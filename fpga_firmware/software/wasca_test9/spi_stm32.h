#ifndef _WL_SPI_STM32_H_
#define _WL_SPI_STM32_H_

#include <sys/alt_stdio.h>
#include <string.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>

#include "wasca_defs.h"

/* SPI related #includes. */
// (nothing really special)


/*
 * ------------------------------------------
 * - SPI stuff ------------------------------
 * ------------------------------------------
 */


/**
 * spi_init
 * 
 * Initialize SPI internals.
 * 
 * Must be called during NIOS startup.
**/
void spi_init(void);


/**
 * spi_get_version
 * 
 * Retrieve STM32 firmware version.
**/
void spi_get_version(wl_spicomm_version_t* ver);


/**
 * spi_mem_read/spi_mem_write
 * 
 * Read/write data from/to STM32 space.
 * 
 * Note : these functions exchange only one SPI packet, so it is
 *        necessary to call these functions several times when
 *        reading or writing data not fitting in one packet.
 * 
 * Returns 1 when no error happened, zero else.
**/
int spi_mem_read(unsigned long addr, unsigned long len, unsigned char* data);
int spi_mem_write(unsigned long addr, unsigned long len, unsigned char* data);


/**
 * spi_bup_open/spi_bup_read/spi_bup_write/spi_bup_close
 *
 * Backup memory related access.
 * 
 * Note : these functions can process only one block (512 bytes)
 *        of backup memory data.
 * 
 * Returns 1 when no error happened, zero else.
**/
int spi_bup_open(unsigned long len_kb);
int spi_bup_read(unsigned long block, unsigned long len, unsigned char* data);
int spi_bup_write(unsigned long block, unsigned long len, unsigned char* data);
int spi_bup_close(void);



/**
 * spi_boot_getinfo
 *
 * Retrieve boot ROM file informations.
 *
 * About each parameters :
 *  - info      : boot ROM file informations.
 *  - full_path : full path of boot ROM on SD card.
 *                It can be either set to NULL or pointing to a
 *                buffer containing WL_MAX_PATH characters.
**/
void spi_boot_getinfo(unsigned char rom_id, wl_spicomm_bootinfo_t* info, char* full_path);


/**
 * spi_boot_readdata
 *
 * Read data from ROM file.
 *
 * About each parameters :
 *  - offset : offset within file, byte unit.
 *  - len    : read data length.
 *             It can't be larger than WL_SPI_DATA_LEN bytes.
 *  - dst    : read destination pointer.
 * 
 * Returns :
 *  - Zero when read operated correctly
 *  - 1 on end of data, or when an error happened.
**/
int spi_boot_readdata(unsigned char rom_id, unsigned long offset, unsigned long len, unsigned char* dst);


#endif // _WL_SPI_STM32_H_
