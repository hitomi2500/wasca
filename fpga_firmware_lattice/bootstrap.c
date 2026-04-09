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
    //reg_uart_clkdiv = 217;// 115200 baud at 25MHz
    //reg_uart_clkdiv = 347;// 115200 baud at 40MHz
    reg_uart_clkdiv = 434;//432;//434;// 115200 baud at 50MHz
    //reg_uart_clkdiv = 1155;// 115200 baud at 133MHz

	//volatile uint32_t* p32 = (uint32_t*) 0;

	uint32_t seed = 0x100500;
	uint32_t errors = 0;

	//mini_printf("Bootstrap start\r\n");
	mini_printf("Boot");

	//set mapper register
	LED = 0x01;//test start marker
	volatile uint32_t * pWishboneRegs = (uint32_t *)0x01000000;
	pWishboneRegs[0x9] = 0xFFFFFFFF;//read mapper for CS0
	pWishboneRegs[0xa] = 0x00000000;//read mapper for CS1 + CS2
	pWishboneRegs[0xb] = 0xFFFFFFFF;//write mapper for CS0
	pWishboneRegs[0xc] = 0x00000000;//write mapper for CS1 + CS2
	LED = 0x00;//test start marker

	volatile uint32_t a;

	//wishbone regs write test
	LED = 0x02;//test start marker
	pWishboneRegs[0] = 0x87654321;//PCNTR
	pWishboneRegs[1] = 0xdeadbeef;//STATUS
	pWishboneRegs[4] = 0xfeedbead;//SWREG
	a = pWishboneRegs[0];
	if (a != 0x00004321)
		mini_printf("WREG ERR1\r\n");
	a = pWishboneRegs[1];
	if (a != 0x0000beef)
		mini_printf("WREG ERR2\r\n");
	a = pWishboneRegs[4];
	if (a != 0x0000bead)
		mini_printf("WREG ERR3\r\n");
	LED = 0x00;//test end marker

	mini_printf("SDRAM test...\r\n");
	//mini_printf("S\r\n");
	//sdram test
	volatile uint32_t * pSDRAM = (uint32_t *)0x10000000;
	volatile uint32_t * pSDRAM2 = (uint32_t *)0x14000000;
	
	//quicktest first
	LED = 0x03;//test start marker
	//CS0
	pSDRAM[0] = 0x12345678;
	for (int i=0;i<24;i++)
		pSDRAM[1<<i] = 0x11111111*i;
	pSDRAM[0xffffff] = 0xdeafface;
	a = pSDRAM[0];
	if (a != 0x00005678)
		mini_printf("SDRAM QUICK error: addr %x write %x read %x\r\n",0,0x00005678,a);
	for (int i=0;i<24;i++) {
		a = pSDRAM[1<<i];
		if (a !=((0x1111*i) & 0xFFFF))
			mini_printf("SDRAM QUICK error: addr %x write %x read %x\r\n",1<<i,((0x1111*i) & 0xFFFF),a);
	}
	a = pSDRAM[0xffffff];
	if (a != 0x0000face)
		mini_printf("SDRAM QUICK error: addr %x write %x read %x\r\n",0xffffff,0x0000face,a);
	//CS1
	/*pSDRAM2[0] = 0x23456789;
	for (int i=0;i<23;i++)
		pSDRAM2[1<<i] = 0x10101010*i;
	pSDRAM2[0x7fffff] = 0xdeadbeef;
	a = pSDRAM2[0];
	if (a != 0x0006789)
		mini_printf("SDRAM2 QUICK error: addr %x write %x read %x\r\n",0,0x0006789,a);
	for (int i=0;i<23;i++) {
		a = pSDRAM2[1<<i];
		if (a !=((0x1010*i) & 0xFFFF))
			mini_printf("SDRAM2 QUICK error: addr %x write %x read %x\r\n",1<<i,((0x1010*i) & 0xFFFF),a);
	}
	a = pSDRAM2[0x7fffff];
	if (a != 0x0000beef)
		mini_printf("SDRAM2 QUICK error: addr %x write %x read %x\r\n",0x7fffff,0x0000beef,a);*/
	LED = 0x00;//test start marker

	//full sdram test
	LED = 0x04;//test start marker
	//starting with CS0
	/*seed = 0x100500;
	for (int i =0; i < (0x2000000/sizeof(uint32_t)); i++)
	{
		pSDRAM[i] = (seed&0xFFFF);
		seed = lsfr_next_random(seed);
		if (i%0x40000 == 0x3ffff)
			mini_printf("SDRAM test: write pass addr %x \r\n",i*4+4);
	}
	seed = 0x100500;
	errors = 0;
	uint32_t readback;
	for (int i =0; i < (0x2000000/sizeof(uint32_t)); i++)
	{
		readback = pSDRAM[i];
		if (readback != (seed&0xFFFF)) {\
			if (errors < 16)
				mini_printf("SDRAM error: addr %x write %x read %x\r\n",i*4,(seed&0xFFFF),readback);
			errors++;
		}
		seed = lsfr_next_random(seed);
		if (i%0x40000 == 0x3ffff)
			mini_printf("SDRAM test: read pass addr %x \r\n",i*4+4);
	}*/
	LED = 0x05;//test start marker
	//now CS1
	/*seed = 0x100500;
	for (int i =0; i < (0x1000000/sizeof(uint32_t)); i++)
	{
		pSDRAM2[i] = (seed&0xFFFF);
		seed = lsfr_next_random(seed);
		if (i%0x40000 == 0x3ffff)
			mini_printf("SDRAM2 test: write pass addr %x \r\n",0x4000000+i*4+4);
	}
	seed = 0x100500;
	errors = 0;
	for (int i =0; i < (0x1000000/sizeof(uint32_t)); i++)
	{
		readback = pSDRAM2[i];
		if (readback != (seed&0xFFFF)) {\
			if (errors < 16)
				mini_printf("SDRAM2 error: addr %x write %x read %x\r\n",i*4,(seed&0xFFFF),readback);
			errors++;
		}
		seed = lsfr_next_random(seed);
		if (i%0x40000 == 0x3ffff)
			mini_printf("SDRAM2 test: read pass addr %x \r\n",0x4000000+i*4+4);
	}*/
	LED = 0x00;//test end marker
	mini_printf("SDRAM test DONE\r\n");
	
	mini_printf("%s %s\r\n",__DATE__,__TIME__);

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
