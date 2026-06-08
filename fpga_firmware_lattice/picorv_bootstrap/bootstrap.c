#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "fatfs/ff.h"
#include "fatfs/sdiodrv.h"
#include "fatfs/diskio.h"
#include "mini-printf.h"

#define WISHBONE_REG_PCNTR 0x0
#define WISHBONE_REG_FSCNTRL 0x1
#define WISHBONE_REG_MODE 0x2
#define WISHBONE_REG_HWVER 0x3
//#define WISHBONE_REG_SWVER 0x4
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

const unsigned char fallback_rom[] = {
    #embed "wasca-fallback.ss"
};

unsigned char buffer[2048];

#define LED (*(volatile uint32_t*)0x02000000)

#define reg_uart_clkdiv (*(volatile uint32_t*)0x02000004)

#define BLKSIZE 512
#define BLKCNT 10

char roms_filenames[32][64];

__attribute__((aligned(4))) PARTITION VolToPart[FF_VOLUMES] = {
    {0, 1},     /* 1st partition on the pd#0 */
};

volatile uint32_t * pWishboneRegs = (uint32_t *)0x01000000;
volatile uint32_t * pSDRAM = (uint32_t *)0x10000000;
volatile uint32_t * pSDRAM2 = (uint32_t *)0x14000000;

__attribute__((aligned(4))) FATFS FatFs;		/* FatFs work area needed for each volume */

int overall_backup_enable = 0;
int overall_backup_counter = 0;

extern void filesystem_access_init();
extern void filesystem_access_scheduler();

int launch_firmware(int firmware_size) __attribute__((section(".update_func.code")));

void delay() {
    for (volatile int i = 0; i < 750000; i++)
        ;
}

void lock_and_blink_red() {
	while (1) {
		LED = LED_EXT_RED;
		delay();
		LED = LED_OFF;
		delay();
	}
}

int sdram_quicktest() {
	volatile uint32_t a;
	int errors = 0;
	//CS0
	pSDRAM[0] = 0x12345678;
	for (int i=0;i<24;i++)
		pSDRAM[1<<i] = 0x11111111*i;
	pSDRAM[0xffffff] = 0xdeafface;
	a = pSDRAM[0];
	if (a != 0x00005678) {
		mini_printf("SDRAM QUICK error: addr %x write %x read %x\r\n",0,0x00005678,a);
		errors++;
	}
	for (int i=0;i<24;i++) {
		a = pSDRAM[1<<i];
		if (a !=((0x1111*i) & 0xFFFF)) {
			mini_printf("SDRAM QUICK error: addr %x write %x read %x\r\n",1<<i,((0x1111*i) & 0xFFFF),a);
			errors++;
		}
	}
	a = pSDRAM[0xffffff];
	if (a != 0x0000face) {
		mini_printf("SDRAM QUICK error: addr %x write %x read %x\r\n",0xffffff,0x0000face,a);
		errors++;
	}
	//CS1
	pSDRAM2[0] = 0x6789;
	for (int i=0;i<23;i++)
		pSDRAM2[1<<i] = 0x1020*i;
	pSDRAM2[0x7fffff] = 0xdeadbeef;
	a = pSDRAM2[0];
	if (a != 0x6789) {
		mini_printf("SDRAM2 QUICK error: addr %x write %x read %x\r\n",0,0x6789,a);
		errors++;
	}
	for (int i=0;i<23;i++) {
		a = pSDRAM2[1<<i];
		if (a !=((0x1020*i) & 0xFFFF)) {
			mini_printf("SDRAM2 QUICK error: addr %x write %x read %x\r\n",1<<i,((0x1020*i) & 0xFFFF),a);
			errors++;
		}
	}
	a = pSDRAM2[0x7fffff];
	if (a != 0xbeef) {
		mini_printf("SDRAM2 QUICK error: addr %x write %x read %x\r\n",0x7fffff,0xbeef,a);
		errors++;
	}
	
	return errors;
}

int main() {
	uint16_t * buffer16 = (uint16_t *)buffer;
	volatile int dummy;

	LED = LED_EXT_RED; //start with red led
    reg_uart_clkdiv = 434;//432;//434;// 115200 baud at 50MHz

	//set wishbone registers
	pWishboneRegs[WISHBONE_REG_SNIFFER_CONTROL] = 0xA;//sniffing only writes over CS1
	pWishboneRegs[WISHBONE_REG_MAPPER_READ_LO] = 0xFFFFFFFF;//read mapper for CS0
	pWishboneRegs[WISHBONE_REG_MAPPER_READ_HI] = 0x0000FFFF;//read mapper for CS1 + CS2
	pWishboneRegs[WISHBONE_REG_MAPPER_WRITE_LO] = 0xFFFFFFFF;//write mapper for CS0
	pWishboneRegs[WISHBONE_REG_MAPPER_WRITE_HI] = 0x0000FFFF;//0x00000000;//write mapper for CS1 + CS2

	//set memory-based registers
	pSDRAM[0xfffd00] =  0; //filesystem status register
	pSDRAM[0xfffffc] =  0; //Software version
	pSDRAM[0xfffffd] =  0x6177; //signature "wa"
	pSDRAM[0xfffffe] =  0x6373; //signature "sc"
	pSDRAM[0xffffff] =  0x2061; //signature "a "

	//write fallback rom into CS0
	uint16_t * fallback_rom_16 = (uint16_t *)fallback_rom;
	for (int i=0;i<((sizeof(fallback_rom)/2)+1);i++) {
		pSDRAM[i] = fallback_rom_16[i];
	}
	
	mini_printf("\r\n\r\nwasca bootstrap %s %s\r\n",__DATE__,__TIME__);

	sdram_quicktest();
	mini_printf("SDRAM test done.\r\n");

	mini_printf("Mount SD...");
	FRESULT fr = f_mount(&FatFs, "0:/", 1);	//mount SD card
	mini_printf("OK\r\n");

	DIR _dir;
	mini_printf("Open root dir...");
	fr = f_opendir(&_dir, "");
	mini_printf("OK\r\n");

	FILINFO _filinfo;
	FIL _file;
	int offset;
	int error;

	//at first, we're checking if wasca.rv present, but not executing it yet	
	if (FR_OK != f_stat("wasca.rv", &_filinfo))
	{
		//if not, stoppning here
		mini_printf("Cannot find wasca.rv, patching message in fallback ROM.\r\n");
		const char wasca_ss_message[] = "wasca.rv not found on SD card\0";
		uint16_t * wasca_ss_message16 = (uint16_t * )wasca_ss_message;
		for (int i=0;i<((sizeof(wasca_ss_message)/2)+1);i++) {
			pSDRAM[i+0x82e] = wasca_ss_message16[i];
		}
	
		lock_and_blink_red();
	}

	//then we're checking if wasca.ss is present
	if (FR_OK == f_stat("wasca.ss", &_filinfo))
	{
		int size = _filinfo.fsize;
		int readen = -1;
		offset = 0;
		error = f_open(&_file,_filinfo.fname,FA_READ);
		while(false == f_eof(&_file)) {
			error = f_read(&_file,buffer,1024,&readen);
			for (int i=0;i<512;i++)
				pSDRAM[offset+i] = buffer16[i];
			offset+=512;
		}
		f_close(&_file);
		mini_printf("wasca.ss loaded, %d bytes, written %d\r\n",size,offset*2);
	}
	else
	{
		mini_printf("Cannot find wasca.ss, patching message in fallback ROM.\r\n");
		const char wasca_ss_message[] = "wasca.ss not found on SD card\0";
		uint16_t * wasca_ss_message16 = (uint16_t * )wasca_ss_message;
		for (int i=0;i<((sizeof(wasca_ss_message)/2)+1);i++) {
			pSDRAM[i+0x82e] = wasca_ss_message16[i];
		}
		lock_and_blink_red();
	}

	//now actually launching wasca.rv
	if (FR_OK == f_stat("wasca.rv", &_filinfo))
	{
		int size = _filinfo.fsize;
		int readen;
		mini_printf("wasca.rv found, %d bytes, launching...\r\n",size);
		//load new firmware to SDRAM2
		offset = 0;
		error = f_open(&_file,_filinfo.fname,FA_READ);
		while(false == f_eof(&_file)) {
			error = f_read(&_file,buffer,1024,&readen);
			for (int i=0;i<512;i++)
				pSDRAM2[offset+i] = buffer16[i];
			offset+=512;
		}
		f_close(&_file);
		//now execute the bootstrap update code
		launch_firmware(size);
	}

	//should never reach here
	lock_and_blink_red();

    while (1)
		;
}

int launch_firmware(int firmware_size) {
	static volatile uint32_t * pSDRAM2_local  __attribute__((section(".update_func.data"))) = (uint32_t *)0x14000000;
	static volatile uint16_t * pWorkRam_local  __attribute__((section(".update_func.data"))) = (uint16_t *)0x00000000;
	//using only local variables
	if (firmware_size > 0x17F00)
		firmware_size = 0x17F00;

	for (int i=0;i<(firmware_size/2+1);i++) {
		pWorkRam_local[i] = pSDRAM2_local[i];
	}
	//reinitialize stack pointer
	asm("li sp, 0x18000");// Load 0x18000 into the stack pointer
	//jump
	asm("lui  t0, 0x0");  // Load upper 20 bits
	asm("jalr x0, 0(t0)"); // Jump to the address in t0
}