#include <stdlib.h>
#include <stdint.h>
#include "fatfs/ff.h"
#include "fatfs/sdiodrv.h"
#include "fatfs/diskio.h"

#define LED (*(volatile uint32_t*)0x02000000)

#define reg_uart_clkdiv (*(volatile uint32_t*)0x02000004)
//#define reg_uart_data (*(volatile uint32_t*)0x02000008)

#define BLKSIZE 512
#define BLKCNT 10

FATFS FatFs;		/* FatFs work area needed for each volume */
FIL Fil;			/* File object needed for each open file */

char buff[BLKSIZE*BLKCNT];

void delay() {
    //for (volatile int i = 0; i < 2500000; i++)
    for (volatile int i = 0; i < 750000; i++)
    //for (volatile int i = 0; i < 250; i++)
        ;
}

uint32_t lsfr_next_random (uint32_t prev)
{
	if ( ((prev&0x80000000)/0x80000000)^((prev&0x40000000)/0x40000000)^((prev&0x10)/0x10)^((prev&0x8)/0x8) )
		return  (prev & 0x7FFFFFFF)* 2 + 1;
	else 
		return  (prev & 0x7FFFFFFF)* 2;
}

int main() {
	LED = 0x20;//red external
    reg_uart_clkdiv = 217;// 115200 baud at 25MHz
    //reg_uart_clkdiv = 1155;// 115200 baud at 133MHz

	volatile uint32_t* p32 = (uint32_t*) 0;
	/*int i;
	p32 = (uint32_t*) 0x03000000;
	for (i=0;i<8;i++)
		p32[i] = i*0x01241111;
	volatile uint32_t v32;
	//mini_printf("Dumping SDIO regs...\r\n");
	mini_printf("\r\n");
	for (i=0;i<8;i++)
	{
		mini_printf(" %d %x\r\n",i,p32[i]);
	}*/

	uint32_t seed = 0x100500;
	uint32_t errors = 0;

	mini_printf("Starting bootstrap...\r\n");

	//init ocsdc driver
	struct SDIODRV * drv;
	struct SDIO * sdio_dev_ptr = (SDIO *)0x03000000;
	drv = sdio_init(sdio_dev_ptr);
	//putchar(0x01);

	if (NULL == drv) {
		mini_printf("SDIO init failed\r\n");
		return -1;
	}
	else
	{
		mini_printf("SDIO init OK\r\n");
	}
	/*while(1)
	{
		int err = mmc_init(&drv);
		if (err != 0 || drv.has_init == 0) {
			mini_printf("mmc_init failed with error %x\r\n".code);
		}
		else
		{
			mini_printf("mmc_init OK\r\n");
		}
		LED = 0x20;//red external
		delay();
		LED = 0x0;//off
		delay();
	}*/
	//putchar(0x02);

	//read 1 block
	mini_printf("attempting to read block %x\r\n",0);
	//while (mmc_bread(&drv, k, 1, buff) != 1) {
	if (sdio_read(drv, 0, 1, buff) != RES_OK) {
		mini_printf("sdio_read failed\r\n");
	}
	else
		mini_printf("sdio_read OK\r\n");

	//unscrambling data
	uint8_t c;
	for (int i=0;i<512;i+=4){
		c = buff[i];
		buff[i] = buff[i+3];
		buff[i+3] = c;
		c = buff[i+1];
		buff[i+1] = buff[i+2];
		buff[i+2] = c;
	}

	//dumping data
	mini_printf("dumping data:\r\n");

	for (int j=0;j<32;j++) {
		for (int i=0;i<16;i++){
			uint8_t code = buff[j*16+i];
			mini_printf("%2x ",code);
		}
		mini_printf("\r\n");
	}

	while (1);//halt

	FRESULT fr = f_mount(&FatFs, "", 0);	//mount SD card
	if (fr != FR_OK)
	{
		mini_printf("mount error %x \r\n",fr);
	}

	DIR _dir;
	fr = f_opendir(&_dir, "/");
	if (fr != FR_OK)
	{
		mini_printf("opendir error %x \r\n",fr);
	}

	FILINFO _filinfo;
	f_readdir(&_dir,&_filinfo);
	if (fr != FR_OK)
	{
		mini_printf("f_readdir error %x \r\n",fr);
	}	

	for (int i=0;i<10;i++)
	{
		disk_read(0,buff,0,1);
	}

	fr = f_opendir(&_dir, "/");
	if (fr != FR_OK)
	{
		mini_printf("opendir error %x \r\n",fr);
	}

	f_readdir(&_dir,&_filinfo);
	if (fr != FR_OK)
	{
		mini_printf("f_readdir error %x \r\n",fr);
	}	

	mini_printf("FIRST FOUND:%i\r\n",_filinfo.fname);

    while (1) {
        //LED = 0xFF;
        delay();
        //LED = 0x00;
        delay();
		/*
		//mini_printf("Verifying ram beyond 0x1000\r\n");
		mini_printf("VV\r\n");
		//writing
		i = 0x1000/sizeof(uint32_t);
		seed = 0x100500;
		//while ( i < (0x10000/sizeof(uint32_t)) )
		while ( i < (0x1300/sizeof(uint32_t)) )
		{
			p32[i] = seed;
			i++;
			seed = lsfr_next_random(seed);
		}
		//reading
		i = 0x1000/sizeof(uint32_t);
		seed = 0x100500;
		errors = 0;
		//while ( i < (0x10000/sizeof(uint32_t)) )
		while ( i < (0x1300/sizeof(uint32_t)) )
		{
			if (p32[i] != seed)
			{
				errors++;
				if (errors < 10)
				{
					uint32_t addr = i*sizeof(uint32_t);
					mini_printf("Error at address %x\r\n",addr);
				}
			}
			i++;
			seed = lsfr_next_random(seed);
		}
		mini_printf("Verifying complete\r\n");*/
    }
}
