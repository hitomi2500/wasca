#include <stdlib.h>
#include <stdint.h>
#include "fatfs/ff.h"
#include "fatfs/sdiodrv.h"

#define LED (*(volatile uint32_t*)0x02000000)

#define reg_uart_clkdiv (*(volatile uint32_t*)0x02000004)
#define reg_uart_data (*(volatile uint32_t*)0x02000008)

#define BLKSIZE 512
#define BLKCNT 10

FATFS FatFs;		/* FatFs work area needed for each volume */
FIL Fil;			/* File object needed for each open file */

char buff[BLKSIZE*BLKCNT];

void putchar(char c)
{
    if (c == '\n')
        putchar('\r');
    reg_uart_data = c;
}

void print(const char *p)
{
    while (*p)
        putchar(*(p++));
}

void print_hex(uint8_t value)
{
	uint8_t code = (value>>4);
	if (code < 10)
		putchar(code+'0');
	else 
		putchar(code+'A'-10);
	code = value & 0xF;
	if (code < 10)
		putchar(code+'0');
	else 
		putchar(code+'A'-10);
}

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
	uint32_t* p32 = (uint32_t*) 0;
	uint32_t seed = 0x100500;
	uint32_t errors = 0;
	int i;
	LED = 0x20;//red external
    reg_uart_clkdiv = 217;// 115200 baud at 25MHz
    //reg_uart_clkdiv = 1155;// 115200 baud at 133MHz
	print("\r\nStarting bootstrap...\r\n");

	//init ocsdc driver
	struct SDIODRV * drv;
	struct SDIO * sdio_dev_ptr = (SDIO *)0x03000000;
	drv = sdio_init(sdio_dev_ptr);
	//putchar(0x01);

	if (NULL == drv) {
		print("SDIO init failed\r\n");
		return -1;
	}
	else
	{
		print("SDIO init OK\r\n");
	}
	/*while(1)
	{
		int err = mmc_init(&drv);
		if (err != 0 || drv.has_init == 0) {
			print("mmc_init failed with error ");
			uint8_t code = err & 0xF;
			if (code < 10)
				putchar(code+'0');
			else 
				putchar(code+'A'-10);
			code = err>>4;
			if (code < 10)
				putchar(code+'0');
			else 
				putchar(code+'A'-10);
			print("\n\r");
		}
		else
		{
			print("mmc_init OK\n\r");
		}
		LED = 0x20;//red external
		delay();
		LED = 0x0;//off
		delay();
	}*/
	//putchar(0x02);

	//print_mmcinfo(&drv);

	//for (int i=0;i<4;i++)
	int k=0;

	{

	//read 1 block
	print("attempting to read block ");
	if ((k>>4) > 9)
		putchar('A'+(k>>4)-10);
	else
		putchar('0'+k>>4);
	if ((k&0xF) > 9)
		putchar('A'+(k&0xF)-10);
	else
		putchar('0'+(k&0xF));
	print("\r\n");
	//while (mmc_bread(&drv, k, 1, buff) != 1) {
	while (sdio_read(&drv, 0, 1, buff) != 1) {
		print("sdio_read failed\r\n");
		//return -1;
	}
	//putchar(0x3);

	//dumping data
	//for (int f=0;f<4;f++)
	//	print("Next attempt:\n\r");

		for (int j=0;j<32;j++) {
			for (int i=0;i<16;i++){
				uint8_t code = buff[j*32+(i&0xC)+(3-i&0x3)] >> 4;
				if (code < 10)
					putchar(code+'0');
				else 
					putchar(code+'A'-10);
				code = buff[j*16+(i&0xC)+(3-i&0x3)] & 0xF;
				if (code < 10)
					putchar(code+'0');
				else 
					putchar(code+'A'-10);
				print(" ");
			}
			print("\n\r");
		}
	//}

	}

	while (1);//halt

	FRESULT fr = f_mount(&FatFs, "", 0);	//mount SD card
	if (fr != FR_OK)
	{
		print("mount error ");
		print_hex(fr);
		print(" \r\n");
	}

	DIR _dir;
	fr = f_opendir(&_dir, "/");
	if (fr != FR_OK)
	{
		print("opendir error ");
		print_hex(fr);
		print(" \r\n");
	}

	FILINFO _filinfo;
	f_readdir(&_dir,&_filinfo);
	if (fr != FR_OK)
	{
		print("f_readdir error ");
		print_hex(fr);
		print(" \r\n");
	}	

	for (int i=0;i<10;i++)
	{
		disk_read(0,buff,0,1);
	}

	/*int res;
	for (int i=0;i<16;i++)
	{
		res = disk_read(0,buff,i,1);
		if (0 == res)
		{
			print("read ");
			print_hex(i);
			print(" ok \n\r");
			//dumping data
			for (int j=0;j<16;j++) {
				for (int i=0;i<16;i++){
					print_hex(buff[j*16+i]);
					print(" ");
				}
				print("\n\r");
			}
		}
		else
		{
			print("read ");
			print_hex(i);
			print(" error ");			
			print_hex(res);
			print(" \n\r");			
		}
	}*/
		



	fr = f_opendir(&_dir, "/");
	if (fr != FR_OK)
	{
		print("opendir error ");
		print_hex(fr);
		print(" \r\n");
	}

	f_readdir(&_dir,&_filinfo);
	if (fr != FR_OK)
	{
		print("f_readdir error ");
		print_hex(fr);
		print(" \r\n");
	}	

	print("FIRST FOUND:");
	print(_filinfo.fname);
	print("\r\n");

	//fr = f_open(&Fil, "\\firmware.bin", FA_READ | FA_OPEN_ALWAYS);	/* Create a file */
	//UINT readen;
	//if (fr == FR_OK) {
		//f_read(&Fil,buff,sizeof(buff),&readen);
		//f_write(&Fil, "It works!\r\n", 11, &bw);	/* Write data to the file */
		//fr = f_close(&Fil);							/* Close the file */
		//dumping first 256 bytes
		/*for (int j=0;j<16;j++) {
			for (int i=0;i<16;i++){
				uint8_t code = buff[j*16+(i&0xC)+(3-i&0x3)] >> 4;
				if (code < 10)
					putchar(code+'0');
				else 
					putchar(code+'A'-10);
				code = buff[j*16+(i&0xC)+(3-i&0x3)] & 0xF;
				if (code < 10)
					putchar(code+'0');
				else 
					putchar(code+'A'-10);
				print(" ");
			}
			print("\n\r");
		}*/
		LED = 0x40;//blue external
	/*}
	else
	{
		print("firmware.bin not found\n\r");
		//LED = 0x20;//red external
		LED = 0x08;//green external
	}*/


    while (1) {
        //LED = 0xFF;
        delay();
        //LED = 0x00;
        delay();
		/*
		//print("Verifying ram beyond 0x1000\n");
		print("VV\n");
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
					print("Error at address ");
					for (int j=0;j<8;j++)
					{
						uint8_t code = (addr&(0xF0000000>>(j*4))) >> ((7-j)*4);
						if (code < 10)
							putchar(code+'0');
						else 
							putchar(code+'A'-10);
					}
					print("\n");
				}
			}
			i++;
			seed = lsfr_next_random(seed);
		}
		print("Verifying complete\n");*/
    }
}
