/*-----------------------------------------------------------------------*/
/* Low level disk I/O module SKELETON for FatFs     (C)ChaN, 2025        */
/*-----------------------------------------------------------------------*/
/* If a working storage control module is available, it should be        */
/* attached to the FatFs via a glue function rather than modifying it.   */
/* This is an example of glue functions to attach various exsisting      */
/* storage control modules to the FatFs module with a defined API.       */
/*-----------------------------------------------------------------------*/

#include "ff.h"			/* Basic definitions of FatFs */
#include "diskio.h"		/* Declarations FatFs MAI */
#include "sdiodrv.h"
#include "diskiodrvr.h"

#ifdef	STDIO_DEBUG
#include <stdio.h>
#define	DBGPRINTF	printf
#else
#define	DBGPRINTF	null
#endif

static inline	void	null(char *s,...) {}

/* Example: Mapping of physical drive number for each drive */
#define DEV_RAM 	0	/* Map FTL to physical drive 0 */
#define DEV_MMC		1	/* Map MMC/SD card to physical drive 1 */
#define DEV_USB		2	/* Map USB MSD to physical drive 2 */


/*-----------------------------------------------------------------------*/
/* Get Drive Status                                                      */
/*-----------------------------------------------------------------------*/

DSTATUS disk_status (
	BYTE pdrv		/* Physical drive nmuber to identify the drive */
)
{
	unsigned	stat = 0;
	if (pdrv >= MAX_DRIVES || NULL == DRIVES[pdrv].fd_addr
			|| NULL == DRIVES[pdrv].fd_driver)
		return STA_NODISK;
	if (NULL == DRIVES[pdrv].fd_data)
		DRIVES[pdrv].fd_data= (DRIVES[pdrv].fd_driver->dio_init)(
					DRIVES[pdrv].fd_data);
	if (NULL == DRIVES[pdrv].fd_data
		|| RES_OK != (*DRIVES[pdrv].fd_driver->dio_ioctl)(
			DRIVES[pdrv].fd_data,
					MMC_GET_SDSTAT, (char *)&stat))
		stat = STA_NODISK;

	return	stat;
}




/*-----------------------------------------------------------------------*/
/* Inidialize a Drive                                                    */
/*-----------------------------------------------------------------------*/

DSTATUS disk_initialize (
	BYTE pdrv				/* Physical drive nmuber to identify the drive */
)
{
	if (pdrv >= MAX_DRIVES || NULL == DRIVES[pdrv].fd_addr
			|| NULL == DRIVES[pdrv].fd_driver) {
		return STA_NODISK;
	} else if (NULL != DRIVES[pdrv].fd_data
		|| NULL != (DRIVES[pdrv].fd_data
				= (*DRIVES[pdrv].fd_driver->dio_init)(
					DRIVES[pdrv].fd_addr))) {
		return RES_OK;
	} else
		return STA_NODISK;
}



/*-----------------------------------------------------------------------*/
/* Read Sector(s)                                                        */
/*-----------------------------------------------------------------------*/

DRESULT disk_read (
	BYTE pdrv,		/* Physical drive nmuber to identify the drive */
	BYTE *buff,		/* Data buffer to store read data */
	LBA_t sector,	/* Start sector in LBA */
	UINT count		/* Number of sectors to read */
)
{
	if (pdrv >= MAX_DRIVES || NULL == DRIVES[pdrv].fd_addr
			|| NULL == DRIVES[pdrv].fd_driver)
		return RES_ERROR;
	return (*DRIVES[pdrv].fd_driver->dio_read)(DRIVES[pdrv].fd_data,
					sector, count, buff);
}



/*-----------------------------------------------------------------------*/
/* Write Sector(s)                                                       */
/*-----------------------------------------------------------------------*/

#if FF_FS_READONLY == 0

DRESULT disk_write (
	BYTE pdrv,			/* Physical drive nmuber to identify the drive */
	const BYTE *buff,	/* Data to be written */
	LBA_t sector,		/* Start sector in LBA */
	UINT count			/* Number of sectors to write */
)
{
	if (pdrv >= MAX_DRIVES || NULL == DRIVES[pdrv].fd_addr
			|| NULL == DRIVES[pdrv].fd_driver)
		return RES_ERROR;
	return (*DRIVES[pdrv].fd_driver->dio_write)(DRIVES[pdrv].fd_data,
					sector, count, buff);
	return (*DRIVES[pdrv].fd_driver->dio_ioctl)(DRIVES[pdrv].fd_data,
						cmd, buff);
}

#endif


/*-----------------------------------------------------------------------*/
/* Miscellaneous Functions                                               */
/*-----------------------------------------------------------------------*/

DRESULT disk_ioctl (
	BYTE pdrv,		/* Physical drive nmuber (0..) */
	BYTE cmd,		/* Control code */
	void *buff		/* Buffer to send/receive control data */
)
{
	if (pdrv >= MAX_DRIVES || NULL == DRIVES[pdrv].fd_addr
			|| NULL == DRIVES[pdrv].fd_driver)
		return RES_ERROR;
	return (*DRIVES[pdrv].fd_driver->dio_ioctl)(DRIVES[pdrv].fd_data,
						cmd, buff);
}

