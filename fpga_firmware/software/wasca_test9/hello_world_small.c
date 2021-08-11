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

/* The base settings, retrieved from STM32 on startup. */
wl_baseset_max_t _baseset = {0};



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


/*
 * ------------------------------------------
 * - DEBUG: test SPI communication ----------
 * ------------------------------------------
 */
unsigned long _spi_ping_cnt = 0;
wl_spi_ping_verif_t _spi_ping_verif_m10 = {0};
wl_spi_ping_verif_t _spi_ping_verif_s32 = {0};
void do_spi_ping_test(void)
{
    /* TODO : in the future, it may be good to allow setting
     * of these parameters from SH-2.
     */
    wl_spi_ping_params_t params = {0};
    params.data_len = WL_SPI_DATA_MAXLEN - sizeof(wl_spi_ping_verif_t);
    params.crc_len  = params.data_len;
    params.pattern  = WL_SPI_PING_INCREMENT;//WL_SPI_PING_RANDOM;
    params.pattern_seed = _spi_ping_cnt; /* Not super random ... */

    /* Set buffer to test data to a relatively unused area in SDRAM. */
    unsigned char* txrx_buffer = ((unsigned char *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_BASE) + (30 * 1024 * 1024);

    /* On first test, initialize test results. */
    if(_spi_ping_cnt == 0)
    {
        memset(&_spi_ping_verif_m10, 0, sizeof(wl_spi_ping_verif_t));
        memset(&_spi_ping_verif_s32, 0, sizeof(wl_spi_ping_verif_t));
    }

    spi_ping_test(&params, &_spi_ping_verif_m10, &_spi_ping_verif_s32, txrx_buffer);

    /* Periodically log SPI test results.
     * Note : as results concern previous test, it's a good idea to
     *        output result from second pass.
     */
    if((_spi_ping_cnt % 100) == 1)
    {
        logout(WL_LOG_IMPORTANT, "[SPI PING]CNT:%7u, CRC:%08X/%08X, Error : %2u/%2u", 
            _spi_ping_cnt, 
            _spi_ping_verif_m10.crc_val, _spi_ping_verif_s32.crc_val, 
            _spi_ping_verif_m10.crc_error_total, _spi_ping_verif_s32.crc_error_total);
    }

    _spi_ping_cnt++;
}




void load_boot_rom(unsigned char rom_id)
{
    volatile unsigned short * pRegs_16 = (unsigned short *)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_BASE;
    unsigned char* boot_rom = (unsigned char*)ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;

    logout(WL_LOG_IMPORTANT, "[Boot ROM]START id:%u", rom_id);

    WASCA_PERF_START_MEASURE();
    /* Retrieve ROM file size. */
    wl_spi_bootinfo_t info = { 0 };
    spi_boot_getinfo(rom_id, &info);

    logout(WL_LOG_IMPORTANT, "[Boot ROM]Size=%u KB, status:%u, path:\"%s\"", info.size>>10, info.status, info.path);

    /* Read ROM data. */
    unsigned long rom_size = info.size;
    unsigned long offset = 0;

    int prev_status = -1;
    for(offset=0; offset<rom_size; offset+=WL_SPI_DATA_MAXLEN)
    {
        /* Provide read status to Saturn. */
        int status = (offset * 99);
        status = status / rom_size;
        pRegs_16[PCNTR_REG_OFFSET] = (unsigned short)status;

        unsigned long block_len = WL_SPI_DATA_MAXLEN;
        if((offset + WL_SPI_DATA_MAXLEN) > rom_size)
        {
            block_len = rom_size - offset;
        }

        if((status / 10) != (prev_status / 10))
        {
            logout(WL_LOG_IMPORTANT, "[Boot ROM]Reading from block %5u ...", offset / WL_SPI_DATA_MAXLEN);
            logflush();
        }
        prev_status = status;

        spi_boot_readdata(rom_id, offset, block_len, boot_rom+offset);
    }

    /* Clear unused part of boot ROM area.
     * This is not necessary, but a good way of doing
     * in the case of loading a ROM over a larger one, 
     * or when ROM could not be loaded.
     */
    unsigned long fill_len = 2*1024*1024;
    if(fill_len > rom_size)
    {
        memset(boot_rom + rom_size, 0xFF, fill_len - rom_size);
    }

    /* Mark read status as terminated. */
    pRegs_16[PCNTR_REG_OFFSET] = 99;

    WASCA_PERF_STOP_MEASURE();
    unsigned long elapsed = wasca_perf_get_usec(WASCA_PERF_GET_TIME());

    elapsed = elapsed / 1000;
    if(elapsed == 0)
    {
        elapsed = 1;
    }
    unsigned long kbps = rom_size / elapsed;

    elapsed = elapsed / 100;

#if 0 /* Log CRC value of ROM we just loaded (DEBUG). */
    unsigned long crc32 = crc32_calc(boot_rom, rom_size);

    logout(WL_LOG_IMPORTANT, "[Boot ROM]Read ended. Size:%u KB, Time:%u.%u sec, %u KB/s, CRC=%08X", 
        rom_size>>10, 
        elapsed / 10, elapsed % 10, 
        kbps, 
        crc32);

    // logout(WL_LOG_IMPORTANT, "[Boot ROM]Header: %c%c%c%c%c%c%c%c%c%c%c%c%c%c%c%c", 
    //     boot_rom[ 0], boot_rom[ 1], boot_rom[ 2], boot_rom[ 3], 
    //     boot_rom[ 4], boot_rom[ 5], boot_rom[ 6], boot_rom[ 7], 
    //     boot_rom[ 8], boot_rom[ 9], boot_rom[10], boot_rom[11], 
    //     boot_rom[12], boot_rom[13], boot_rom[14], boot_rom[15]);

#else /* Log transfer speed. */

    logout(WL_LOG_IMPORTANT, "[Boot ROM]Read ended. ID:%u, Size:%u KB, Time:%u.%u sec, %u KB/s", 
        rom_id, 
        rom_size>>10, 
        elapsed / 10, elapsed % 10, 
        kbps);

#endif
}


int main(void)
{
    int i;
    //volatile unsigned char  * pCS0     = (unsigned char  *) ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
    volatile unsigned char  * pCS1     = (unsigned char  *)(ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE + 0x2000000);
    // volatile unsigned short * pCS0_16  = (unsigned short *) ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE;
    volatile unsigned short * pRegs_16 = (unsigned short *) ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_BASE;

    HEARTBEAT_FAST();

    /*--------------------------------------------*/
    /* Initialize settings. */
    memset(&_baseset, 0, sizeof(wl_baseset_max_t));
    _baseset.cart_mode = 0x0341;
    _baseset.log_level = WL_LOG_DEBUGNORMAL;
    _baseset.uart_mode = 2; /* All logs to UART until settings are received from STM32. */

    /* Write version. */
    pRegs_16[SWVER_REG_OFFSET] = SOFTWARE_VERSION;


    /*--------------------------------------------*/
    /* Initialize log internals. */
    log_init();

#if 1
    {
        /* Wait for around 0.3 sec before using SPI.
         * (Just for debug, will be removed soon)
         */
        // WASCA_PERF_START_MEASURE();

        for(int i=0; i<(1500*1000); i++)
        {
            HEARTBEAT_FAST();
        }

        // WASCA_PERF_STOP_MEASURE();
        // unsigned long elapsed = wasca_perf_get_usec(WASCA_PERF_GET_TIME());
        // elapsed = elapsed / 10000;
        // log_to_uart("Startup wait ended. Time:%u.%02u sec", elapsed / 100, elapsed % 100);
    }
#endif

    /*--------------------------------------------*/
    /* Initialize block SPI module internals.     */
    spi_init();


    /*--------------------------------------------*/
    /* Exchange version information with STM32.   */
    wl_verinfo_max_t max_ver_dat = {0};
    wl_verinfo_max_t* max_ver = &max_ver_dat;

    wl_verinfo_stm_t arm_ver_dat = {0};
    wl_verinfo_stm_t* arm_ver = &arm_ver_dat;
    spi_exc_version(max_ver, arm_ver);

    arm_ver->build_date[sizeof(arm_ver->build_date)-1] = '\0';
    arm_ver->build_time[sizeof(arm_ver->build_time)-1] = '\0';

    /* Keep base settings in global variable. */
    memcpy(&_baseset, &arm_ver->set, sizeof(wl_baseset_max_t));

    /* Update SPI clock divider.
     * -> If NIOS freezes and/or boot ROM can't be loaded then it's needed
     *    to set a safer value (example : 16) in ini settings file.
     */
    spi_set_clock_div(_baseset.spi_clock_div);


    /* Initialization ended : blink the LED at slow speed. */
    HEARTBEAT_SLOW();


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

        load_boot_rom(WL_ROM_PSEUDOSAT/*ROM ID*/);

        logout(WL_LOG_IMPORTANT, "ROM load count : %u", load_counter);
        logflush();
    }
#endif // Test continous ROM loading (DEBUG)



#if 0 // Boot ROM manual loading. Not necessary because this is specified from settings in SD card.
    /*--------------------------------------------*/
    /* Load Pseudo Saturn from SD card to SDRAM.  */
    //load_boot_rom(WL_ROM_PSEUDOSAT/*ROM ID*/);
    load_boot_rom(WL_ROM_WASCALOADER/*ROM ID*/); /* Temporarily set to WascaLoader. */
#endif // Boot ROM manual loading. Not necessary because this is specified from settings in SD card.


    /*---------------------------------------*/
    /* Log settings and version information. */
    logout(WL_LOG_IMPORTANT, "MAX10 FW build_date:\"%s\"", max_ver->build_date);
    logout(WL_LOG_IMPORTANT, "      FW build_time:\"%s\"", max_ver->build_time);

    logout(WL_LOG_IMPORTANT, "STM32 FW build_date:\"%s\"", arm_ver->build_date);
    logout(WL_LOG_IMPORTANT, "      FW build_time:\"%s\"", arm_ver->build_time);

    logout(WL_LOG_IMPORTANT, "M10_Set mode[%04X] level[%u] uart[%u] interval[%u] clk_div[%u]", 
        _baseset.cart_mode, 
        _baseset.log_level, 
        _baseset.uart_mode, 
        _baseset.flush_interval, 
        _baseset.spi_clock_div);


    /*----------------------------------------------------------------*/
    /* Poll MODE register and setup Wasca accordingly when it is set. */
    int bram_mode = 0;
    unsigned long loop_counter = 0;

    /* On startup, as cartridge mode from settings file on SD card is used, 
     * it's necessary to tweak the mode register.
     */
    pRegs_16[MODE_REG_OFFSET] = _baseset.cart_mode;
    unsigned short prev_mode_reg = (_baseset.cart_mode == 0 ? 0 : ~_baseset.cart_mode);

    while(1)
    {
        volatile unsigned short current_block;
        unsigned short mode_reg = pRegs_16[MODE_REG_OFFSET];

        if((loop_counter % 50000) == 0)
        {
            if(((loop_counter / 50000) % 2) == 0)
            {
                HEARTBEAT_FAST();
            }
            else
            {
                HEARTBEAT_SLOW();
            }

            log_to_uart("loop[%u] MODE_REG[%04X]", loop_counter / 50000, mode_reg);
        }

        /* Re-init internals in the case MODE register changed. */
        if(mode_reg != prev_mode_reg)
        {
            /* Indicate that initialization is starting. */
            pRegs_16[PCNTR_REG_OFFSET] = 0;

            logout(WL_LOG_IMPORTANT, "Mode set to 0x%04X", mode_reg);

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
            if((mode_reg & 0x0F00) != (prev_mode_reg & 0x0F00))
            {
                logout(WL_LOG_IMPORTANT, "Octet 2, value %x, preparing boot ROM ...", ((mode_reg >> 16) & 0x000F));
                /* Select cartridge ROM :
                 *  - 0    : No ROM
                 *  - 1    : KOF95.bin
                 *  - 2    : Ultraman.bin
                 *  - 3    : Wascaloadr
                 *  - 4    : Pseudo
                 *  - 5    : ROM5.bin
                 *  - 6    : ROM6.bin
                 *  - 7    : ROM7.bin
                 *  - 8-14 : (Reserved)
                 *  - 15   : Firmware internal boot ROM
                 */
                unsigned char rom_id = (unsigned char)((mode_reg & 0x0F00) >> 8);

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

                logout(WL_LOG_IMPORTANT, "Boot ROM read done.");
            }

            if((mode_reg & 0x00F0) != (prev_mode_reg & 0x00F0))
            {
                logout(WL_LOG_IMPORTANT, "Octet 1, value %x -> prepare RAM expansion", ((mode_reg >> 4) & 0x000F));

                // /* RAM expansion cart, clear bootrom's signature just in case. */
                // for(i=0;i<256;i++)
                // {
                //     pCS0[i] = 0;
                // }

                /* And that is all for RAM cart. */
                logout(WL_LOG_IMPORTANT, "RAM expansion setup done.");
            }

            /* Because it's needed to close backup memory access in order to
             * load a boot ROM, it is needed to reload backup memory even if
             * its value is not changed.
             */
            if((mode_reg & 0x000F) != 0)
            {
                logout(WL_LOG_IMPORTANT, "Octet 0, value %x -> preparing backup RAM ...", (mode_reg & 0x000F));

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
                /* Change size from actual data to length of this data mapped on A-Bus. */
                size_kb *= 2;

                /* Initialize SDRAM with backup memory file from SD card. */
                WASCA_PERF_START_MEASURE();

                logout(WL_LOG_IMPORTANT, "Backup RAM size : %u KB", size_kb);
                spi_bup_open(size_kb);
                unsigned long count = size_kb * (1024 / 512);
                int prev_status = -1;
                for(i=0; i<count; i++)
                {
                    int status = 99 * i;
                    status = status / count;
                    pRegs_16[PCNTR_REG_OFFSET] = (unsigned short)status;

                    /* Log reading status from time to time. */
                    if((status / 10) != (prev_status / 10))
                    {
                        logout(WL_LOG_IMPORTANT, "Backup RAM %u %% reading ...", status);
                        logflush();
                    }
                    prev_status = status;

                    spi_bup_read(i/*ID*/, 512/*size*/, (unsigned char*)(pCS1 + (i*512)));
                }


#if 1 /* Log time it took to load backup memory data (DEBUG). */
                WASCA_PERF_STOP_MEASURE();
                unsigned long elapsed = wasca_perf_get_usec(WASCA_PERF_GET_TIME());

                elapsed = elapsed / 1000;
                if(elapsed == 0)
                {
                    elapsed = 1;
                }
                unsigned long kbps = (size_kb * 1024) / elapsed;

                elapsed = elapsed / 100;

                logout(WL_LOG_IMPORTANT, 
                    "[BRAM]Read ended. Size:%u KB, Time:%u.%u sec, %u KB/s", 
                    size_kb, 
                    elapsed / 10, elapsed % 10, 
                    kbps
                );
#endif /* Log time it took to load backup memory data (DEBUG). */

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

                logout(WL_LOG_IMPORTANT, "Backup RAM setup done.");
            }


            /* Mode initialization ended : keep track of mode value
             * in order to detect change after that.
             */
            prev_mode_reg = mode_reg;

            /* Indicate that initialization ended. */
            pRegs_16[PCNTR_REG_OFFSET] = 100;
        }


        /* Backup memory contents synchronization. */
        if(bram_mode)
        {
            /* Sync is done using a 1024 entry deep fifo.
             * When a transaction occurs within a 512-b sector different to current one,
             * the buffer is flused to SD, the new one is loaded from SD, and only then the processing continues.
             * If the fifo is overfilled ( > 1024 samples), issue an error message.
             */
            unsigned short fifo_depth = pRegs_16[SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET];

            if(fifo_depth > 0)
            {
                logout(WL_LOG_IMPORTANT, "SYNC Depth[%u] -> START", fifo_depth);
                char updated_status[16] = {'0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0', '0'};

                /* Check if close to overfill. */
                // if(fifo_depth > 1020)
                // {
                //     //fifo almost overfilled, let's panic!
                //     for(i=0;i<10000;i++)
                //     log_to_uart("FFFFFFFFFFFFFFFFFFFFFFFFFFFFF");
                // }

                do
                {
                    /* Check address from fifo to flush block to file. */
                    current_block = pRegs_16[SNIFF_DATA_REG_OFFSET];
                    unsigned char* pCS1_a = (unsigned char *)(ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE + 0x2000000 + (512*current_block));

                    //logout(WL_LOG_IMPORTANT, "SYNC Depth[%u] Blk[0x%04X] (%02X%02X %02X%02X %02X%02X)", fifo_depth, current_block, pCS1_a[0], pCS1_a[1], pCS1_a[2], pCS1_a[3], pCS1_a[4], pCS1_a[5]);
                    logout(WL_LOG_IMPORTANT, "SYNC Depth[%u] Blk[0x%04X]", fifo_depth, current_block);

                    if(updated_status[current_block & 0xF] != '9')
                    {
                        updated_status[current_block & 0xF]++;
                    }

                    spi_bup_write(current_block/*ID*/, 512/*size*/, pCS1_a);

                    fifo_depth = pRegs_16[SNIFF_FIFO_CONTENT_SIZE_REG_OFFSET];
                } while(fifo_depth > 0);

                //logout(WL_LOG_IMPORTANT, "SYNC Depth[%u] -> DONE", fifo_depth);
                logout(WL_LOG_IMPORTANT, "SYNC Depth[%u] -> DONE [%c%c%c%c %c%c%c%c %c%c%c%c %c%c%c%c]", fifo_depth, 
                    updated_status[ 0], updated_status[ 1], updated_status[ 2], updated_status[ 3], 
                    updated_status[ 4], updated_status[ 5], updated_status[ 6], updated_status[ 7], 
                    updated_status[ 8], updated_status[ 9], updated_status[10], updated_status[11], 
                    updated_status[12], updated_status[13], updated_status[14], updated_status[15]);
            }
        }

        /* Send accumulated log messages to STM32. */
        log_periodic_check();

        loop_counter++;
    }

    /* Never reached. */
    return 0;
}
