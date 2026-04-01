#include <stdlib.h>
#include <stdint.h>
#include "fatfs/ff.h"
#include "fatfs/sdiodrv.h"
#include "fatfs/diskio.h"
#include "mini-printf.h"

#define LED (*(volatile uint32_t*)0x02000000)

#define reg_uart_clkdiv (*(volatile uint32_t*)0x02000004)
//#define reg_uart_data (*(volatile uint32_t*)0x02000008)

#define BLKSIZE 512
#define BLKCNT 10

FATFS FatFs;		/* FatFs work area needed for each volume */
FIL Fil;			/* File object needed for each open file */

PARTITION VolToPart[FF_VOLUMES] = {
    {0, 1},     /* 1st partition on the pd#0 */
};

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

	uint32_t seed = 0x100500;
	uint32_t errors = 0;

	mini_printf("Bootstrap %s %s\r\n",__DATE__,__TIME__);

	//sdram test
	LED = 0xFF;//test start marker
	volatile uint32_t * pSDRAM = (uint32_t *)0x10000000;
	pSDRAM[0] = 0x12345678;
	for (int i=0;i<24;i++)
		pSDRAM[1<<i] = 0x11111111*i;
	pSDRAM[0x1ffffff] = 0xdeafface;
	volatile uint32_t a = pSDRAM[0];
	for (int i=0;i<24;i++)
		a = pSDRAM[1<<i];
	a = pSDRAM[0x1ffffff];
	LED = 0x00;//test end marker

	mini_printf("SDRAM test complete\r\n");

	//init sdio driver
	/*struct SDIODRV * drv;
	struct SDIO * sdio_dev_ptr = (SDIO *)0x03000000;
	drv = sdio_init(sdio_dev_ptr);

	if (NULL == drv) {
		mini_printf("SDIO init failed\r\n");
		return -1;
	}
	else
	{
		mini_printf("SDIO init OK\r\n");
	}*/

	//read some blocks

	/*for (int k=0;k<16;k++)
	{ 
		if (sdio_read(drv, k, 1, buff) != RES_OK) {
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
		mini_printf("dumping data at addr=0x%x\r\n",k*512);
		for (int j=0;j<32;j++) {
				for (int i=0;i<16;i++){
					uint8_t code = buff[j*16+i];
					mini_printf("%2x ",code);
				}
				mini_printf("\r\n");
			}
	}
	while (1);//halt*/

	FRESULT fr = f_mount(&FatFs, "0:/", 1);	//mount SD card
	if (fr != FR_OK)
	{
		mini_printf("mount error %x \r\n",fr);
	}
	else
		mini_printf("mount OK\r\n");

	DIR _dir;
	fr = f_opendir(&_dir, "/");
	if (fr != FR_OK)
	{
		mini_printf("opendir error %x \r\n",fr);
	}
	else
		mini_printf("opendir OK\r\n");

	FILINFO _filinfo;
	_filinfo.fname[0] = 'A';
	
	while (_filinfo.fname[0] != 0) {
		fr = f_readdir(&_dir,&_filinfo);
		/*if (fr != FR_OK)
		{
			mini_printf("f_readdir error %x \r\n",fr);
		}
		else
			mini_printf("f_readdir OK\r\n");*/
		mini_printf("Found file:%s (%d)\r\n",_filinfo.fname,_filinfo.fsize);
	}

	int led_toggle = 1;
    while (1) {
        LED = led_toggle;
		led_toggle*=2;
		if (led_toggle > 0x20) led_toggle = 1;
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
