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

#include <sys/alt_stdio.h>
#include <string.h>
#include <system.h>


#include "wasca_defs.h"
#include "crc.h"
#include "heartbeat.h"
#include "log.h"
#include "m10_ver_infos.h"
#include "perf_cntr.h"
#include "spi_stm32.h"


#define SOFTWARE_VERSION 0x0002

#define MAPPER_READ_0                       0xC0
#define MAPPER_READ_1                       0xC2
#define MAPPER_READ_2                       0xC4
#define MAPPER_READ_3                       0xC6
#define MAPPER_WRITE_0                      0xC8
#define MAPPER_WRITE_1                      0xCA
#define MAPPER_WRITE_2                      0xCC
#define MAPPER_WRITE_3                      0xCE
#define SNIFF_DATA_REG_OFFSET               0xE0
#define SNIFF_FILTER_CONTROL_REG_OFFSET     0xE8
#define SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET  0xEA
#define PCNTR_REG_OFFSET                    0xF0
#define MODE_REG_OFFSET                     0xF4
#define SWVER_REG_OFFSET                    0xF8

// const char Power_Memory_Signature[16] = "BackUpRam Format";
// const char Wasca_Sysarea_Signature[64] =
// {
//     0x80, 0x00, 0x00, 0x00, 0x77, 0x61, 0x73, 0x63,
//     0x61, 0x20, 0x73, 0x79, 0x73, 0x20, 0x20, 0x01,
//     0xBE, 0xB6, 0xDE, 0xBB, 0xC0, 0xB0, 0xDD, 0x2C,
//     0xBC, 0xDB, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
//     0x0E, 0x74, 0x7F, 0xFC, 0x7F, 0xFD, 0x7F, 0xFE,
//     0x7F, 0xFF, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
//     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
//     0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
// };



/*
 * ------------------------------------------
 * - DEBUG: LEDs blinking function ----------
 * ------------------------------------------
 */
void blink_the_leds(void)
{
#if 1 /* Periodically change LED blinking rate and sent log message on UART too = easily check if Nios program is still alive or not. */
    int j = 0;
    while(1)
    {
        if(j % 2)
        {
            HEARTBEAT_FAST();
            log_to_uart("fast");
        }
        else
        {
            HEARTBEAT_SLOW();
            log_to_uart("slow");
        }

        /* Wait for around 1.2 sec. */
        for(int i=0; i<(10*1000*1000); i++) {;}

        j++;
    }

#else /* Simply make the LED blinking. */

    int i = 0;

    while(1)
    {
        unsigned char led = 0;

#define LEDS_BLINK_PERIOD (8*16000)
        if(i < (LEDS_BLINK_PERIOD / 2))
        {
            led = 1;
        }

        HEARTBEAT_FORCE(led);

        i++;
        if(i > LEDS_BLINK_PERIOD)
        {
            i = 0;
        }
    }
#endif
}




void load_boot_rom(unsigned char rom_id)
{
    volatile unsigned short * pRegs_16 = (unsigned short *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_BASE;
    unsigned char* boot_rom = (unsigned char*)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;

    log_to_uart("[Boot ROM]START");

    WASCA_PERF_START_MEASURE();
    /* Retrieve ROM file size. */
    wl_spi_bootinfo_t info = { 0 };
    spi_boot_getinfo(rom_id, &info);

    log_to_uart("[Boot ROM]Size=%u KB, status:%u, path:\"%s\"", info.size>>10, info.status, info.path);

    /* Read ROM data. */
    unsigned long rom_size = info.size;
    unsigned long offset = 0;

    for(offset=0; offset<rom_size; offset+=WL_SPI_DATA_MAXLEN)
    {
        /* Provide read status to Saturn. */
        unsigned long status = (offset * 99);
        status = status / rom_size;
        pRegs_16[PCNTR_REG_OFFSET] = (unsigned short)status;

        unsigned long block_len = WL_SPI_DATA_MAXLEN;
        if((offset + WL_SPI_DATA_MAXLEN) > rom_size)
        {
            block_len = rom_size - offset;
        }

        if(((offset / WL_SPI_DATA_MAXLEN) % 100) == 0)
        {
            log_to_uart("[Boot ROM]Reading from block %5u ...", offset / WL_SPI_DATA_MAXLEN);
        }
        // logflush();

        spi_boot_readdata(rom_id, offset, block_len, boot_rom+offset);
    }

    /* Clear unused part of boot ROM area.
     * This is not necessary, but a good way of doing
     * in the case of loading a ROM over a larger one, 
     * or when ROM could not be loaded.
     *
     * In the case of Pseudo Saturn, size is 1MB, 
     * and it is 2MB in the case of game boot ROM.
     */
    unsigned long fill_len = (rom_id == 0 ? 1*1024*1024 : 2*1024*1024);
    if(fill_len > rom_size)
    {
        memset(boot_rom + rom_size, 0xFF, fill_len - rom_size);
    }

    /* Mark read status as terminated. */
    pRegs_16[PCNTR_REG_OFFSET] = 100;

    WASCA_PERF_STOP_MEASURE();
    unsigned long elapsed = wasca_perf_get_usec(WASCA_PERF_GET_TIME());

    elapsed = elapsed / 1000;
    if(elapsed == 0)
    {
        elapsed = 1;
    }
    unsigned long kbps = rom_size / elapsed;

    elapsed = elapsed / 100;

    unsigned long crc32 = crc32_calc(boot_rom, rom_size);

    log_to_uart("[Boot ROM]Read ended. Size:%u KB, Time:%u.%u sec, %u KB/s, CRC=%x", 
        rom_size>>10, 
        elapsed / 10, elapsed % 10, 
        kbps, 
        crc32);

    // log_to_uart("[Boot ROM]Header: %c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c", 
    //     boot_rom[ 0], boot_rom[ 1], boot_rom[ 2], boot_rom[ 3], 
    //     boot_rom[ 4], boot_rom[ 5], boot_rom[ 6], boot_rom[ 7], 
    //     boot_rom[ 8], boot_rom[ 9], boot_rom[10], boot_rom[11], 
    //     boot_rom[12], boot_rom[13], boot_rom[14], boot_rom[15]);
}


void wasca_startup(void)
{
    volatile unsigned short * pRegs_16 = (unsigned short *) ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_BASE;

    HEARTBEAT_FAST();

    /*--------------------------------------------*/
    /* Initialize log internals. */
    log_init();


    /*--------------------------------------------*/
    /* Initialize block SPI module internals.     */
    spi_init();

    // /* Wait for around 2.5 sec before using SPI.
    //  * (Just for debug, will be removed soon)
    //  */
    // log_to_uart("MAX 10 STT1");
    // for(int i=0; i<(20*1000*1000); i++)
    // {
    //     HEARTBEAT_SLOW();
    // }
    // HEARTBEAT_FAST();
    // log_to_uart("MAX 10 STT2");

    /*--------------------------------------------*/
    /* Exchange version information with STM32.   */
    {
        /* TODO : should store each version information somewhere in SDRAM
         *        so that SH-2 can access to it any time after that.
         */
        wl_verinfo_max_t max_ver_dat = {0};
        wl_verinfo_max_t* max_ver = &max_ver_dat;

        wl_verinfo_stm_t arm_ver_dat = {0};
        wl_verinfo_stm_t* arm_ver = &arm_ver_dat;
        spi_exc_version(max_ver, arm_ver);

        arm_ver->build_date[sizeof(arm_ver->build_date)-1] = '\0';
        arm_ver->build_time[sizeof(arm_ver->build_time)-1] = '\0';
        log_to_uart("STM32 FW build_date:\"%s\"", arm_ver->build_date);
        log_to_uart("STM32 FW build_time:\"%s\"", arm_ver->build_time);
    }


#if 0 // Test continous ROM loading (DEBUG)
    int load_counter = 0;
    while(1)
    {
        if(load_counter % 2)
        {
            HEARTBEAT_FAST();
        }
        else
        {
            HEARTBEAT_SLOW();
        }
        load_counter++;
    
        load_boot_rom(0/*ROM ID*/);
    
        log_to_uart("ROM load count : %u", load_counter);
    }
#endif // Test continous ROM loading (DEBUG)


    /*--------------------------------------------*/
    /* Load Pseudo Saturn from SD card to SDRAM.  */
// HEARTBEAT_FORCE(1);
    load_boot_rom(0/*ROM ID*/);
// HEARTBEAT_FORCE(0);


    /* Write version. */
    pRegs_16[SWVER_REG_OFFSET] = SOFTWARE_VERSION;


//blink_the_leds();


    /* Initialization ended : blink the LED at slow speed. */
    HEARTBEAT_SLOW();
}



int main(void)
{
    int i;
    volatile unsigned char  * pCS0     = (unsigned char  *) ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
    volatile unsigned char  * pCS1     = (unsigned char  *)(ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE + 0x2000000);
    // volatile unsigned short * pCS0_16  = (unsigned short *) ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
    volatile unsigned short * pRegs_16 = (unsigned short *) ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_BASE;


#if 0
    /* Setup UART link speed.
     * Let's use super slow speed to avoid characters to be eaten by UART.
     */
    {
        unsigned long freq_tmp2 = 2 * UART_0_FREQ;
        //unsigned long br2 = 9600;
        unsigned long br2 = 115200;
        freq_tmp2 = freq_tmp2 / br2;
        ((unsigned long*)UART_0_BASE)[4] = freq_tmp2 / 2;
        log_to_uart("UART Baud Rate : %u bps", br2);
    }
#endif

    /*--------------------------------------------------*/
    /* Load boot ROM and do other misc initializations. */
    wasca_startup();

    /*----------------------------------------------------------------*/
    /* Poll MODE register and setup Wasca accordingly when it is set. */
    unsigned short prev_mode_reg = 0;
    int bram_mode = 0;

    int loop_counter = 0;
    while(1)
    {
        volatile unsigned short current_block;
        unsigned short mode_reg = pRegs_16[MODE_REG_OFFSET];

        /* Re-init internals in the case MODE register changed. */
        if(mode_reg != prev_mode_reg)
        {
            log_to_uart("Mode set to %x",mode_reg);

            /* If we were emulating backup memory until now, 
             * close its file before starting a new mode initialization.
             */
            if(bram_mode)
            {
                spi_bup_close();
                bram_mode = 0;
            }

            /* Okay, now start a MODE-dependent preparation routine.
             * lower octets have higher priority.
             */
            if((mode_reg & 0x000F) != 0)
            {
                log_to_uart("Octet 0, value %x", (mode_reg & 0x000F));

                /* Lowest nibble is active, it's a backup memory.
                 * Bit 0-4 values :
                 *  - 1 : 0.5 MB
                 *  - 2 : 1 MB
                 *  - 3 : 2 MB
                 *  - 4 : 4 MB
                 */
                unsigned long size_kb = 256 << (mode_reg & 0x000F);
                if(size_kb > 4096)
                {
                    size_kb = 4096;
                }

                /* Initialize SDRAM with backup memory file from SD card. */
                log_to_uart("Preparing backup RAM");
                spi_bup_open(size_kb);
                unsigned long count = size_kb * 4;
                for(i=0; i<count; i++)
                {
                    unsigned long status = 99 * i;
                    status = status / count;
                    pRegs_16[PCNTR_REG_OFFSET] = (unsigned short)status;

                    log_to_uart(".");

                    spi_bup_read(i/*ID*/, 512/*size*/, (unsigned char*)(pCS1 + (i*512)));
                }
                pRegs_16[PCNTR_REG_OFFSET] = 100;
                log_to_uart("Done");

                /* Setup mapper stuff. */
                pRegs_16[MAPPER_WRITE_0] =      0; /* Lock cs0 writes.                            */
                pRegs_16[MAPPER_WRITE_1] =      0; /* Lock cs0 writes.                            */
                pRegs_16[MAPPER_WRITE_2] = 0xFFFF; /* Keep all cs1 writes unlocked.               */
                pRegs_16[MAPPER_WRITE_3] =      0; /* Lock cs2 writes.                            */
                pRegs_16[MAPPER_READ_0 ] =      0; /* Unmap cs0.                                  */
                pRegs_16[MAPPER_READ_1 ] = 0x8100; /* Unmap cs0, leave regs and minipseudo areas. */
                pRegs_16[MAPPER_READ_2 ] = 0xFFFF; /* Keep cs1 mapped.                            */
                pRegs_16[MAPPER_READ_3 ] =      0; /* Unmap cs2.                                  */

                /* Flush previous fifo content. */
                pRegs_16[SNIFF_FILTER_CONTROL_REG_OFFSET] = 0x0A; /* Only writes on CS1. */
                while(pRegs_16[SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET] > 0)
                {
                    current_block = pRegs_16[SNIFF_DATA_REG_OFFSET];
                }

                /* Indicate that backup memory contents will need to be
                 * synchronized to SD card when Saturn modifies it.
                 */
                bram_mode = 1;
            }
            else if((mode_reg & 0x00F0) != 0)
            {
                log_to_uart("Octet 1, value %x",(mode_reg & 0x00F0));

                /* RAM expansion cart, clear bootrom's signature just in case. */
                for(i=0;i<256;i++)
                {
                    pCS0[i] = 0;
                }

                /* and that is all for RAM cart. */
                pRegs_16[PCNTR_REG_OFFSET] = 100;
            }
            else if((mode_reg & 0x0F00) != 0)
            {
                log_to_uart("Octet 2, value %x",(mode_reg & 0x0F00));
                /* KOF95/Ultraman boot ROM :
                 *  - 0x01 : KOF95
                 *  - 0x02 : Ultraman
                 */
                unsigned char rom_id = (unsigned char)((mode_reg & 0x0F00) >> 8);

                log_to_uart("Preparing KoF'95 / Ultraman ROM");
                load_boot_rom(rom_id);

                /* Mapper stuff. */
                pRegs_16[MAPPER_WRITE_0] =      0; /* Lock cs0 writes.                            */
                pRegs_16[MAPPER_WRITE_1] =      0; /* Lock cs0 writes.                            */
                pRegs_16[MAPPER_WRITE_2] =      0; /* Lock cs1 writes.                            */
                pRegs_16[MAPPER_WRITE_3] =      0; /* Lock cs2 writes.                            */
                pRegs_16[MAPPER_READ_0 ] =      3; /* Unmap cs0, leave first 2 megs.              */
                pRegs_16[MAPPER_READ_1 ] = 0x8100; /* Unmap cs0, leave regs and minipseudo areas. */
                pRegs_16[MAPPER_READ_2 ] =      0; /* Unmap cs1.                                  */
                pRegs_16[MAPPER_READ_3 ] =      0; /* Unmap cs2.                                  */

                log_to_uart("Done");
            }
            else
            {
                log_to_uart("UNKNOWN MODE %x", mode_reg);
                pRegs_16[PCNTR_REG_OFFSET] = 100;
            }


            /* Mode initialization ended : keep track of mode value
             * in order to detect change after that.
             */
            prev_mode_reg = mode_reg;
        }


        /* Backup memory contents synchronization. */
        if(bram_mode)
        {
            /* Sync is done using a 1024 entry deep fifo.
             * When a transaction occurs within a 512-b sector different to current one,
             * the buffer is flused to SD, the new one is loaded from SD, and only then the processing continues.
             * If the fifo is overfilled ( > 1024 samples), issue an error message.
             */
            while(pRegs_16[SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET] > 0)
            {
                /* Check if close to overfill. */
                // if(p16[SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET] > 1020)
                // {
                //     //fifo almost overfilled, let's panic!
                //     for(i=0;i<10000;i++)
                //     log_to_uart("FFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
                // }

                /* Access data in fifo, checking address. */
                current_block = pRegs_16[SNIFF_DATA_REG_OFFSET];

                /* Flushing block to file. */
                unsigned char* pCS1_a = (unsigned char *)(ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE + 0x2000000 + (512*current_block));
                spi_bup_read(current_block/*ID*/, 512/*size*/, pCS1_a);

                /* Blinking led. */
                log_to_uart("SYNC %x(%x) <%x> ", current_block, current_block, pRegs_16[SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET]);
            }
        }

        /* Check from time to time logs messages remaining in buffer, 
         * and send them to STM32 if necessary.
         */
        if((loop_counter % 16) == 0)
        {
            logflush();
        }

        loop_counter++;
    }

    /* Never reached. */
    return 0;
}
