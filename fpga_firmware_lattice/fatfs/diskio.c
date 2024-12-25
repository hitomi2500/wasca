/*-----------------------------------------------------------------------*/
/* Low level disk I/O module SKELETON for FatFs     (C)ChaN, 2019        */
/*-----------------------------------------------------------------------*/
/* If a working storage control module is available, it should be        */
/* attached to the FatFs via a glue function rather than modifying it.   */
/* This is an example of glue functions to attach various exsisting      */
/* storage control modules to the FatFs module with a defined API.       */
/*-----------------------------------------------------------------------*/

#include "ff.h"			/* Obtains integer types */
#include "diskio.h"		/* Declarations of disk functions */
#include "mmc.h"		/* Declarations of disk functions */
#include "ocsdc.h"

/* Definitions of physical drive number for each drive */
#define DEV_MMC		0

struct mmc drv;
struct ocsdc priv;

/*-----------------------------------------------------------------------*/
/* Get Drive Status                                                      */
/*-----------------------------------------------------------------------*/

DSTATUS disk_status (
	BYTE pdrv		/* Physical drive nmuber to identify the drive */
)
{
	DSTATUS stat;
	int result;

	switch (pdrv) {
	case DEV_MMC :
		result = 0;//MMC_disk_status();

		// translate the reslut code here

		return stat;
	}
	return STA_NOINIT;
}



/*-----------------------------------------------------------------------*/
/* Inidialize a Drive                                                    */
/*-----------------------------------------------------------------------*/

DSTATUS disk_initialize (
	BYTE pdrv				/* Physical drive nmuber to identify the drive */
)
{
	DSTATUS stat;

	switch (pdrv) {
	case DEV_MMC :

		//init ocsdc driver
		ocsdc_mmc_init(&drv, &priv, 0x03000000, 25000000);

		drv.has_init = 0;
		int err = mmc_init(&drv);
		if (err != 0 || drv.has_init == 0) {
			print("mmc_init failed\n\r");
			return STA_NOINIT;
		}
		return 0;
	}
	return STA_NOINIT;
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
	DRESULT res;
	BYTE tmp;

	switch (pdrv) {
	case DEV_MMC :
		int size = mmc_bread(&drv, sector, count, buff);
		res = (size == count) ? RES_OK : RES_NOTRDY;
		if (RES_OK == res)
		{
			//uncsramble data
			print("no unscramble \n\r");
			/*for (int i=0;i<count*512;i+=4)
			{
				tmp = buff[i+0];
				buff[i+0] = buff[i+3];
				buff[i+3] = tmp;
				tmp = buff[i+1];
				buff[i+1] = buff[i+2];
				buff[i+2] = tmp;
			}*/
		}
		else
		{
			print("res = ");			
			print_hex(res);
			print(" size = ");			
			print_hex(size);
			print(" \n\r");			
		}
		return res;
	}

	return RES_PARERR;
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
	DRESULT res;
	int result;

	switch (pdrv) {
	case DEV_MMC :
		//TODO: implement write
		return 0;//res;
	}

	return RES_PARERR;
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
	DRESULT res;
	int result;

	switch (pdrv) {
	case DEV_MMC :

		// is it necessary?

		return 0;//res;
	}

	return RES_PARERR;
}

