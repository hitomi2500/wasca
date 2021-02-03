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

#define MAPPER_READ_0 0xC0
#define MAPPER_READ_1 0xC2
#define MAPPER_READ_2 0xC4
#define MAPPER_READ_3 0xC6
#define MAPPER_WRITE_0 0xC8
#define MAPPER_WRITE_1 0xCA
#define MAPPER_WRITE_2 0xCC
#define MAPPER_WRITE_3 0xCE
#define SNIFF_DATA_REG_OFFSET 0xE0
#define SNIFF_FILTER_CONTROL_REG_OFFSET 0xE8
#define SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET 0xEA
#define PCNTR_REG_OFFSET 0xF0
#define MODE_REG_OFFSET 0xF4
#define SWVER_REG_OFFSET 0xF8
extern const unsigned char rawData[131072];
//extern const unsigned char minipseudo[15588];
extern const unsigned char minipseudo_nowait[15588];


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

//----------------------------------------- AUX SD stuff -------------------------------------------
#define MAX_FILES_OPENED				20
typedef struct s_FAT_12_16_boot_sector {
	unsigned char jump_instruction[3];
	char OEM_name[8];
	unsigned short int sector_size_in_bytes;
	unsigned char sectors_per_cluster;
	unsigned short int reserved_sectors;
	unsigned char number_of_FATs;
	unsigned short int max_number_of_dir_entires;
	unsigned short int number_of_sectors_in_partition;
	unsigned char media_descriptor;
	unsigned short int number_of_sectors_per_table;
	unsigned short int number_of_sectors_per_track;
	unsigned short int number_of_heads;
	unsigned int number_of_hidden_sectors;
	unsigned int total_sector_count_if_above_32MB;
	unsigned char drive_number;
	unsigned char current_head;
	unsigned char boot_signature;
	unsigned char volume_id[4];
	char volume_label[11];
	unsigned char file_system_type[8];
	unsigned char bits_for_cluster_index;
	unsigned int first_fat_sector_offset;
	unsigned int second_fat_sector_offset;
	unsigned int root_directory_sector_offset;
	unsigned int data_sector_offset;
} t_FAT_12_16_boot_sector;
typedef struct s_file_record {
	unsigned char name[8];
	unsigned char extension[3];
	unsigned char attributes;
	unsigned short int create_time;
	unsigned short int create_date;
	unsigned short int last_access_date;
	unsigned short int last_modified_time;
	unsigned short int last_modified_date;
	unsigned short int start_cluster_index;
	unsigned int file_size_in_bytes;
	/* The following fields are only used when a file has been created or opened. */
	unsigned int current_cluster_index;
    unsigned int current_sector_in_cluster;
	unsigned int current_byte_position;
    // Absolute location of the file record on the SD Card.
    unsigned int file_record_cluster;
    unsigned int file_record_sector_in_cluster;
    short int    file_record_offset;
    // Is this record in use and has the file been modified.
    unsigned int home_directory_cluster;
    bool         modified;
	bool		 in_use;
} t_file_record;
extern t_file_record active_files[MAX_FILES_OPENED];
extern t_FAT_12_16_boot_sector boot_sector_data;
extern int			fat_partition_offset_in_512_byte_sectors;
//UP SD only supports byte access, and no seek, this is sick!
//Let's patch their write/read funcs, so that they write/read entire 512 bytes block within a file

int alt_up_sd_card_read_512b(short int file_handle, char * buf, int sector_num)
/* Read a 512 bytes sector from a given file. Return -1 if at the end of a file. Any other negative number
 * means that the file could not be read.  */
{
    short int ch = -1;
    int j;

    /*if ((file_handle >= 0) && (file_handle < MAX_FILES_OPENED))
    {
        if (active_files[file_handle].in_use)
        {
        	if (sector_num*512 < active_files[file_handle].file_size_in_bytes)
            {
        		int data_sector = boot_sector_data.data_sector_offset + (active_files[file_handle].start_cluster_index - 2)*boot_sector_data.sectors_per_cluster + sector_num;
                if (!Read_Sector_Data(data_sector, fat_partition_offset_in_512_byte_sectors))
                {
					return -2;
                }
                else
                {
                	char * p2 = (char*)device_pointer->base;
                	for (j=0;j<512;j++)
                		buf[j] =  p2[j];
                	return 512;
                }
            }
        }
    }
    return ch;*/
    return 0;
}


bool alt_up_sd_card_write_512b(short int file_handle, char * buf, int sector_num)
/* Write a 512 bytes sector to a given file. Return true if successful, and false otherwise. */
{
    /*bool result = false;
    int j;

    if ((file_handle >= 0) && (file_handle < MAX_FILES_OPENED))
    {
        if (active_files[file_handle].in_use)
        {
            int data_sector = boot_sector_data.data_sector_offset + (active_files[file_handle].start_cluster_index - 2)*boot_sector_data.sectors_per_cluster + sector_num;

        	char * p2 = (char*)device_pointer->base;
        	for (j=0;j<512;j++)
        		p2[j] = buf[j];

            if (!Write_Sector_Data(data_sector,fat_partition_offset_in_512_byte_sectors))
            {
				return false;
            }
			result = true;
		}
    }

    return result;*/
	return true;
}


//----------------------------------------- AUX SD stuff end-------------------------------------------


int main()
{

  int i,j;
  volatile int k,v;
  volatile unsigned char * pCS0;
  volatile unsigned char * pCS1;
  volatile unsigned char * pCS1_a;
  volatile unsigned short * pCS0_16;
  volatile unsigned short * pRegs_16;
  unsigned short sMode;
  int iteration = 0;
  int ierrors = 0;
  pCS0 = (unsigned char *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
  pCS1 = (unsigned char *)(ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE + 0x2000000);
  pCS0_16 = (unsigned short *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
  pRegs_16 = (unsigned short *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_BASE;
  volatile unsigned char c1,c2,c3,c4;
  volatile unsigned short s1,s2;
  volatile unsigned char readback[256];
  volatile unsigned int iCurrentBlock;
  char backup_filename[16];
  unsigned char LazyBuf[512];

  //startup - switching heartbeat freq
  unsigned short * Heartbeat_p16 = (unsigned short *)HEARTBEAT_0_BASE;
  Heartbeat_p16[0] = 23;//7 Hz

  /*unsigned char UpdateArray[2048];
  for (i=0;i<2048;i++)
	  UpdateArray[i] = 0;*/
  //unsigned char BlockBuffer[512];
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

  //buffered spi test
/*  volatile unsigned short * p16_spi;
  p16_spi = (unsigned short *)BUFFERED_SPI_0_BASE;
  volatile unsigned short b16;
#define BUFFSPI_BUFFER0_WRITE 0x0000
#define BUFFSPI_BUFFER1_WRITE 0x0800
#define BUFFSPI_BUFFER0_READ 0x1000
#define BUFFSPI_BUFFER1_READ 0x1800
#define BUFFSPI_REG_START 0x2000
#define BUFFSPI_REG_LENGTH 0x2001
#define BUFFSPI_REG_COUNTER 0x2002
#define BUFFSPI_REG_CS_MODE 0x2003
#define BUFFSPI_REG_DELAY 0x2004
#define BUFFSPI_REG_BUFFER_SELECT 0x2005
#define BUFFSPI_REG_MAGIC_DEAF 0x2006
#define BUFFSPI_REG_MAGIC_FACE 0x2007
  //setting up the core
  p16_spi[BUFFSPI_REG_LENGTH] = 256; //256 words 16 bit each
  p16_spi[BUFFSPI_REG_CS_MODE] = 1; //cs blinking
  p16_spi[BUFFSPI_REG_DELAY] = 70; //70 clocks @ 116 Mhz between each 16 bit
  p16_spi[BUFFSPI_REG_BUFFER_SELECT] = 0; // using buffer 0

  alt_printf("SPI TEST START\n\r");

  //fill buffer with test data
  for (i=0;i<256;i++)
  {
	  p16_spi[BUFFSPI_BUFFER0_WRITE+i] = i*0x0101;
	  p16_spi[BUFFSPI_BUFFER0_READ+i] = 0xFACE;
  }
  //fire spi transaction
  p16_spi[BUFFSPI_REG_START] = 1; //go go go!

  for (i=0;i<1000;i++)
  {
	  alt_printf("S=%x C=%x  0=%x 128=%x 250=%x\n\r",p16_spi[BUFFSPI_REG_START],p16_spi[BUFFSPI_REG_COUNTER],
			  p16_spi[BUFFSPI_BUFFER0_READ],
			  p16_spi[BUFFSPI_BUFFER0_READ+128],p16_spi[BUFFSPI_BUFFER0_READ+250]);
  }
  alt_printf("SPI TEST END\n\r");*/


  //first things first - copy saturn bootcode into SDRAM
  //wait for SD card
  alt_printf("Waiting for SD ");
  while (0)//(false == alt_up_sd_card_is_Present())
  {
	  alt_printf(".");
	  //alt_up_sd_card_open_dev("/dev/Altera_UP_SD_Card_Avalon_Interface_0");
  }
  alt_printf("done!\n\r");
  if (0)//(false == alt_up_sd_card_is_FAT16())
  {
	  for (i=0;i<10000;i++)
		  ;//alt_printf("EEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
  }
  //open bootloader file
  int _file_handler = 0;//alt_up_sd_card_fopen("WASCALDR.BIN",false);
  if (-1 == _file_handler)
  {
	  for (i=0;i<10000;i++)
		  ;//alt_printf("EEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
  }
  for (i=0;i<256;i++)
  {
	  /*for (j=0;j<512;j++)
		  p[i*512+j] = alt_up_sd_card_read(_file_handler);//; p2[j];*/
	  //alt_up_sd_card_read_512b(_file_handler,&(pCS0[i*512+j]),i);
	  for (j=0;j<512;j++)
	  {
		  pCS0[i*512+j] = rawData[i*512+j];
	  }
	  alt_printf(".");
  }
  //alt_up_sd_card_fclose(_file_handler);
  //now it's minipseudo's time
  _file_handler = 0;//alt_up_sd_card_fopen("PSEUDO.BIN",false);
  if (-1 == _file_handler)
  {
	  for (i=0;i<10000;i++)
		  alt_printf("EEEEEEEEEEEEEEEEEEEEEEEEEEEEE");
  }
  for (i=0;i<32;i++)
  {
	  //for (j=0;j<512;j++)
		 // p[0x9C000 + i*512+j] =  alt_up_sd_card_read(_file_handler);// p2[j];
	  //alt_up_sd_card_read_512b(_file_handler,&(p[0x9C000 + i*512+j]),i);
	  //alt_up_sd_card_read_512b(_file_handler,&(pCS0[0x1800000 + i*512+j]),i);
	  for (j=0;j<512;j++)
	  {
		  pCS0[0x1800000 + i*512+j] = minipseudo_nowait[i*512+j];
	  }
	  alt_printf(".");
  }
  //alt_up_sd_card_fclose(_file_handler);

  /*p = (unsigned char *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
  for (i=0;i<131072;i++)
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
	  alt_printf("%c ",pCS0[i]);
	  if (i%16 == 15) alt_putstr("\n\r");
  }
  alt_putstr("Dump done\n\r");

  //buffered spi test
  //volatile unsigned short * p16_spi;
  /*p16_spi = (unsigned short *)BUFFERED_SPI_0_BASE;
  volatile unsigned short b16;
  //fill buffer
  for (i=0;i<4;i++)
	  p16_spi[i] = i;
  for (i=0;i<4;i++)
	  b16 = p16_spi[i];*/
  //write version

  pRegs_16[SWVER_REG_OFFSET] = SOFTWARE_VERSION;

  //now wait until MODE register is non-zero, i.e. mode is set
  alt_putstr("Waiting for MODE register to be set...\n\r");
  while (pRegs_16[MODE_REG_OFFSET] == 0)
	  {
	  for (k=0;k<1000000;k++);
	  alt_putstr(".");;
	  }
  sMode = pRegs_16[MODE_REG_OFFSET];
  alt_printf("Mode set to %x\n\r",sMode);
  //okay, now start a MODE-dependent preparation routine
  //lower octets have higher priority
  if ((sMode & 0x000F) != 0)
  {
	  alt_printf("Octet 0, value %x\n\r",(sMode & 0x000F));
	  //lowest octet is active, it's a POWER MEMORY
	  //we should copy relevant image from SD card
	  //for now, we will only write header and emulate copying behavior
	  switch (sMode & 0x000F )
	  {
	  case 0x1 : //0.5 MB
		  alt_putstr("Preparing 0.5M backup RAM");
		  strcpy(backup_filename,"BACKUP05.BIN");
		  _file_handler = 0;//alt_up_sd_card_fopen(backup_filename,false);
		  for (i=0;i<2048;i++)
		  {
			  pRegs_16[PCNTR_REG_OFFSET]=i/21;
			  alt_putstr(".");
			  for (j=0;j<512;j++)
				  pCS1[i*512+j] =  0;//alt_up_sd_card_read(_file_handler);
		  }
		  pRegs_16[PCNTR_REG_OFFSET] = 100;
		  //alt_up_sd_card_fclose(_file_handler);
		  alt_putstr("Done\n\r");
		  break;
	  case 0x2 : //1 MB
		  alt_putstr("Preparing 1M backup RAM");
		  strcpy(backup_filename,"BACKUP1.BIN");
		  _file_handler = 0;//alt_up_sd_card_fopen(backup_filename,false);
		  for (i=0;i<4096;i++)
		  {
			  pRegs_16[PCNTR_REG_OFFSET]=i/41;
			  alt_putstr(".");
			  for (j=0;j<512;j++)
				  pCS1[i*512+j] =  0;//alt_up_sd_card_read(_file_handler);
		  }
		  pRegs_16[PCNTR_REG_OFFSET] = 100;
		  //alt_up_sd_card_fclose(_file_handler);
		  alt_putstr("Done\n\r");
		  break;
	  case 0x3 : //2 MB
		  alt_putstr("Preparing 2M backup RAM");
		  strcpy(backup_filename,"BACKUP2.BIN");
		  _file_handler = 0;//alt_up_sd_card_fopen(backup_filename,false);
		  for (i=0;i<8192;i++)
		  {
			  pRegs_16[PCNTR_REG_OFFSET]=i/82;
			  alt_putstr(".");
			  for (j=0;j<512;j++)
				  pCS1[i*512+j] =  0;//alt_up_sd_card_read(_file_handler);
		  }
		  pRegs_16[PCNTR_REG_OFFSET] = 100;
		  //alt_up_sd_card_fclose(_file_handler);
		  alt_putstr("Done\n\r");
		  break;
	  case 0x04 : //4 MB
		  alt_putstr("Preparing 4M backup RAM");
		  strcpy(backup_filename,"BACKUP4.BIN");
		  _file_handler = 0;//alt_up_sd_card_fopen(backup_filename,false);
		  for (i=0;i<16384;i++)
		  {
			  pRegs_16[PCNTR_REG_OFFSET]=i/164;
			  alt_putstr(".");
			  for (j=0;j<512;j++)
				  pCS1[i*512+j] =  0;//alt_up_sd_card_read(_file_handler);
		  }
		  pRegs_16[PCNTR_REG_OFFSET] = 100;
		  //alt_up_sd_card_fclose(_file_handler);
		  alt_putstr("Done\n\r");
		  break;
	  }
	  //mapper stuff
	  pRegs_16[MAPPER_WRITE_0] = 0;//lock cs0 writes
	  pRegs_16[MAPPER_WRITE_1] = 0;//lock cs0 writes
	  pRegs_16[MAPPER_WRITE_2] = 0xFFFF;//keep all cs1 writes unlocked
	  pRegs_16[MAPPER_WRITE_3] = 0;//lock cs2 writes
	  pRegs_16[MAPPER_READ_0] = 0;//unmap cs0
	  pRegs_16[MAPPER_READ_1] = 0x8100;//unmap cs0, leave regs and minipseudo areas
	  pRegs_16[MAPPER_READ_2] = 0xFFFF;//keep cs1 mapped
	  pRegs_16[MAPPER_READ_3] = 0;//unmap cs2
	  //if we're in backup mode, we should keep syncing forever
	  pRegs_16[SNIFF_FILTER_CONTROL_REG_OFFSET] = 0x0A; //only writes on CS1
	  while (pRegs_16[SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET] > 0)
		  iCurrentBlock = pRegs_16[SNIFF_DATA_REG_OFFSET]; //flush previous fifo content
	  int iLazyCheckCounter = 0;
	  while (1)
	  {//backup sync start
		  // sync is done using a 1024 entry deep fifo. when a transaction occurs within a 512-b sector different to current one,
		  // the buffer is flused to SD, the new one is loaded from SD, and only then the processing continues
		  // if the fifo is overfilled ( > 1024 samples), issue an error message
		  while (pRegs_16[SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET] > 0)
		  {
			  _file_handler = 0;//alt_up_sd_card_fopen(backup_filename,false);
			  //check if close to overfill
			  /*if (p16[SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET] > 1020)
			  {
				  //fifo almost overfilled, let's panic!
				  for (i=0;i<10000;i++)
					  alt_printf("FFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
			  }*/
			  //access data in fifo, checking address
			  iCurrentBlock = pRegs_16[SNIFF_DATA_REG_OFFSET];
			  //flushing block to file
			  pCS1_a = (unsigned char *)(ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE+0x2000000+512*iCurrentBlock);
			  alt_up_sd_card_write_512b(_file_handler,pCS1_a,iCurrentBlock);
			  //blinking led
			  alt_printf("SYNC %x(%x) <%x %x> ",iCurrentBlock,iCurrentBlock,pRegs_16[SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET]);
			  /*UpdateArray[iCurrentBlock] = 1;
			  if (3 == iCurrentBlock)
			  {
				  alt_printf("\r\n REPORT:\r\n");
				  for (i=0;i<2048;i++)
				  {
					  if (UpdateArray[i] != 1)
						alt_printf("NOT SYNCED:  %x(%x)%x \r\n",iCurrentBlock,iCurrentBlock,iCurrentBlock);
				  }
			  }*/
			  //alt_up_sd_card_fclose(_file_handler);
		  }
		  //doing a lazy sync check
		  /*_file_handler = alt_up_sd_card_fopen(backup_filename,false);
		  alt_up_sd_card_read_512b(_file_handler, LazyBuf, iLazyCheckCounter);
		  bool bLazyFound = false;
		  for (j=0;j<512;j++)
		  {
			  if (LazyBuf[j] != p[iLazyCheckCounter*512+j])
				  bLazyFound = true;
		  }
		  if (bLazyFound)
		  {
			  p2 = (unsigned char *)(ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE+512*iLazyCheckCounter);
			  //alt_up_sd_card_write_512b(_file_handler,p2,iLazyCheckCounter);
			  alt_printf(" LAZY %x(%x) ",iLazyCheckCounter,iLazyCheckCounter);
		  }
		  alt_up_sd_card_fclose(_file_handler);
		  iLazyCheckCounter++;
		  if (iLazyCheckCounter > 1023)
		  {
			  iLazyCheckCounter = 0;
			  alt_printf(" LAZY OVERLAP ");
		  }*/

	  }//backup sync end
  }
  else if ((sMode & 0x00F0) != 0)
  {
	  alt_printf("Octet 1, value %x\n\r",(sMode & 0x00F0));
	  //RAM expansion cart, clear bootrom's signature just in case
	  for (i=0;i<256;i++) pCS0[i] = 0;
	  //and that is all for RAM cart
	  pRegs_16[PCNTR_REG_OFFSET]=100;
  }
  else if ((sMode & 0x0F00) != 0)
  {
	  alt_printf("Octet 2, value %x\n\r",(sMode & 0x0F00));
	  //ROM
	  switch (sMode & 0x0F00 )
	  {
	  case 0x100 : //kof95
		  alt_putstr("Preparing KoF'95 ROM");
		  strcpy(backup_filename,"KOF95.BIN");
		  _file_handler = 0;//alt_up_sd_card_fopen(backup_filename,false);
		  for (i=0;i<4096;i++)
		  {
			  pRegs_16[PCNTR_REG_OFFSET]=i/41;
			  alt_putstr(".");
			  for (j=0;j<512;j++)
				  pCS0[i*512+j] =  0;//alt_up_sd_card_read(_file_handler);
		  }
		  pRegs_16[PCNTR_REG_OFFSET] = 100;
		  //alt_up_sd_card_fclose(_file_handler);
		  //mapper stuff
		  pRegs_16[MAPPER_WRITE_0] = 0;//lock cs0 writes
		  pRegs_16[MAPPER_WRITE_1] = 0;//lock cs0 writes
		  pRegs_16[MAPPER_WRITE_2] = 0;//lock cs1 writes
		  pRegs_16[MAPPER_WRITE_3] = 0;//lock cs2 writes
		  pRegs_16[MAPPER_READ_0] = 3;//unmap cs0, leave first 2 megs
		  pRegs_16[MAPPER_READ_1] = 0x8100;//unmap cs0, leave regs and minipseudo areas
		  pRegs_16[MAPPER_READ_2] = 0;//unmap cs1
		  pRegs_16[MAPPER_READ_3] = 0;//unmap cs2
		  alt_putstr("Done\n\r");
		  break;
	  case 0x200 : //Ultraman
		  alt_putstr("Preparing Ultraman ROM");
		  strcpy(backup_filename,"ULTRAMAN.BIN");
		  _file_handler = 0;//alt_up_sd_card_fopen(backup_filename,false);
		  for (i=0;i<4096;i++)
		  {
			  pRegs_16[PCNTR_REG_OFFSET]=i/41;
			  alt_putstr(".");
			  for (j=0;j<512;j++)
				  pCS0[i*512+j] =  0;//alt_up_sd_card_read(_file_handler);
		  }
		  pRegs_16[PCNTR_REG_OFFSET] = 100;
		  //alt_up_sd_card_fclose(_file_handler);
		  //mapper stuff
		  pRegs_16[MAPPER_WRITE_0] = 0;//lock cs0 writes
		  pRegs_16[MAPPER_WRITE_1] = 0;//lock cs0 writes
		  pRegs_16[MAPPER_WRITE_2] = 0;//lock cs1 writes
		  pRegs_16[MAPPER_WRITE_3] = 0;//lock cs2 writes
		  pRegs_16[MAPPER_READ_0] = 3;//unmap cs0, leave first 2 megs
		  pRegs_16[MAPPER_READ_1] = 0x8100;//unmap cs0, leave regs and minipseudo areas
		  pRegs_16[MAPPER_READ_2] = 0;//unmap cs1
		  pRegs_16[MAPPER_READ_3] = 0;//unmap cs2
		  alt_putstr("Done\n\r");
		  break;
	  }
  }
  else
  {
	  alt_printf("UNKNOWN MODE %x\n\r",sMode);
	  pRegs_16[PCNTR_REG_OFFSET]=100;
  }

  //stop
  while (1);

  return 0;
}
