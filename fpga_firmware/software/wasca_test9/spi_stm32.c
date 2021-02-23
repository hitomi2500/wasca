#include <string.h>

#include "spi_stm32.h"

#include "crc.h"
#include "log.h"
#include "perf_cntr.h"

/* Version informations, required by spi_exc_version function. */
#include "wasca_defs.h"
#include "m10_ver_infos.h"


/* SPI related log output flag.
 *  - 0 : no logs (normal mode)
 *  - 1 : output logs
 * 
 * Warning : SPI transfer becomes significantly
 *           slower when log output is enabled.
 */
#define SPI_DEBUG_LOGS 0

#if SPI_DEBUG_LOGS == 1
#   define spi_logout(...) log_to_uart(__VA_ARGS__, 0)
#else
#   define spi_logout(...)
#endif


/* Register/memory offsets definitions for block SPI core. */
#define BUFFSPI_BUFFER0_WRITE       0x0000
#define BUFFSPI_BUFFER1_WRITE       0x0800
#define BUFFSPI_BUFFER0_READ        0x1000
#define BUFFSPI_BUFFER1_READ        0x1800
#define BUFFSPI_REG_START           0x2000
#define BUFFSPI_REG_LENGTH          0x2001
#define BUFFSPI_REG_COUNTER         0x2002
#define BUFFSPI_REG_CS_MODE         0x2003
#define BUFFSPI_REG_DELAY           0x2004
#define BUFFSPI_REG_BUFFER_SELECT   0x2005
#define BUFFSPI_REG_SYNC_MISO       0x2006
#define BUFFSPI_REG_SYNC_MOSI       0x2007


/* Maximum word (16 bits) count for each (Tx0, Tx1, Rx0, Rx1) buffers.
 *
 * Memory usage by the core is then :
 *  BUFFSPI_MAXCNT * 4 (buffer count) * 2 (bytes per word)
 *
 * Simple speed bench with several buffer sizes :
 * - Chunk = 512 words -> 100% speed
 * - Chunk = 128 words ->  98% speed
 * - Chunk =  64 words ->  98% speed
 * - Chunk =  32 words ->  97% speed
 * - Chunk =  16 words ->  94% speed
 * - Chunk =   8 words ->  90% speed
 * -> let's use 128 words as maximum transmission size for block SPI core.
 */
//#define BUFFSPI_MAXCNT              512
#define BUFFSPI_MAXCNT              128

/* Internal functions to synchronize around each part of SPI transfer. */
void spi_sync_start(void)
{
    ((volatile unsigned short *)BUFFERED_SPI_0_BASE)[BUFFSPI_REG_SYNC_MOSI] = 0;

    while(((volatile unsigned short *)BUFFERED_SPI_0_BASE)[BUFFSPI_REG_SYNC_MISO] == 1);

    ((volatile unsigned short *)BUFFERED_SPI_0_BASE)[BUFFSPI_REG_SYNC_MOSI] = 1;

    // TODO : add some nops ?
    //for(int i=0; i<(10); i++) {;}
}

void spi_sync_middle(void)
{
    while(((volatile unsigned short *)BUFFERED_SPI_0_BASE)[BUFFSPI_REG_SYNC_MISO] == 0);

    // ((volatile unsigned short *)BUFFERED_SPI_0_BASE)[BUFFSPI_REG_SYNC_MOSI] = 1;

    // TODO : add some nops ?
    //for(int i=0; i<(10); i++) {;}
}


void spi_init(void)
{
    volatile unsigned short * p16_spi = (unsigned short *)BUFFERED_SPI_0_BASE;

    /* Clear block SPI transmit and receive buffers.
     * (Not super necessary, but just in case of)
     */
    int i;
    for(i=0; i<BUFFSPI_MAXCNT; i++)
    {
        p16_spi[BUFFSPI_BUFFER0_WRITE + i] = 0;
        p16_spi[BUFFSPI_BUFFER1_WRITE + i] = 0;
        p16_spi[BUFFSPI_BUFFER0_READ  + i] = 0;
        p16_spi[BUFFSPI_BUFFER1_READ  + i] = 0;
    }

    p16_spi[BUFFSPI_REG_LENGTH       ] =   1; /* Number of words = 16 bit each. */
    p16_spi[BUFFSPI_REG_CS_MODE      ] =   1; /* CS blinking. */
    p16_spi[BUFFSPI_REG_DELAY        ] =  70; /* 70 SPI clocks @ 7.25 Mhz between each 16 bit. */
    p16_spi[BUFFSPI_REG_BUFFER_SELECT] =   0; /* Using buffer 0. */
}



/* Common function for SPI data send and receive.
 * 
 * Both "single" and "dual" functions are available :
 *  - Single : use only Rx0 and Tx0
 *  - Dual   : use only Rx0/Rx1 and Tx0/Tx1 in parallel
 */
void spi_sendreceive_single(unsigned short* snd_ptr, unsigned short* rcv_ptr, unsigned long count)
{
    volatile unsigned short* p16_spi = (unsigned short *)BUFFERED_SPI_0_BASE;

    int pos;
    for(pos=0; pos<count; pos+=BUFFSPI_MAXCNT)
    {
        int len = BUFFSPI_MAXCNT;
        if((pos + BUFFSPI_MAXCNT) > count)
        {
            len = count - pos;
        }

        /* Setting up the core. */
        p16_spi[BUFFSPI_REG_LENGTH       ] = len; /* Number of words = 16 bit each. */
        p16_spi[BUFFSPI_REG_CS_MODE      ] =   1; /* CS blinking. */
        p16_spi[BUFFSPI_REG_DELAY        ] =   1; /* 1 SPI clock @ 7.25 Mhz between each 16 bit. */
        p16_spi[BUFFSPI_REG_BUFFER_SELECT] =   0; /* Using buffer 0. */

        /* Fill transmit buffer with input data. */
        int i;
        if(snd_ptr)
        {
            for(i=0; i<len; i++)
            {
                p16_spi[BUFFSPI_BUFFER0_WRITE + i] = *snd_ptr++;
            }
        }

        /* Fire spi transaction. */
        p16_spi[BUFFSPI_REG_START] = 1; /* Go go go! */


        /* Wait until complete. */
#if 0 // Official way of waiting (with transfer busy flag polling), which doesn't works here.
        while(p16_spi[BUFFSPI_REG_START] != 0);
#else // Alternate waiting with check of the count of words sent so far.
        volatile unsigned long wait_cnt = 0;
        while(1)
        {
            volatile unsigned short c1 = p16_spi[BUFFSPI_REG_COUNTER];
            volatile unsigned short c2 = p16_spi[BUFFSPI_REG_COUNTER];
            wait_cnt++;
            if((c1 >= len) && (c2 >= len))
            {
                break;
            }
        }
        spi_logout("wait_cnt[%07u]", wait_cnt);
#endif

        /* Read the received data. */
        if(rcv_ptr)
        {
#if SPI_DEBUG_LOGS == 1 // Extra log output to verify that everything is received
            for(i=0; i<5; i++)
            {
                spi_logout("B[%04X] C[%04u] D:%04X %04X %04X %04X", 
                    p16_spi[BUFFSPI_REG_START], 
                    p16_spi[BUFFSPI_REG_COUNTER], 
                    p16_spi[BUFFSPI_BUFFER0_READ +   0], 
                    p16_spi[BUFFSPI_BUFFER0_READ +  10], 
                    p16_spi[BUFFSPI_BUFFER0_READ + 100], 
                    p16_spi[BUFFSPI_BUFFER0_READ + len-1]);
            }
#endif // SPI_DEBUG_LOGS == 1

            for(i=0; i<len; i++)
            {
                *rcv_ptr++ = p16_spi[BUFFSPI_BUFFER0_READ + i];
            }
        }
    }
}


void spi_sendreceive_dual(unsigned short* snd_ptr, unsigned short* rcv_ptr, unsigned long count)
{
    volatile unsigned short* p16_spi = (unsigned short *)BUFFERED_SPI_0_BASE;

    /* Setting up core base registers. */
    p16_spi[BUFFSPI_REG_CS_MODE] = 1; /* CS blinking. */
    p16_spi[BUFFSPI_REG_DELAY  ] = 1; /* 1 SPI clock @ 7.25 Mhz between each 16 bit. */

    int next_len = (BUFFSPI_MAXCNT > count ? count : BUFFSPI_MAXCNT);
    int prev_len = 0;
    int spi_buffer = 0;
    volatile unsigned short* p16_wk;

    int i;
    int pos;
    for(pos=0; pos<count; pos+=BUFFSPI_MAXCNT)
    {
        int len = next_len;

        /* Prepare length of next block. */
        next_len = BUFFSPI_MAXCNT;
        if(((pos+len) + BUFFSPI_MAXCNT) > count)
        {
            next_len = count - (pos+len);
        }

        /* Setting up transfer length and buffer ID. */
        p16_spi[BUFFSPI_REG_LENGTH       ] = len; /* Number of words = 16 bit each. */
        p16_spi[BUFFSPI_REG_BUFFER_SELECT] = spi_buffer;

        if((snd_ptr) && (pos == 0))
        {
            /* Fill transmit buffer with first round of input data. */
            p16_wk = p16_spi + (spi_buffer == 0 ? BUFFSPI_BUFFER0_WRITE : BUFFSPI_BUFFER1_WRITE);
            for(i=0; i<len; i++)
            {
                *p16_wk++ = *snd_ptr++;
            }
        }

        /* Fire spi transaction. */
        p16_spi[BUFFSPI_REG_START] = 1; /* Go go go! */

        if((snd_ptr) && (next_len != 0))
        {
            /* Fill transmit buffer with next round of input data
             * while current one is being sent.
             */
            p16_wk = p16_spi + (spi_buffer == 0 ? BUFFSPI_BUFFER1_WRITE : BUFFSPI_BUFFER0_WRITE);
            for(i=0; i<next_len; i++)
            {
                *p16_wk++ = *snd_ptr++;
            }
        }

        if((rcv_ptr) && (prev_len != 0))
        {
            /* Read previous round of output data
             * while current one is being received.
             */
            p16_wk = p16_spi + (spi_buffer == 0 ? BUFFSPI_BUFFER1_READ : BUFFSPI_BUFFER0_READ);
            for(i=0; i<prev_len; i++)
            {
                *rcv_ptr++ = *p16_wk++;
            }
        }


        /* Wait until complete. */
#if 0 // Official way of waiting (with transfer busy flag polling) doesn't works here.
        while(p16_spi[BUFFSPI_REG_START] != 0);
#else // Alternate waiting with check of the count of words sent so far.
        volatile unsigned long wait_cnt = 0;
        while(1)
        {
            volatile unsigned short c1 = p16_spi[BUFFSPI_REG_COUNTER];
            volatile unsigned short c2 = p16_spi[BUFFSPI_REG_COUNTER];
            wait_cnt++;
            if((c1 >= len) && (c2 >= len))
            {
                break;
            }
        }
        spi_logout("wait_cnt[%07u]", wait_cnt);
#endif

        if((rcv_ptr) && (next_len == 0))
        {
            /* Read last round of received data. */
            p16_wk = p16_spi + (spi_buffer == 0 ? BUFFSPI_BUFFER0_READ : BUFFSPI_BUFFER1_READ);
            for(i=0; i<len; i++)
            {
                *rcv_ptr++ = *p16_wk++;
            }
        }

        /* Toggle SPI buffer. */
        spi_buffer = 1-spi_buffer;
        prev_len = len;
    }
}


/* Send specified data over SPI to STM32. */
#define spi_send(_PTR_, _COUNT_) spi_sendreceive_dual(_PTR_, NULL, _COUNT_)

/* Receive specified length of data over SPI from STM32. */
#define spi_receive(_PTR_, _COUNT_) spi_sendreceive_dual(NULL, _PTR_, _COUNT_)


/* Initialize SPI packet. */
void spi_init_packet(wl_spi_pkt_t* pkt)
{
    memset(&pkt->cmn, 0, sizeof(wl_spi_common_hdr_t));
    pkt->cmn.magic_ca = 0xCA;
    pkt->cmn.magic_fe = 0xFE;

    /* Initialize CRC length : it will be set
     * a bit after if integrity check is enabled.
     */
    pkt->params_crc_len = 0;
    pkt->data_crc_len   = 0;
}




void spi_exc_version(wl_verinfo_ext_t* max_ver, wl_spicomm_version_t* arm_ver)
{
    wl_spi_pkt_t pkt_dat;
    wl_spi_pkt_t* pkt = &pkt_dat;

    /* Setup packet header. */
    spi_init_packet(pkt);
    pkt->cmn.command = WL_SPICMD_VERSION;
    pkt->cmn.pkt_len = 0; // TODO
    pkt->cmn.rsp_len = sizeof(wl_spi_pkt_t); // TODO

    {
        /* Send MAX 10 firmware informations to STM32.
         *  -> Base version informations.
         */
        wl_verinfo_ext_t* ver = (wl_verinfo_ext_t*)(pkt->data);
        memset(ver, 0, sizeof(wl_verinfo_ext_t));
        char* build_date = __DATE__;
        char* build_time = __TIME__;

        /* Indicate type of board used : defined in wasca_defs.h . */
        ver->nios.board_type = WL_DEVTYPE_WASCA;

        /* Write Nios build date and time. */
        strcpy(ver->nios.build_date, build_date);
        strcpy(ver->nios.build_time, build_time);

        /* Write Block SPI frequency.
         * It is currently main frequency / 16 = 7.25 MHz.
         */
        ver->nios.stm32_spi_khz = (ALT_CPU_CPU_FREQ / 16) / 1000;

        /* Write OCRAM size. */
        ver->nios.ocram_size = ONCHIP_MEMORY2_0_SPAN;


        /* Send MAX 10 firmware informations to STM32.
         *  -> Extended version informations.
         */
        char* dev_type = MAX10_DEV_TYPE;  // Example : "10M16SAE144C8G"
        char* prj_name = MAX10_PROJ_NAME; // Example : "brd_10m16sa"

        strncpy(ver->dev_type, dev_type, sizeof(ver->dev_type) - 1);
        strncpy(ver->prj_name, prj_name, sizeof(ver->prj_name) - 1);
        ver->pl_date = MAX10_FWDT_VAL;         // Example : 20190828 (decimal, YYYYMMDD format)
        ver->pl_time = MAX10_FWTM_VAL - 10000; // Example : 11944 (decimal, 1HHMM format)

        if(max_ver)
        {
            memcpy(max_ver, ver, sizeof(wl_verinfo_ext_t));
        }
    }

    spi_sync_start();
    spi_send((unsigned short*)pkt, sizeof(wl_spi_pkt_t) / sizeof(unsigned short));
    spi_sync_middle();

    spi_receive((unsigned short*)pkt, pkt->cmn.rsp_len / sizeof(unsigned short));

    /* Don't forget to copy STM32 version informations to output buffer. */
    if(arm_ver)
    {
        memcpy(arm_ver, pkt->data, sizeof(wl_spicomm_version_t));
    }

#if SPI_DEBUG_LOGS == 1
    spi_logout("[SPI] HDR[%02X %02X] PARAMS[%s]"
        , pkt->cmn.magic_ca
        , pkt->cmn.magic_fe
        //, pkt->cmn.pkt_len
        //, pkt->cmn.rsp_len
        , pkt->params);
    int i;
    for(i=0; i<8; i++)
    {
        unsigned char c = ((unsigned char*)pkt)[i];
        spi_logout("[SPI]| Rcv[%3d]:0x%02X (%c)", i, c, c);
    }
#endif // SPI_DEBUG_LOGS == 1
}



void spi_send_logs(wl_spicomm_logs_t* logset, unsigned char* logdata)
{
    wl_spi_pkt_t pkt_dat;
    wl_spi_pkt_t* pkt = &pkt_dat;

    /* Setup packet header. */
    spi_init_packet(pkt);
    pkt->cmn.command = WL_SPICMD_LOGS;
    pkt->cmn.pkt_len = 0; // TODO
    pkt->cmn.rsp_len = sizeof(wl_spi_pkt_t); // TODO

    /* Copy log informations. */
    memcpy(pkt->params, logset, sizeof(wl_spicomm_logs_t));
    memcpy(pkt->data, logdata, logset->block_len);

    spi_sync_start();
    spi_send((unsigned short*)pkt, sizeof(wl_spi_pkt_t) / sizeof(unsigned short));
    spi_sync_middle();

    /* Receive and trash ACK from STM32. */
    spi_receive((unsigned short*)pkt, pkt->cmn.rsp_len / sizeof(unsigned short));
}



/**
 * spi_generic_access
 *
 * Generic STM32-via memory access function.
 * It supports raw memory access and backup memory access.
 *
 * About each parameters :
 *  - pkt      : pointer to buffer for SPI packet
 *  - command  : which command to use. Example memory read, memory write etc
 *  - addr     : start address
 *  - len      : data length
 *  - rsp_len  : response (answer) length, including start header
 *  - snd_data : send data buffer
 *  - rcv_data : receive data buffer
 * 
 * Returns 1 when no error happened, zero else.
**/
int spi_generic_access
(
    unsigned char command, 
    unsigned long addr, unsigned long len, 
    unsigned short rsp_len, 
    unsigned char* snd_data, 
    unsigned char* rcv_data
)
{
rsp_len = sizeof(wl_spi_pkt_t); // TMP

    /* Clamp size to one SPI packet.
     * This should be improved to use as many packets as needed ...
     *
     * Note : this is now clamped on caller side, hence commented-out.
     */
    // if(len > WL_SPI_DATA_LEN)
    // {
    //     len = WL_SPI_DATA_LEN;
    // }

    wl_spi_pkt_t pkt_dat;
    wl_spi_pkt_t* pkt = &pkt_dat;

    /* Setup packet header. */
    spi_init_packet(pkt);
    pkt->cmn.command = command;
    pkt->cmn.pkt_len = 0; // TODO
    pkt->cmn.rsp_len = rsp_len;

    /* Setup memory read parameters. */
    wl_spicomm_memacc_t* params = (wl_spicomm_memacc_t*)pkt->params;
    params->addr = addr;
    params->len  = len;

    if(snd_data)
    {
        memcpy(pkt->data, snd_data, len);
    }

    spi_sync_start();
    spi_send((unsigned short*)pkt, sizeof(wl_spi_pkt_t) / sizeof(unsigned short));
    spi_sync_middle();

    spi_receive((unsigned short*)pkt, pkt->cmn.rsp_len / sizeof(unsigned short));

    /* Don't forget to copy read data to output buffer. */
    if(rcv_data)
    {
        memcpy(rcv_data, pkt->data, len);
    }

#if SPI_DEBUG_LOGS == 1
    spi_logout("[SPI] HDR[%02X %02X] PARAMS[%s] rsp_len[%u]"
        , pkt->cmn.magic_ca
        , pkt->cmn.magic_fe
        //, pkt->cmn.pkt_len
        , pkt->cmn.rsp_len
        , pkt->params);
    int i;
    for(i=0; i<8; i++)
    {
        unsigned char c = ((unsigned char*)pkt)[i];
        spi_logout("[SPI]| Rcv[%3d]:0x%02X (%c)", i, c, c);
    }
#endif // SPI_DEBUG_LOGS == 1

    /* On STM32 side, error is always specified by zero-ing the
     * data length parameter, and vice-versa
     * So simply check this parameter to know if an error happened or not.
     */
    return (params->len == 0 ? 0 : 1);
}



/* The functions to do raw memory read/write. */
int spi_mem_read(unsigned long addr, unsigned long len, unsigned char* data)
{
    spi_generic_access(WL_SPICMD_MEMREAD, addr, len, WL_SPI_CUSTOM_RSPLEN(WL_SPI_DATA_LEN)/*rsp_len*/, NULL/*snd_data*/, data/*rcv_data*/);

    return 1;
}
int spi_mem_write(unsigned long addr, unsigned long len, unsigned char* data)
{
    spi_generic_access(WL_SPICMD_MEMWRITE, addr, len, WL_SPI_CUSTOM_RSPLEN(0)/*rsp_len*/, data/*snd_data*/, NULL/*rcv_data*/);

    return 1;
}

/* The functions to do backup memory read/write/etc. */
int spi_bup_open(unsigned long len_kb)
{
    return spi_generic_access(WL_SPICMD_BUPOPEN, 0/*block*/, len_kb, WL_SPI_PARAMS_RSPLEN/*rsp_len*/, NULL, NULL);
}
int spi_bup_read(unsigned long block, unsigned long len, unsigned char* data)
{
    return spi_generic_access(WL_SPICMD_BUPREAD, block, len, WL_SPI_FULL_RSPLEN/*rsp_len*/, NULL/*snd_data*/, data/*rcv_data*/);
}
int spi_bup_write(unsigned long block, unsigned long len, unsigned char* data)
{
    return spi_generic_access(WL_SPICMD_BUPWRITE, block, len, WL_SPI_PARAMS_RSPLEN/*rsp_len*/, data/*snd_data*/, NULL/*rcv_data*/);
}
int spi_bup_close(void)
{
    return spi_generic_access(WL_SPICMD_BUPCLOSE, 0/*block*/, 0/*len*/, WL_SPI_PARAMS_RSPLEN/*rsp_len*/, NULL, NULL);
}


/* Boot ROM access : retrieve informations. */
void spi_boot_getinfo(unsigned char rom_id, wl_spicomm_bootinfo_t* info, char* full_path)
{
    wl_spi_pkt_t pkt_dat;
    wl_spi_pkt_t* pkt = &pkt_dat;

    /* Setup packet header. */
    spi_init_packet(pkt);
    pkt->cmn.command = WL_SPICMD_BOOTINFO;
    pkt->cmn.pkt_len = 0; // TODO
    pkt->cmn.rsp_len = sizeof(wl_spi_pkt_t);

    /* Specify ROM ID. */
    wl_spicomm_memacc_t* params = (wl_spicomm_memacc_t*)pkt->params;
    params->rom_id = rom_id;

    spi_sync_start();
    spi_send((unsigned short*)pkt, sizeof(wl_spi_pkt_t) / sizeof(unsigned short));
    spi_sync_middle();

    spi_receive((unsigned short*)pkt, pkt->cmn.rsp_len / sizeof(unsigned short));

    /* Copy received data to output parameters. */
    memcpy(info, pkt->params, sizeof(wl_spicomm_bootinfo_t));

    if(full_path)
    {
        memcpy(full_path, pkt->data, WL_MAX_PATH);
        full_path[WL_MAX_PATH - 1] = '\0';
    }
}


/* Boot ROM access : read data. */
int spi_boot_readdata(unsigned char rom_id, unsigned long offset, unsigned long len, unsigned char* dst)
{
    wl_spi_pkt_t pkt_dat;
    wl_spi_pkt_t* pkt = &pkt_dat;

    /* Retry reception until data matches with CRC. */
    for(int i=0; i<10; i++)
    {
        /* Setup packet header. */
        spi_init_packet(pkt);
        pkt->cmn.command = WL_SPICMD_BOOTREAD;
        pkt->cmn.pkt_len = 0; // TODO
        pkt->cmn.rsp_len = sizeof(wl_spi_pkt_t);

        /* Setup read parameters. */
        wl_spicomm_memacc_t* params = (wl_spicomm_memacc_t*)pkt->params;
        params->rom_id = rom_id;
        params->addr   = offset;
        params->len    = len;

        spi_sync_start();
        spi_send((unsigned short*)pkt, sizeof(wl_spi_pkt_t) / sizeof(unsigned short));
        spi_sync_middle();

        spi_receive((unsigned short*)pkt, pkt->cmn.rsp_len / sizeof(unsigned short));

        /* Verify CRC. */
        int valid_crc = 1;
        if(pkt->data_crc_len != 0)
        {
            if(pkt->data_crc_len > WL_SPI_DATA_LEN)
            {
                valid_crc = 0;
            }
            else
            {
                unsigned long crc = crc32_calc(pkt->data, pkt->data_crc_len);

                if(crc != pkt->data_crc_val)
                {
                    valid_crc = 0;
                }
            }
        }

        if(!valid_crc)
        {
            log_to_uart("ERROR: invalid CRC at offset %08X", offset);
        }
        else
        {
            break;
        }
    }

    /* Copy back read data to destination buffer. */
    wl_spicomm_bootinfo_t* info = (wl_spicomm_bootinfo_t*)pkt->params;
    if(info->block_len != 0)
    {
        memcpy(dst, pkt->data, info->block_len);
    }

    return (info->status == WL_BOOTROM_END ? 1 : 0);
}


