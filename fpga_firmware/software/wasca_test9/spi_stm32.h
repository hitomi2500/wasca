#ifndef _WL_SPI_STM32_H_
#define _WL_SPI_STM32_H_

#include <sys/alt_stdio.h>
#include <string.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>

#include "wasca_defs.h"


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
 * spi_exc_version
 * 
 * Send MAX 10 firmmware version, and receive STM32's.
 *
 * About each parameters :
 *  - wl_verinfo_max_t* max_ver : MAX 10 firmware version   [OUT]
 *      It is set in this function, and can be copied to specified pointer if it is not NULL.
 *  - wl_verinfo_stm_t* arm_ver : STM32 firmware version    [OUT]
 *      Returned after calling this function.
**/
void spi_exc_version(wl_verinfo_max_t* max_ver, wl_verinfo_stm_t* arm_ver);


/**
 * spi_send_logs
 * 
 * Send log message(s) to STM32.
 *
 * About each parameters :
 *  - logdata : log message(s) themselves.
 *  - datalen : log message(s) length, in byte unit.
 *              this length doesn't includes terminating null character.
**/
void spi_send_logs(unsigned char* logdata, unsigned short datalen);


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
int spi_bup_open(unsigned short len_kb);
int spi_bup_read(unsigned short block, unsigned short len, unsigned char* data);
int spi_bup_write(unsigned short block, unsigned short len, unsigned char* data);
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
void spi_boot_getinfo(unsigned char rom_id, wl_spi_bootinfo_t* info);


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
**/
void spi_boot_readdata(unsigned char rom_id, unsigned long offset, unsigned long len, unsigned char* dst);


#endif // _WL_SPI_STM32_H_
