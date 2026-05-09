#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "fatfs/ff.h"
#include "fatfs/sdiodrv.h"
#include "fatfs/diskio.h"
#include "mini-printf.h"

#define WISHBONE_REG_PCNTR 0x0
#define WISHBONE_REG_STATUS 0x1
#define WISHBONE_REG_MODE 0x2
#define WISHBONE_REG_HWVER 0x3
#define WISHBONE_REG_SWVER 0x4
#define WISHBONE_REG_SNIFFER_DATA 0x5
#define WISHBONE_REG_SNIFFER_CONTROL 0x8
#define WISHBONE_REG_MAPPER_READ_LO 0x9
#define WISHBONE_REG_MAPPER_READ_HI 0xa
#define WISHBONE_REG_MAPPER_WRITE_LO 0xb
#define WISHBONE_REG_MAPPER_WRITE_HI 0xc
#define WISHBONE_REG_COUNTER_RESET 0xd
#define WISHBONE_REG_RAM_1M_ALIASING 0xe
#define WISHBONE_REG_ID 0xf

#define LED_OFF 0x0
#define LED_EXT_RED 0x20
#define LED_EXT_GREEN 0x10
#define LED_EXT_BLUE 0x8
#define LED_EXT_CYAN (LED_EXT_GREEN | LED_EXT_BLUE)
#define LED_EXT_MAGENTA (LED_EXT_RED | LED_EXT_BLUE)
#define LED_EXT_YELLOW (LED_EXT_RED | LED_EXT_GREEN)
#define LED_EXT_WHITE (LED_EXT_RED | LED_EXT_GREEN | LED_EXT_BLUE)

const unsigned char fallback_rom[] = {
    #embed "wasca-fallback.ss"
};

unsigned char buffer[1024];

#define LED (*(volatile uint32_t*)0x02000000)

#define reg_uart_clkdiv (*(volatile uint32_t*)0x02000004)
//#define reg_uart_data (*(volatile uint32_t*)0x02000008)

#define BLKSIZE 512
#define BLKCNT 10

__attribute__((aligned(4))) FATFS FatFs;		/* FatFs work area needed for each volume */
__attribute__((aligned(4))) FIL Fil;			/* File object needed for each open file */

__attribute__((aligned(4))) PARTITION VolToPart[FF_VOLUMES] = {
    {0, 1},     /* 1st partition on the pd#0 */
};

__attribute__((aligned(4))) char buff[BLKSIZE*BLKCNT];

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

char* mini_strcpy(char* dest, const char* src) {
    int i = 0;
    while (src[i] != '\0') {
        dest[i] = src[i];
        i++;
    }
    dest[i] = '\0'; // Properly terminate the string
    return dest;
}

char* mini_strcat(char* dest, const char* src) {
    char* ptr = dest;
    while (*ptr != '\0') ptr++; // Find end of dest
    while ((*ptr++ = *src++) != '\0'); // Copy src to dest
    return dest;
}

char* mini_strstr(const char *haystack, const char *needle) {
    // If needle is empty, return the entire haystack
    if (*needle == '\0') return (char *)haystack;

    for (; *haystack != '\0'; haystack++) {
        // If first character matches, check the rest
        if (*haystack == *needle) {
            const char *h = haystack;
            const char *n = needle;
            
            // Compare characters
            while (*h != '\0' && *n != '\0' && *h == *n) {
                h++;
                n++;
            }
            // If we reached the end of the needle, it's a match
            if (*n == '\0') return (char *)haystack;
        }
    }
    return NULL; // Needle not found
}

int sdram_quicktest() {
	volatile uint32_t * pSDRAM = (uint32_t *)0x10000000;
	volatile uint32_t * pSDRAM2 = (uint32_t *)0x14000000;
	volatile uint32_t a;
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
		pSDRAM2[0] = 0x6789;
		for (int i=0;i<23;i++)
			pSDRAM2[1<<i] = 0x1020*i;
		pSDRAM2[0x7fffff] = 0xdeadbeef;
		a = pSDRAM2[0];
		if (a != 0x6789)
			mini_printf("SDRAM2 QUICK error: addr %x write %x read %x\r\n",0,0x6789,a);
		for (int i=0;i<23;i++) {
			a = pSDRAM2[1<<i];
			if (a !=((0x1020*i) & 0xFFFF))
				mini_printf("SDRAM2 QUICK error: addr %x write %x read %x\r\n",1<<i,((0x1020*i) & 0xFFFF),a);
		}
		a = pSDRAM2[0x7fffff];
		if (a != 0xbeef)
			mini_printf("SDRAM2 QUICK error: addr %x write %x read %x\r\n",0x7fffff,0xbeef,a);
}

int sdram_test() {
	uint32_t seed;
	volatile uint32_t * pSDRAM = (uint32_t *)0x10000000;
	volatile uint32_t * pSDRAM2 = (uint32_t *)0x14000000;
	LED = LED_EXT_RED;
	int errors = 0;
	mini_printf("SDRAM test...\r\n");
	//starting with CS0
	seed = 0x100500;
	for (int i =0; i < (0x2000000/sizeof(uint32_t)); i++)
	//for (int i =0; i < (0x200000/sizeof(uint32_t)); i++)
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
	//for (int i =0; i < (0x200000/sizeof(uint32_t)); i++)
	{
		readback = pSDRAM[i];
		if (readback != (seed&0xFFFF)) {\
			if (errors < 16)
				mini_printf("SDRAM error: addr %x write %x read %x\r\n",i*4,(seed&0xFFFF),readback);
			errors++;
		}
		seed = lsfr_next_random(seed);
		if (i%0x40000 == 0x3ffff) {
			mini_printf("SDRAM test: read pass addr %x \r\n",i*4+4);
			LED = (i&0x80000) ? LED_EXT_RED : LED_OFF;
		}
	}
	LED = LED_EXT_RED;
	//now CS1
	seed = 0x100500;
	for (int i =0; i < (0x1000000/sizeof(uint32_t)); i++)
	//for (int i =0; i < (0x100000/sizeof(uint32_t)); i++)
	{
		pSDRAM2[i] = (seed&0xFFFF);
		seed = lsfr_next_random(seed);
		if (i%0x40000 == 0x3ffff)
			mini_printf("SDRAM2 test: write pass addr %x \r\n",0x4000000+i*4+4);
	}
	seed = 0x100500;
	errors = 0;
	for (int i =0; i < (0x1000000/sizeof(uint32_t)); i++)
	//for (int i =0; i < (0x100000/sizeof(uint32_t)); i++)
	{
		readback = pSDRAM2[i];
		if (readback != (seed&0xFFFF)) {\
			if (errors < 16)
				mini_printf("SDRAM2 error: addr %x write %x read %x\r\n",i*4,(seed&0xFFFF),readback);
			errors++;
		}
		seed = lsfr_next_random(seed);
		if (i%0x40000 == 0x3ffff) {
			mini_printf("SDRAM2 test: read pass addr %x \r\n",0x4000000+i*4+4);
			LED = (i&0x80000) ? LED_EXT_RED : LED_OFF;
		}
	}
	LED =  LED_OFF;
	mini_printf("SDRAM test DONE\r\n");
	return errors;
}

int main() {
	LED = LED_EXT_RED; //start with red led
    //reg_uart_clkdiv = 217;// 115200 baud at 25MHz
    //reg_uart_clkdiv = 347;// 115200 baud at 40MHz
    reg_uart_clkdiv = 434;//432;//434;// 115200 baud at 50MHz
    //reg_uart_clkdiv = 1155;// 115200 baud at 133MHz

	volatile uint32_t * pSDRAM = (uint32_t *)0x10000000;
	volatile uint32_t * pSDRAM2 = (uint32_t *)0x14000000;

	uint16_t * buffer16 = (uint16_t *)buffer;

	//set registers
	volatile uint32_t * pWishboneRegs = (uint32_t *)0x01000000;
	pWishboneRegs[WISHBONE_REG_SNIFFER_CONTROL] = 0xA;//sniffing only writes over CS1
	pWishboneRegs[WISHBONE_REG_MAPPER_READ_LO] = 0xFFFFFFFF;//read mapper for CS0
	pWishboneRegs[WISHBONE_REG_MAPPER_READ_HI] = 0x0000FFFF;//read mapper for CS1 + CS2
	pWishboneRegs[WISHBONE_REG_MAPPER_WRITE_LO] = 0x80000000;//write mapper for CS0
	pWishboneRegs[WISHBONE_REG_MAPPER_WRITE_HI] = 0x00000000;//write mapper for CS1 + CS2

	/*volatile uint32_t sniff;
	volatile uint32_t dummy;
	while (1) {
		sniff = pWishboneRegs[WISHBONE_REG_SNIFFER_CONTROL];
		if (sniff & 0x03FF0000)
			dummy = pWishboneRegs[WISHBONE_REG_SNIFFER_DATA];
	}*/

	sdram_quicktest();

	//write fallback rom into CS0
	uint16_t * fallback_rom_16 = (uint16_t *)fallback_rom;
	for (int i=0;i<((sizeof(fallback_rom)/2)+1);i++) {
		pSDRAM[i] = fallback_rom_16[i];
	}
	
	mini_printf("\r\n\r\n%s %s\r\n",__DATE__,__TIME__);

	mini_printf("Mount SD...");
	FRESULT fr = f_mount(&FatFs, "0:/", 1);	//mount SD card
	/*if (fr != FR_OK)
	{
		mini_printf("mount error %x \r\n",fr);
	}
	else
		mini_printf("mount OK\r\n");*/
	mini_printf("OK\r\n");

	DIR _dir;
	mini_printf("Open root dir...");
	fr = f_opendir(&_dir, "");
	/*if (fr != FR_OK)
	{
		mini_printf("opendir error %x \r\n",fr);
	}
	else
		mini_printf("opendir OK\r\n");*/
	mini_printf("OK\r\n");

	FILINFO _filinfo;
	FIL _file;
	int offset;
	unsigned int readen;
	int error;

	if (FR_OK == f_stat("wasca.ss", &_filinfo))
	{
		int size = _filinfo.fsize;
		offset = 0;
		error = f_open(&_file,_filinfo.fname,FA_READ);
		while(false == f_eof(&_file)) {
			readen = -1;
			for (int i=0;i<1024;i++)
				buffer[i] - 0x17+i;
			error = f_read(&_file,buffer,1024,&readen);
			for (int i=0;i<512;i++)
				pSDRAM[offset+i] = buffer16[i];
			offset+=512;
		}
		f_close(&_file);
		mini_printf("wasca.ss loaded, %d bytes, written %d\r\n",size,offset*2);
		LED = LED_EXT_BLUE;//if sh2 bootrom found, change led to blue
		}
	else
	{
		mini_printf("Cannot find wasca.ss, using fallback ROM. %d bytes\r\n",sizeof(fallback_rom));
	}

	//getting roms list
	char roms_filenames[32][64];
	int roms_count = 0;
	_filinfo.fname[0] = 1;
	f_readdir(&_dir,NULL);//rewind to start
	while (_filinfo.fname[0] != 0) {
		fr = f_readdir(&_dir,&_filinfo);
		if ( (mini_strstr(_filinfo.fname,".ss")) || (mini_strstr(_filinfo.fname,".bin")) || (mini_strstr(_filinfo.fname,".SS")) || (mini_strstr(_filinfo.fname,".BIN")) ) {
			if ((memcmp(_filinfo.fname,"wasca.ss",8) != 0) && (memcmp(_filinfo.fname,"backup05.bin",12) != 0) && (memcmp(_filinfo.fname,"backup1.bin",11) != 0) &&
			   												   (memcmp(_filinfo.fname,"backup2.bin",11) != 0) && (memcmp(_filinfo.fname,"backup4.bin",11) != 0) ){
				if (roms_count < 10) {
					memset(roms_filenames[roms_count],0,64);
					mini_strcpy(roms_filenames[roms_count],_filinfo.fname);
					roms_count++;
				}
			}
		}
	}

	//preparing advertisement lines for modes at the middle of CS0
	volatile uint32_t * pAdvertise = (uint32_t *)0x12000000;
	char adv_string[64];
	uint16_t * adv_string16 = (uint16_t*)adv_string;
	int adv_offset = 0;
	int id = 1;
	//power memory 0.5
	pAdvertise[adv_offset] = (id++)<<8;
	memset(adv_string,0,64);
	if (FR_OK == f_stat("backup05.bin", &_filinfo))
		mini_strcpy(adv_string,"BACKUP 0.5M (backup05.bin)");
	else
		mini_strcpy(adv_string,"BACKUP 0.5M (New file: backup05.bin)");
	for (int i=0; i<31;i++)
		pAdvertise[adv_offset+i+1] = adv_string16[i];
	adv_offset+= 32;
	//power memory 1
	memset(adv_string,0,64);
	pAdvertise[adv_offset] = (id++)<<8;
	if (FR_OK == f_stat("backup1.bin", &_filinfo))
		mini_strcpy(adv_string,"BACKUP 1M (backup1.bin)");
	else
		mini_strcpy(adv_string,"BACKUP 1M (New file: backup1.bin)");
	for (int i=0; i<31;i++)
		pAdvertise[adv_offset+i+1] = adv_string16[i];
	adv_offset+= 32;
	//power memory 2
	memset(adv_string,0,64);
	pAdvertise[adv_offset] = (id++)<<8;
	if (FR_OK == f_stat("backup2.bin", &_filinfo))
		mini_strcpy(adv_string,"BACKUP 2M (backup2.bin)");
	else
		mini_strcpy(adv_string,"BACKUP 2M (New file: backup2.bin)");
	for (int i=0; i<31;i++)
		pAdvertise[adv_offset+i+1] = adv_string16[i];
	adv_offset+= 32;
	//power memory 4
	memset(adv_string,0,64);
	pAdvertise[adv_offset] = (id++)<<8;
	if (FR_OK == f_stat("backup4.bin", &_filinfo))
		mini_strcpy(adv_string,"BACKUP 4M (backup4.bin)");
	else
		mini_strcpy(adv_string,"BACKUP 4M (New file: backup4.bin)");
	for (int i=0; i<31;i++)
		pAdvertise[adv_offset+i+1] = adv_string16[i];
	adv_offset+= 32;
	//1M RAM
	memset(adv_string,0,64);
	pAdvertise[adv_offset] = (id++)<<8;
	mini_strcpy(adv_string,"RAM 1M");
	for (int i=0; i<31;i++)
		pAdvertise[adv_offset+i+1] = adv_string16[i];
	adv_offset+= 32;
	//4M RAM
	memset(adv_string,0,64);
	pAdvertise[adv_offset] = (id++)<<8;
	mini_strcpy(adv_string,"RAM 4M");
	for (int i=0; i<31;i++)
		pAdvertise[adv_offset+i+1] = adv_string16[i];
	adv_offset+= 32;
	//special Heart of Darkness mode
	memset(adv_string,0,64);
	pAdvertise[adv_offset] = (id++)<<8;
	mini_strcpy(adv_string,"RAM (Heart of Darkness)");
	for (int i=0; i<31;i++)
		pAdvertise[adv_offset+i+1] = adv_string16[i];
	adv_offset+= 32;
	//now listing every ss file except wasca.ss
	/*_filinfo.fname[0] = 1;
	f_readdir(&_dir,NULL);//rewind to start
	while (_filinfo.fname[0] != 0) {
		fr = f_readdir(&_dir,&_filinfo);
		if ( (mini_strstr(_filinfo.fname,".ss")) || (mini_strstr(_filinfo.fname,".bin")) || (mini_strstr(_filinfo.fname,".SS")) || (mini_strstr(_filinfo.fname,".BIN")) ) {
			if (memcmp(_filinfo.fname,"wasca.ss",8) != 0) {
				memset(adv_string,0,64);
				pAdvertise[adv_offset] = (id++)<<8;
				mini_strcpy(adv_string,"ROM (");
				mini_strcat(adv_string,_filinfo.fname);
				mini_strcat(adv_string,")");
				for (int i=0; i<31;i++)
					pAdvertise[adv_offset+i+1] = adv_string16[i];
				adv_offset+= 32;
			}
		}
	}*/
	//now listing rom files
	for (int i=0;i<roms_count;i++){
		memset(adv_string,0,64);
		pAdvertise[adv_offset] = (id++)<<8;
		mini_strcpy(adv_string,"ROM (");
		mini_strcat(adv_string,roms_filenames[i]);
		mini_strcat(adv_string,")");
		for (int i=0; i<31;i++)
			pAdvertise[adv_offset+i+1] = adv_string16[i];
		adv_offset+= 32;
	}
	pAdvertise[adv_offset] = 0;//end of advertising list

	//waiting for mode selection
	mini_printf("Waiting for mode selection...");
	pWishboneRegs[WISHBONE_REG_PCNTR] = 102;
	while(pWishboneRegs[WISHBONE_REG_MODE] == 0)
		;
	mini_printf("done, mode %d\r\n",pWishboneRegs[WISHBONE_REG_MODE]);
	pWishboneRegs[WISHBONE_REG_PCNTR] = 103;
	LED = LED_EXT_CYAN;

	int creating_backup = 0;

	//executing prepare sequence
	switch (pWishboneRegs[WISHBONE_REG_MODE]) {
		case 0:
			//some error? we never advertised 0
			pWishboneRegs[WISHBONE_REG_ID] = 0xFFFF;
			pWishboneRegs[WISHBONE_REG_PCNTR] = 101;
			LED = LED_EXT_RED;
			break;
		case 1:
			pWishboneRegs[WISHBONE_REG_ID] = 0xFF21;
			if (FR_OK != f_stat("backup05.bin", &_filinfo))
			{
				creating_backup = 1;
				f_open(&_file,"backup05.bin",FA_CREATE_ALWAYS | FA_WRITE);
				for (int i=0;i<1024;i++) {
					f_write(&_file,buffer,1024,&readen);
					pWishboneRegs[WISHBONE_REG_PCNTR] = (i * 50)/1024;
					LED = (i&0x20) ? LED_EXT_MAGENTA : LED_OFF;
				}
				f_close(&_file);
			}
			f_open(&_file,"backup05.bin",FA_READ);
			offset = 0;
			while(false == f_eof(&_file)) {
				readen = -1;
				f_read(&_file,buffer,1024,&readen);
				for (int i=0;i<512;i++) {
					pSDRAM2[offset+i] = buffer16[i];
				}
				offset+=512;
				pWishboneRegs[WISHBONE_REG_PCNTR] = (creating_backup) ? 50 + offset/10486 : offset/5243;
				LED = (offset&0x4000) ? LED_EXT_YELLOW : LED_OFF;
			}
			f_close(&_file);
			pWishboneRegs[WISHBONE_REG_PCNTR] = 100;
			pWishboneRegs[WISHBONE_REG_MAPPER_READ_LO] = 0x80000000;//disable read for CS0
			pWishboneRegs[WISHBONE_REG_MAPPER_WRITE_HI] = 0x0000FFFF;//enable write for CS1
			LED = LED_EXT_GREEN;
			break;
		case 2:
			pWishboneRegs[WISHBONE_REG_ID] = 0xFF22;
			pWishboneRegs[WISHBONE_REG_PCNTR] = 1;
			if (FR_OK != f_stat("backup1.bin", &_filinfo))
			{
				creating_backup = 1;
				f_open(&_file,"backup1.bin",FA_CREATE_ALWAYS | FA_WRITE);
				for (int i=0;i<2048;i++) {
					f_write(&_file,buffer,1024,&readen);
					pWishboneRegs[WISHBONE_REG_PCNTR] = (i * 50)/2048;
					LED = (i&0x20) ? LED_EXT_MAGENTA : LED_OFF;
				}
				f_close(&_file);
			}
			f_open(&_file,"backup1.bin",FA_READ);
			offset = 0;
			while(false == f_eof(&_file)) {
				readen = -1;
				f_read(&_file,buffer,1024,&readen);
				for (int i=0;i<512;i++) {
					pSDRAM2[offset+i] = buffer16[i];
				}
				offset+=512;
				pWishboneRegs[WISHBONE_REG_PCNTR] = (creating_backup) ? 50 + offset/20972 : offset/10486;
				LED = (offset&0x4000) ? LED_EXT_YELLOW : LED_OFF;
			}
			f_close(&_file);
			pWishboneRegs[WISHBONE_REG_PCNTR] = 100;
			pWishboneRegs[WISHBONE_REG_MAPPER_READ_LO] = 0x80000000;//disable read for CS0
			pWishboneRegs[WISHBONE_REG_MAPPER_WRITE_HI] = 0x0000FFFF;//enable write for CS1
			LED = LED_EXT_GREEN;
			break;
		case 3:
			pWishboneRegs[WISHBONE_REG_ID] = 0xFF23;
			pWishboneRegs[WISHBONE_REG_PCNTR] = 1;
			if (FR_OK != f_stat("backup2.bin", &_filinfo))
			{
				creating_backup = 1;
				f_open(&_file,"backup2.bin",FA_CREATE_ALWAYS | FA_WRITE);
				for (int i=0;i<4096;i++) {
					f_write(&_file,buffer,1024,&readen);
					pWishboneRegs[WISHBONE_REG_PCNTR] = (i * 50)/4096;
					LED = (i&0x20) ? LED_EXT_MAGENTA : LED_OFF;
				}
				f_close(&_file);
			}
			f_open(&_file,"backup2.bin",FA_READ);
			offset = 0;
			while(false == f_eof(&_file)) {
				readen = -1;
				f_read(&_file,buffer,1024,&readen);
				for (int i=0;i<512;i++) {
					pSDRAM2[offset+i] = buffer16[i];
				}
				offset+=512;
				pWishboneRegs[WISHBONE_REG_PCNTR] = (creating_backup) ? 50 + offset/41943 : offset/20972;
				LED = (offset&0x4000) ? LED_EXT_YELLOW : LED_OFF;
			}
			f_close(&_file);
			pWishboneRegs[WISHBONE_REG_PCNTR] = 100;
			pWishboneRegs[WISHBONE_REG_MAPPER_READ_LO] = 0x80000000;//disable read for CS0
			pWishboneRegs[WISHBONE_REG_MAPPER_WRITE_HI] = 0x0000FFFF;//enable write for CS1
			LED = LED_EXT_GREEN;
			break;
		case 4:
			pWishboneRegs[WISHBONE_REG_ID] = 0xFF24;
			pWishboneRegs[WISHBONE_REG_PCNTR] = 1;
			if (FR_OK != f_stat("backup4.bin", &_filinfo))
			{
				creating_backup = 1;
				f_open(&_file,"backup4.bin",FA_CREATE_ALWAYS | FA_WRITE);
				for (int i=0;i<8192;i++) {
					f_write(&_file,buffer,1024,&readen);
					pWishboneRegs[WISHBONE_REG_PCNTR] = (i * 50)/8192;
					LED = (i&0x20) ? LED_EXT_MAGENTA : LED_OFF;
				}
				f_close(&_file);
			}
			f_open(&_file,"backup4.bin",FA_READ);
			offset = 0;
			while(false == f_eof(&_file)) {
				readen = -1;
				f_read(&_file,buffer,1024,&readen);
				for (int i=0;i<512;i++) {
					pSDRAM2[offset+i] = buffer16[i];
				}
				offset+=512;
				pWishboneRegs[WISHBONE_REG_PCNTR] = (creating_backup) ? 50 + offset/83886 : offset/41943;
				LED = (offset&0x4000) ? LED_EXT_YELLOW : LED_OFF;
			}
			f_close(&_file);
			pWishboneRegs[WISHBONE_REG_PCNTR] = 100;
			pWishboneRegs[WISHBONE_REG_MAPPER_READ_LO] = 0x80000000;//disable read for CS0
			pWishboneRegs[WISHBONE_REG_MAPPER_WRITE_HI] = 0x0000FFFF;//enable write for CS1
			LED = LED_EXT_GREEN;
			break;
		case 5:
			pWishboneRegs[WISHBONE_REG_RAM_1M_ALIASING] = 0x1;
			pWishboneRegs[WISHBONE_REG_ID] = 0xFF5A;
			pWishboneRegs[WISHBONE_REG_PCNTR] = 100;
			pWishboneRegs[WISHBONE_REG_MAPPER_READ_HI] = 0x00000000;//disable read for CS1
			LED = LED_EXT_GREEN;
			break;
		case 6:
			pWishboneRegs[WISHBONE_REG_ID] = 0xFF5C;
			pWishboneRegs[WISHBONE_REG_PCNTR] = 100;
			pWishboneRegs[WISHBONE_REG_MAPPER_READ_HI] = 0x00000000;//disable read for CS1
			LED = LED_EXT_GREEN;
			break;
		case 7:
			pWishboneRegs[WISHBONE_REG_ID] = 0x1234;
			pWishboneRegs[WISHBONE_REG_PCNTR] = 100;
			pWishboneRegs[WISHBONE_REG_MAPPER_READ_LO] = 0x80000000;//disable read for CS0
			pWishboneRegs[WISHBONE_REG_MAPPER_WRITE_HI] = 0x0000FFFF;//enable write for CS1
			LED = LED_EXT_GREEN;
			break;
		default:
			pWishboneRegs[WISHBONE_REG_ID] = 0xFFFF;
			//getting rom
			/*f_readdir(&_dir,NULL);//rewind to start
			int id = 8;
			while (_filinfo.fname[0] != 0) {
				fr = f_readdir(&_dir,&_filinfo);
				if (mini_strstr(_filinfo.fname,".ss")) {
					if (memcmp(_filinfo.fname,"wasca.ss",8) != 0) {
						if (id == pWishboneRegs[WISHBONE_REG_MODE]) {				
							f_open(&_file,_filinfo.fname,FA_READ);
							offset = 0;
							while(false == f_eof(&_file)) {
								readen = -1;
								f_read(&_file,buffer,1024,&readen);
								for (int i=0;i<512;i++) {
									pSDRAM[offset+i] = buffer16[i];
								}
								offset+=512;
								pWishboneRegs[WISHBONE_REG_PCNTR] = (100*offset)/_filinfo.fsize;
								LED = (offset&0x4000) ? LED_EXT_YELLOW : LED_OFF;
							}
							f_close(&_file);
						}
						id++;
					}
				}
			}*/
			f_open(&_file,roms_filenames[pWishboneRegs[WISHBONE_REG_MODE]-8],FA_READ);
			int _size = f_size(&_file);
			offset = 0;
			while(false == f_eof(&_file)) {
				readen = -1;
				f_read(&_file,buffer,1024,&readen);
				for (int i=0;i<512;i++) {
					pSDRAM[offset+i] = buffer16[i];
				}
				offset+=512;
				pWishboneRegs[WISHBONE_REG_PCNTR] = (100*offset)/_size;
				LED = (offset&0x4000) ? LED_EXT_YELLOW : LED_OFF;
			}
			f_close(&_file);
			pWishboneRegs[WISHBONE_REG_PCNTR] = 100;
			pWishboneRegs[WISHBONE_REG_MAPPER_WRITE_LO] = 0xFFFFFFFF;//enable write for CS0
			pWishboneRegs[WISHBONE_REG_MAPPER_WRITE_HI] = 0x0000FFFF;//enable write for CS1
			LED = LED_EXT_GREEN;
			break;
	}

	delay();
	LED = LED_OFF;

	//setup sniffer
	switch (pWishboneRegs[WISHBONE_REG_MODE]) {
		case 0:
			pWishboneRegs[WISHBONE_REG_SNIFFER_CONTROL] = 0x0;//broken config, not sniffing anything
			break;
		case 1:
		case 2:
		case 3:
		case 4:
			pWishboneRegs[WISHBONE_REG_SNIFFER_CONTROL] = 0xA;//sniffing only writes over CS1
			break;
		case 5:
		case 6:
			pWishboneRegs[WISHBONE_REG_SNIFFER_CONTROL] = 0x6;//sniffing only writes over CS0
			break;
		case 7:
			pWishboneRegs[WISHBONE_REG_SNIFFER_CONTROL] = 0xA;//sniffing only writes over CS1
			break;
		default:
			pWishboneRegs[WISHBONE_REG_SNIFFER_CONTROL] = 0xF;//sniffing all access over CS0 and CS1
			break;
    }

	//main cycle
    while (1) {
		switch (pWishboneRegs[WISHBONE_REG_MODE]) {
		case 1:
		case 2:
		case 3:
		case 4:
			//backup syncing
			break;
		case 5:
		case 6:
			//led blinking
			if (pWishboneRegs[WISHBONE_REG_SNIFFER_CONTROL] & 0x03FF0000) {
				//read fifo
				volatile int dummy = pWishboneRegs[WISHBONE_REG_SNIFFER_DATA];
				LED = LED_EXT_GREEN;
			}
			else
				LED = LED_OFF;
			break;
		case 7:
			//access led blinking
			if (pWishboneRegs[WISHBONE_REG_SNIFFER_CONTROL] & 0x03FF0000) {
				//read fifo
				volatile int dummy = pWishboneRegs[WISHBONE_REG_SNIFFER_DATA];
				LED = LED_EXT_GREEN;
			}
			else
				LED = LED_OFF;
			break;
		default:
			if (pWishboneRegs[WISHBONE_REG_SNIFFER_CONTROL] & 0x03FF0000) {
				//read fifo
				volatile int dummy = pWishboneRegs[WISHBONE_REG_SNIFFER_DATA];
				LED = LED_EXT_GREEN;
			}
			else
				LED = LED_OFF;
			//access led blinking
			break;  
		}
	}
}
