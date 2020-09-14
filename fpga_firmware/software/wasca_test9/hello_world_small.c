/* 
 * "Small Hello World" example. 
 * 
 * This example prints 'Hello from Nios II' to the STDOUT stream. It runs on
 * the Nios II 'standard', 'full_featured', 'fast', and 'low_cost' example 
 * designs. It requires a STDOUT  device in your system's hardware. 
 *
 * The purpose of this example is to demonstrate the smallest possible Hello 
 * World application, using the Nios II HAL library.  The memory footprint
 * of this hosted application is ~332 bytes by default using the standard 
 * reference design.  For a more fully featured Hello World application
 * example, see the example titled "Hello World".
 *
 * The memory footprint of this example has been reduced by making the
 * following changes to the normal "Hello World" example.
 * Check in the Nios II Software Developers Manual for a more complete 
 * description.
 * 
 * In the SW Application project (small_hello_world):
 *
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 * In System Library project (small_hello_world_syslib):
 *  - In the C/C++ Build page
 * 
 *    - Set the Optimization Level to -Os
 * 
 *    - Define the preprocessor option ALT_NO_INSTRUCTION_EMULATION 
 *      This removes software exception handling, which means that you cannot 
 *      run code compiled for Nios II cpu with a hardware multiplier on a core 
 *      without a the multiply unit. Check the Nios II Software Developers 
 *      Manual for more details.
 *
 *  - In the System Library page:
 *    - Set Periodic system timer and Timestamp timer to none
 *      This prevents the automatic inclusion of the timer driver.
 *
 *    - Set Max file descriptors to 4
 *      This reduces the size of the file handle pool.
 *
 *    - Check Main function does not exit
 *    - Uncheck Clean exit (flush buffers)
 *      This removes the unneeded call to exit when main returns, since it
 *      won't.
 *
 *    - Check Don't use C++
 *      This builds without the C++ support code.
 *
 *    - Check Small C library
 *      This uses a reduced functionality C library, which lacks  
 *      support for buffering, file IO, floating point and getch(), etc. 
 *      Check the Nios II Software Developers Manual for a complete list.
 *
 *    - Check Reduced device drivers
 *      This uses reduced functionality drivers if they're available. For the
 *      standard design this means you get polled UART and JTAG UART drivers,
 *      no support for the LCD driver and you lose the ability to program 
 *      CFI compliant flash devices.
 *
 *    - Check Access device drivers directly
 *      This bypasses the device file system to access device drivers directly.
 *      This eliminates the space required for the device file system services.
 *      It also provides a HAL version of libc services that access the drivers
 *      directly, further reducing space. Only a limited number of libc
 *      functions are available in this configuration.
 *
 *    - Use ALT versions of stdio routines:
 *
 *           Function                  Description
 *        ===============  =====================================
 *        alt_printf       Only supports %s, %x, and %c ( < 1 Kbyte)
 *        alt_putstr       Smaller overhead than puts with direct drivers
 *                         Note this function doesn't add a newline.
 *        alt_putchar      Smaller overhead than putchar with direct drivers
 *        alt_getchar      Smaller overhead than getchar with direct drivers
 *
 */

#include "sys/alt_stdio.h"
#include "system.h"
#include "Altera_UP_SD_Card_Avalon_Interface.h"

#define SOFTWARE_VERSION 0x0002

#define PCNTR_REG_OFFSET 0xF0
#define MODE_REG_OFFSET 0xF4
#define SWVER_REG_OFFSET 0xF8
//extern const unsigned char rawData[131072];
//extern const unsigned char minipseudo[15588];
//extern const unsigned char minipseudo_nowait[15588];


const char Power_Memory_Signature[16] = "BackUpRam Format";
const char Wasca_Sysarea_Signature[64] = {0x80, 0x00, 0x00, 0x00, 0x77, 0x61, 0x73, 0x63,
										  0x61, 0x20, 0x73, 0x79, 0x73, 0x20, 0x20, 0x01,
										  0xBE, 0xB6, 0xDE, 0xBB, 0xC0, 0xB0, 0xDD, 0x2C,
										  0xBC, 0xDB, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
										  0x0E, 0x74, 0x7F, 0xFC, 0x7F, 0xFD, 0x7F, 0xFE,
										  0x7F, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
										  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
										  0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
										};

extern alt_up_sd_card_dev	*device_pointer;

int main()
{

  int i,j;
  volatile int k,v;
  volatile unsigned char * p;
  volatile unsigned char * p2;
  volatile unsigned short * p16;
  unsigned short sMode;
  int iteration = 0;
  int ierrors = 0;
  p = (unsigned char *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
  p16 = (unsigned short *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
  volatile unsigned char c1,c2,c3,c4;
  volatile unsigned short s1,s2;
  volatile unsigned char readback[256];
  /*while (1)
  {
	  p[64] = 0x12;
	  p[65] = 0x34;
	  p[66] = 0x56;
	  p[67] = 0x78;
	  c1 = p[64];
	  c2 = p[65];
	  c3 = p[66];
	  c4 = p[67];
	  p16[32] = 0x1234;
	  p16[33] = 0x5678;
	  s1 = p16[32];
	  s2 = p16[33];
	  for (k=0;k<1000000;k++) ; //pause
	  k++;
  }*/
  /*while (1)
  {
	  alt_printf("New SDRAM test, iteration %i\n\r",iteration);
	  ierrors = 0;
	  //write
	  for (i=0;i<256;i++)
		  p[i] = i;
	  //read
	  for (i=0;i<256;i++)
	  {
		  readback[i] = p[i];
		  if (readback[i] != i)
		  {
			  ierrors++;
			  if (ierrors < 5)
				  alt_printf("Error: ADDR %X WRITE %X READ %X\n\r",i,i,readback);
		  }

	  }
	  alt_printf("Test done, %i errors\n\r",ierrors);
	  iteration++;
	  for (k=0;k<1000000;k++) ; //pause
  }*/
  //first things first - copy saturn bootcode into SDRAM
  for (i=0;i<100;i++)
	  alt_printf("AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA\n\r");
  alt_up_sd_card_open_dev("/dev/Altera_UP_SD_Card_Avalon_Interface_0");
  for (i=0;i<256;i++)
  {
	  Read_Sector_Data(15362+i,561);
	  p2 = device_pointer->base;
	  for (j=0;j<512;j++)
		  p[i*512+j] =  p2[j];
  }
  //now it's minipseudo's time
  for (i=0;i<32;i++)
  {
	  Read_Sector_Data(17410+i,561);
	  p2 = device_pointer->base;
	  for (j=0;j<512;j++)
		  p[0x9C000 + i*512+j] =  p2[j];
  }

  p = (unsigned char *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
  /*for (i=0;i<131072;i++)
	  p[i] = rawData[i];
  //now it's minipseudo's time
  for (i=0;i<15588;i++)
	  p[0x9C000 + i] = minipseudo_nowait[i];*/
  /*for (i=0;i<131072;i+=2)
  {
	  p[i] = rawData[i];
	  p[i+1] = rawData[i+1];
  }*/
  alt_putstr("Bootloader copied! Dump :\n\r");
  //while(1);
  for (i=0;i<256;i++)
  {
	  alt_printf("%c ",p[i]);
	  if (i%16 == 15) alt_putstr("\n\r");
  }
  alt_putstr("Dump done\n\r");

  //write version
  p16 = (unsigned short *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_BASE;
  p16[SWVER_REG_OFFSET] = SOFTWARE_VERSION;

  //now wait until MODE register is non-zero, i.e. mode is set
  alt_putstr("Waiting for MODE register to be set...\n\r");
  while (p16[MODE_REG_OFFSET] == 0)
	  {
	  for (k=0;k<1000000;k++);
	  alt_putstr(".");;
	  }
  sMode = p16[MODE_REG_OFFSET];
  alt_printf("Mode set to %x\n\r",sMode);

  //okay, now start a MODE-dependent preparation routine
  //lower octets have higher priority
  if ((sMode & 0x000F) != 0)
  {
	  alt_printf("Octet 0, value %x\n\r",(sMode & 0x000F));
	  //lowest octet is active, it's a POWER MEMORY
	  //we should copy relevant image from SD card
	  //for now, we will only write header and emulate copying behavior
	  p = (unsigned char *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
	  switch (sMode & 0x000F )
	  {
	  case 0x1 : //0.5 MB
	  case 0x2 : //1 MB
	  case 0x3 : //2 MB
		  alt_putstr("Header 0-3 copy start\n\r");
		  for (j=0;j<16;j++)
			  for (i=0;i<16;i++)
			  {
				  p[j*16+i] = Power_Memory_Signature[i];
				  p[256+j*16+i] = 0;
			  }
		  alt_putstr("Header copied\n\r");
		  break;
	  case 0x04 : //4 MB
		  alt_putstr("Header 4 copy start\n\r");
		  for (j=0;j<32;j++)
			  for (i=0;i<16;i++)
			  {
				  p[j*16+i] = Power_Memory_Signature[i];
				  p[512+j*16+i] = 0;
			  }
		  alt_putstr("Header copied\n\r");
		  for (i=0;i<64;i++)
		  	  {
		  	  p[0x1FFF000 + i] = Wasca_Sysarea_Signature[i];
		  	  }
		  alt_putstr("Sysarea stub copied\n\r");
		  break;
	  }
	  //now emulate slow copy
	  for (v=2;v<101;v++)
	  {
		  for (k=0;k<100000;k++) ;
		  //alt_printf("Setting progress to %x\n\r",v);
		  p16[PCNTR_REG_OFFSET]=v;
	  }
  }
  else if ((sMode & 0x00F0) != 0)
  {
	  alt_printf("Octet 1, value %x\n\r",(sMode & 0x00F0));
	  //RAM expansion cart, clear bootrom's signature just in case
	  p = (unsigned char *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
	  for (i=0;i<256;i++) p[i] = 0;
	  //and that is all for RAM cart
	  p16[PCNTR_REG_OFFSET]=100;
  }
  else if ((sMode & 0x0F00) != 0)
  {
	  alt_printf("Octet 2, value %x\n\r",(sMode & 0x0F00));
	  //ROM
	  //TODO : load corresponding rom from SD card
	  p16[PCNTR_REG_OFFSET]=100;
  }
  else
  {
	  alt_printf("UNKNOWN MODE %x\n\r",sMode);
	  p16[PCNTR_REG_OFFSET]=100;
  }


  //there should be a sync process, valid only for power memory

  //stop
  while (1);

  return 0;
}
