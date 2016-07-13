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
#include "altera_avalon_spi.h"
#include "altera_avalon_spi_regs.h"

#define READ_BLOCK 17

void SD_command_native(unsigned char cmd, unsigned long arg,
                unsigned char crc, unsigned char read,
                unsigned char * buffer) {
    unsigned char i;
    unsigned char c;
    alt_u32 status;
    alt_u32 currentbyte_tx;
    alt_u32 currentbyte_rx;

    alt_32 credits = 1;
    IOWR_ALTERA_AVALON_SPI_SLAVE_SEL(SPI_0_BASE, 1);
    IOWR_ALTERA_AVALON_SPI_CONTROL(SPI_0_BASE, ALTERA_AVALON_SPI_CONTROL_SSO_MSK);
    IORD_ALTERA_AVALON_SPI_RXDATA(SPI_0_BASE);

    /* Keep clocking until all the data has been processed. */
    currentbyte_tx = 0;
    currentbyte_rx = 0;
    while (currentbyte_rx < (7+read) )
    {
  	  do
 	      {
  	        status = IORD_ALTERA_AVALON_SPI_STATUS(SPI_0_BASE);
  	      }
  	      while (((status & ALTERA_AVALON_SPI_STATUS_TRDY_MSK) == 0 || credits == 0) &&
  	              (status & ALTERA_AVALON_SPI_STATUS_RRDY_MSK) == 0);

  	  if ((status & ALTERA_AVALON_SPI_STATUS_TRDY_MSK) != 0 && credits > 0 && currentbyte_tx < (7+read))
  	      {
  	        credits--;
  	        switch (currentbyte_tx)
  	        {
  	        case 0:
  	        	IOWR_ALTERA_AVALON_SPI_TXDATA(SPI_0_BASE, cmd);
  	        	break;
  	        case 1:
  	        	IOWR_ALTERA_AVALON_SPI_TXDATA(SPI_0_BASE, (char)(arg>>24));
  	        	break;
  	        case 2:
  	        	IOWR_ALTERA_AVALON_SPI_TXDATA(SPI_0_BASE, (char)(arg>>16));
  	        	break;
  	        case 3:
  	        	IOWR_ALTERA_AVALON_SPI_TXDATA(SPI_0_BASE, (char)(arg>>8));
  	        	break;
  	        case 4:
  	        	IOWR_ALTERA_AVALON_SPI_TXDATA(SPI_0_BASE, (char)(arg));
  	        	break;
  	        case 5:
  	        	IOWR_ALTERA_AVALON_SPI_TXDATA(SPI_0_BASE, crc);
  	        	break;
  	        default:
  	        	IOWR_ALTERA_AVALON_SPI_TXDATA(SPI_0_BASE, 0xFF);
  	        	break;
 	        }
  	      currentbyte_tx++;

   	    }

      if ((status & ALTERA_AVALON_SPI_STATUS_RRDY_MSK) != 0)
      {
    	if (currentbyte_rx>6)
        buffer[currentbyte_rx-7] = IORD_ALTERA_AVALON_SPI_RXDATA(SPI_0_BASE);
        currentbyte_rx++;
        credits++;

      }

    }

    IOWR_ALTERA_AVALON_SPI_CONTROL(SPI_0_BASE, 0);

}


void SD_feed_single_clock() {
    unsigned char i;
    unsigned char c;
    alt_u32 status;

    IOWR_ALTERA_AVALON_SPI_SLAVE_SEL(SPI_0_BASE, 0);
    //IOWR_ALTERA_AVALON_SPI_CONTROL(SPI_0_BASE, ALTERA_AVALON_SPI_CONTROL_SSO_MSK);
    IORD_ALTERA_AVALON_SPI_RXDATA(SPI_0_BASE);

    /* Keep clocking until all the data has been processed. */
      do
 	      {
  	        status = IORD_ALTERA_AVALON_SPI_STATUS(SPI_0_BASE);
  	      }
  	      while ((status & ALTERA_AVALON_SPI_STATUS_TRDY_MSK) == 0 );

  	IOWR_ALTERA_AVALON_SPI_TXDATA(SPI_0_BASE, 0xFF);

    //IOWR_ALTERA_AVALON_SPI_CONTROL(SPI_0_BASE, 0);

}


void SD_command(unsigned char cmd, unsigned long arg,
                unsigned char crc, unsigned char read,
                unsigned char * buffer) {
    unsigned char i;//, buffer[8];
    unsigned char c;

    c=cmd;
    alt_avalon_spi_command(SPI_0_BASE,0,1,&c,0,&c,ALT_AVALON_SPI_COMMAND_MERGE);
    c=arg>>24;
    alt_avalon_spi_command(SPI_0_BASE,0,1,&c,0,&c,ALT_AVALON_SPI_COMMAND_MERGE);
    c=arg>>16;
    alt_avalon_spi_command(SPI_0_BASE,0,1,&c,0,&c,ALT_AVALON_SPI_COMMAND_MERGE);
    c=arg>>8;
    alt_avalon_spi_command(SPI_0_BASE,0,1,&c,0,&c,ALT_AVALON_SPI_COMMAND_MERGE);
    c=arg;
    alt_avalon_spi_command(SPI_0_BASE,0,1,&c,0,&c,ALT_AVALON_SPI_COMMAND_MERGE);
    c=crc;
    alt_avalon_spi_command(SPI_0_BASE,0,1,&c,0,&c,ALT_AVALON_SPI_COMMAND_MERGE);

    c=0xFF;
    for(i=0; i<(read-1); i++)
        alt_avalon_spi_command(SPI_0_BASE,0,1,&c,1,&(buffer[i]),ALT_AVALON_SPI_COMMAND_MERGE);

    alt_avalon_spi_command(SPI_0_BASE,0,1,&c,1,&(buffer[read-1]),0);

}

int media_init()
{
    // ...
    return 1;
}

int media_read(unsigned long sector, unsigned char *buffer, unsigned long sector_count)
{
    unsigned long i,j;
    short int status;
 /*   unsigned char * pSD = (unsigned char *)ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE;
    int *command_argument_register = ((int *)(ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE + 0x0000022C));
    short int *command_register = ((short int *)(ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE + 0x00000230));
    short int *aux_status_register = ((short int *)(ALTERA_UP_SD_CARD_AVALON_INTERFACE_0_BASE + 0x00000234));

    for (i=0;i<sector_count;i++)
    {
  	  // Wait until the operation completes.
  	  do {
  	  status = *aux_status_register;
  	  } while ((status & 0x04)!=0);
  	  alt_printf("Read block %x wait done\n\r",sector+i);

  	  // Read 1st sector on the card
    	  *command_argument_register = (sector+i) * 512;
    	  *command_register = READ_BLOCK;
    	  alt_printf("Read block %x\n\r",sector+i);

    	  // Wait until the operation completes.
    	  do {
    	  status = *aux_status_register;
    	  } while ((status & 0x04)!=0);
    	  alt_printf("Read block %x wait done\n\r",sector+i);

    	  for (j=0;j<512;j++)
    		  buffer[i*512+j] = pSD[j];
    	  alt_printf("Read block %x done\n\r",sector+i);

    }*/

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
  unsigned char writebuf[512];
  unsigned char readbuf[512];
  char c;
  //unsigned char buffer[8];

  alt_putstr("Hello from Nios II!\n\r");

  //give SD card some clocks to init
  /*for (i=0;i<100;i++)
  {
	  SD_command(0x40,0x00000000,0x95,1,readbuf);
  }*/

  //cmd0, cmd8, cmd58
  //SD_command_native(0xFF,0xFFFFFFFF,0xFF,0,readbuf);
  //SD_command_native(0xFF,0xFFFFFFFF,0xFF,0,readbuf);
  for (i=0;i<10;i++)
	  SD_feed_single_clock();
  SD_command_native(0x40,0x00000000,0x95,1,readbuf);
  if (readbuf[0]!= 0x01)
	  alt_printf("CMD 0 FAIL! Responce: %x \n\r",readbuf[0]);
  SD_command_native(0x48,0x00000155,0x75,6,readbuf);
  if ( (readbuf[0]!= 0x01) || (readbuf[3]!=0x01) || (readbuf[4]!=0x55) )
	  alt_printf("CMD 8 FAIL! Responce: %x %x %x %x %x %x \n\r",readbuf[0],readbuf[1],readbuf[2],readbuf[3],readbuf[4],readbuf[5]);
  //do
  {
	  SD_command_native(0x69,0x50FF8000,0x77,6,readbuf);
	  alt_printf("ACMD41 Responce: %x %x %x %x %x %x \n\r",readbuf[0],readbuf[1],readbuf[2],readbuf[3],readbuf[4],readbuf[5]);
  }


  alt_printf("SD init done\n\r");

  /*alt_putstr("Waiting for SD card\n\r");
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
