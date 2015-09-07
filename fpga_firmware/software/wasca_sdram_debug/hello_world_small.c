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
#define FAT_PRINTF alt_printf

#include "sys/alt_stdio.h"
#include "system.h"
#include "fat_filelib.h"

#define READ_BLOCK 17

int media_init()
{
    // ...
    return 1;
}

int media_read(unsigned long sector, unsigned char *buffer, unsigned long sector_count)
{
    unsigned long i,j;
    short int status;
    unsigned char * pSD = (unsigned char *)ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE;
    int *command_argument_register = ((int *)(ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE + 0x0000022C));
    short int *command_register = ((short int *)(ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE + 0x00000230));
    short int *aux_status_register = ((short int *)(ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE + 0x00000234));

    for (i=0;i<sector_count;i++)
    {
  	  /* Wait until the operation completes. */
  	  do {
  	  status = *aux_status_register;
  	  } while ((status & 0x04)!=0);
  	  alt_printf("Read block %x wait done\n\r",sector+i);

  	  /* Read 1st sector on the card */
    	  *command_argument_register = (sector+i) * 512;
    	  *command_register = READ_BLOCK;
    	  alt_printf("Read block %x\n\r",sector+i);

    	  /* Wait until the operation completes. */
    	  do {
    	  status = *aux_status_register;
    	  } while ((status & 0x04)!=0);
    	  alt_printf("Read block %x wait done\n\r",sector+i);

    	  for (j=0;j<512;j++)
    		  buffer[i*512+j] = pSD[j];
    	  alt_printf("Read block %x done\n\r",sector+i);

    }

    return 1;
}

int media_write(unsigned long sector, unsigned char *buffer, unsigned long sector_count)
{
//stub here
    return 1;
}

int main()
{ 
  int i;
  unsigned char * pSD = (unsigned char *)ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE;
  short int status;
  int *command_argument_register = ((int *)(ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE + 0x0000022C));
  short int *command_register = ((short int *)(ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE + 0x00000230));
  short int *aux_status_register = ((short int *)(ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE + 0x00000234));

  alt_putstr("Hello from Nios II!\n\r");


  alt_putstr("Waiting for SD card\n\r");
  do {
	  status = *aux_status_register;
  } while ((status & 0x02) == 0);
  alt_putstr("SD card connected\n\r");

  FL_FILE *file;

  // Initialise media
  media_init();

  alt_putstr("Media init done\n\r");

  // Initialise File IO Library
  fl_init();

  alt_putstr("FAT lib  init done\n\r");

  // Attach media access functions to library
  if (fl_attach_media(media_read, media_write) != FAT_INIT_OK)
  {
	  alt_printf("ERROR: Media attach failed\n");
      return 0;
  }

  alt_putstr("Media attached\n\r");

  // List root directory
  fl_listdirectory("/");

  alt_putstr("Directory listed\n\r");

  /* Event loop never exits. */
  while (1);

  return 0;
}
