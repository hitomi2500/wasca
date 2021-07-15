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
    //for(int i=0; i<200; i++) {;}
}

void spi_sync_middle(void)
{
    while(((volatile unsigned short *)BUFFERED_SPI_0_BASE)[BUFFSPI_REG_SYNC_MISO] == 0);

    // ((volatile unsigned short *)BUFFERED_SPI_0_BASE)[BUFFSPI_REG_SYNC_MOSI] = 1;

    // TODO : add some nops ?
    //for(int i=0; i<200; i++) {;}
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



/* Wrapper to send and receive function with STM32. */
#define spi_sendreceive(_SND_PTR_, _RCV_PTR_, _COUNT_) spi_sendreceive_dual(_SND_PTR_, _RCV_PTR_, _COUNT_)

/* Send specified data over SPI to STM32. */
#define spi_send(_PTR_, _COUNT_) spi_sendreceive_dual(_PTR_, NULL, _COUNT_)

/* Receive specified length of data over SPI from STM32. */
#define spi_receive(_PTR_, _COUNT_) spi_sendreceive_dual(NULL, _PTR_, _COUNT_)


/* Initialize SPI header. */
void spi_init_header(wl_spi_header_t* hdr, unsigned char command, unsigned short data_len)
{
    memset(hdr, 0, sizeof(wl_spi_header_t));
    hdr->magic_ca = 0xCA;
    hdr->magic_fe = 0xFE;
    hdr->command  = command;
    hdr->data_len = data_len;
}

/* Cheap debug function to log raw data contents. */
#if 0
void spi_raw_log(char* str, unsigned char* ptr, unsigned short len)
{
#define SPI_RAW_LOG_LINELEN 8

    for (int j = 0; j < (len / SPI_RAW_LOG_LINELEN); j++)
    {
        char tmp_h[(3*SPI_RAW_LOG_LINELEN) + 1] = { '\0' };
        char tmp_a[SPI_RAW_LOG_LINELEN + 1] = { '\0' };

        for (int i = 0; i < SPI_RAW_LOG_LINELEN; i++)
        {
            unsigned char c = ptr[(j*SPI_RAW_LOG_LINELEN) + i];

#define NIBBLE_TO_CHAR(_N_) ((_N_) <= 9 ? '0' + (_N_) : ('A' - 10) + (_N_))
            unsigned char nw = c >> 4;
            tmp_h[(3*i) + 0] = NIBBLE_TO_CHAR(nw);
            nw = c & 0x0F;
            tmp_h[(3*i) + 1] = NIBBLE_TO_CHAR(nw);
            tmp_h[(3*i) + 2] = ' ';

            /* Display differently null and FF characters.
             * It helps to spot them in screen full of hexa codes.
             */
            if(c == 0x00)
            {
                c = '~';
            }
            else if(c == 0xFF)
            {
                c = 'X';
            }
            else if(c < ' ')
            {
                c = '.';
            }
            else if(c > 127)
            {
                c = '?';
            }

            tmp_a[i] = c;
        }

        log_to_uart("%s_%02X: %s %s", str, j*SPI_RAW_LOG_LINELEN, tmp_h, tmp_a);
    }
}
#else
#   define spi_raw_log(_STR_, _PTR_, _LEN_)
#endif



void spi_exc_version(wl_verinfo_max_t* max_ver, wl_verinfo_stm_t* arm_ver)
{
    wl_spi_header_t hdr_dat;
    wl_spi_header_t* hdr = &hdr_dat;

    /* Setup packet header. */
    spi_init_header(hdr, WL_SPICMD_VERSION, WL_SPIDATALEN_VERSION/*data_len*/);

    spi_sync_start();
    spi_send((unsigned short*)hdr, sizeof(wl_spi_header_t) / sizeof(unsigned short));
    spi_sync_middle();


    /* Prepare MAX 10 firmware that will be sent to STM32. */
    wl_verinfo_max_t max_ver_buff = {0};

    /* Indicate which MAX 10 device is used. */
    char* dev_type = MAX10_DEV_TYPE;  // Example : "10M16SAE144C8G"
    strncpy(max_ver_buff.dev_type, dev_type, sizeof(max_ver_buff.dev_type) - 1);

    /* Indicate PL build date and time. */
    max_ver_buff.pl_date = MAX10_FWDT_VAL;         // Example : 20190828 (decimal, YYYYMMDD format)
    max_ver_buff.pl_time = MAX10_FWTM_VAL - 10000; // Example : 11944 (decimal, 1HHMM format)

    /* Write Nios build date and time. */
    char* build_date = __DATE__;
    char* build_time = __TIME__;
    strcpy(max_ver_buff.build_date, build_date);
    strcpy(max_ver_buff.build_time, build_time);

    /* Write OCRAM size. */
    max_ver_buff.ocram_size = ONCHIP_MEMORY2_0_SPAN;

    if(max_ver)
    {
        memcpy(max_ver, &max_ver_buff, sizeof(wl_verinfo_max_t));
    }

    /* Receive STM32 firmware information.
     * Note : both version information are exchanged simultaneously.
     */
    spi_sendreceive((unsigned short*)&max_ver_buff, (unsigned short*)arm_ver, sizeof(wl_verinfo_stm_t) / sizeof(unsigned short));


    /* Raw log of data sent and received to/from STM32. */
    spi_raw_log("VerH", (unsigned char*)hdr, sizeof(wl_spi_header_t));
    spi_raw_log("VerS", (unsigned char*)&max_ver_buff, 32);
    spi_raw_log("VerR", (unsigned char*)arm_ver, 32);

#if SPI_DEBUG_LOGS == 1
    spi_logout("[SPI] HDR[%02X %02X]"
        , hdr->magic_ca
        , hdr->magic_fe);
    int i;
    for(i=0; i<8; i++)
    {
        unsigned char c = ((unsigned char*)hdr)[i];
        spi_logout("[SPI]| Rcv[%3d]:0x%02X (%c)", i, c, c);
    }
#endif // SPI_DEBUG_LOGS == 1
}



void spi_send_logs(unsigned char* logdata, unsigned short datalen)
{
    wl_spi_header_t hdr_dat;
    wl_spi_header_t* hdr = &hdr_dat;

    /* Small tweak to properly handle the case of odd data length.
     * In that case, a dummy null character is sent at the end of the message.
     */
    if(datalen % sizeof(unsigned short))
    {
        logdata[datalen++] = '\0';
    }

    /* Setup packet header. */
    spi_init_header(hdr, WL_SPICMD_LOGS, datalen/*data_len*/);

    spi_sync_start();
    spi_send((unsigned short*)hdr, sizeof(wl_spi_header_t) / sizeof(unsigned short));
    spi_sync_middle();

    /* Send log data. */
    spi_send((unsigned short*)logdata, datalen / sizeof(unsigned short));
}



/**
 * spi_generic_access
 *
 * Generic STM32-via memory access function.
 * It supports raw memory access and backup memory access.
 *
 * About each parameters :
 *  - command  : which command to use. Example memory read, memory write etc
 *  - addr     : start address
 *  - len      : data length
 *  - data_len : length of data sent after header, in byte unit
 *  - snd_data : send data buffer
 *  - rcv_data : receive data buffer
 * 
 * Returns 1 when no error happened, zero else.
**/
int spi_generic_access
(
    unsigned char command, 
    unsigned long addr, unsigned long len, 
    unsigned short data_len, 
    unsigned char* snd_data, 
    unsigned char* rcv_data
)
{
    wl_spi_header_t hdr_dat;
    wl_spi_header_t* hdr = &hdr_dat;

    /* Setup packet header. */
    spi_init_header(hdr, command, data_len);

    /* Setup memory read parameters. */
    wl_spi_memacc_t* params = (wl_spi_memacc_t*)hdr->params;
    params->addr = addr;
    params->len  = len;

    spi_sync_start();
    spi_send((unsigned short*)hdr, sizeof(wl_spi_header_t) / sizeof(unsigned short));
    spi_sync_middle();

    /* Transfer data with STM32 when it is ready. */
    if(data_len != 0)
    {
        spi_sendreceive((unsigned short*)snd_data, (unsigned short*)rcv_data, data_len / sizeof(unsigned short));
    }

#if SPI_DEBUG_LOGS == 1
    spi_logout("[SPI] HDR[%02X %02X] data_len[%u]"
        , hdr->magic_ca
        , hdr->magic_fe
        , hdr->data_len);
    int i;
    for(i=0; i<8; i++)
    {
        unsigned char c = ((unsigned char*)hdr)[i];
        spi_logout("[SPI]| Rcv[%3d]:0x%02X (%c)", i, c, c);
    }
#endif // SPI_DEBUG_LOGS == 1

    /* On STM32 side, error is always specified by zero-ing the
     * data length parameter, and vice-versa
     * So simply check this parameter to know if an error happened or not.
     */
    return (params->len == 0 ? 0 : 1);
}



/* The functions to do backup memory read/write/etc. */
int spi_bup_open(unsigned short len_kb)
{
    return spi_generic_access(WL_SPICMD_BUPOPEN, 0/*block*/, len_kb, sizeof(wl_spi_memacc_t)/*data_len*/, NULL, NULL);
}
int spi_bup_read(unsigned short block, unsigned short len, unsigned char* data)
{
    return spi_generic_access(WL_SPICMD_BUPREAD, block, len, len/*data_len*/, NULL/*snd_data*/, data/*rcv_data*/);
}
int spi_bup_write(unsigned short block, unsigned short len, unsigned char* data)
{
    return spi_generic_access(WL_SPICMD_BUPWRITE, block, len, len/*data_len*/, data/*snd_data*/, NULL/*rcv_data*/);
}
int spi_bup_close(void)
{
    return spi_generic_access(WL_SPICMD_BUPCLOSE, 0/*block*/, 0/*len*/, sizeof(wl_spi_memacc_t)/*data_len*/, NULL, NULL);
}


/* Boot ROM access : retrieve informations. */
void spi_boot_getinfo(unsigned char rom_id, wl_spi_bootinfo_t* info)
{
    wl_spi_header_t hdr_dat;
    wl_spi_header_t* hdr = &hdr_dat;

    /* Setup packet header. */
    spi_init_header(hdr, WL_SPICMD_BOOTINFO, sizeof(wl_spi_bootinfo_t)/*data_len*/);

    /* Specify ROM ID. */
    wl_spi_memacc_t* params = (wl_spi_memacc_t*)hdr->params;
    params->rom_id = rom_id;

    spi_sync_start();
    spi_send((unsigned short*)hdr, sizeof(wl_spi_header_t) / sizeof(unsigned short));
    spi_sync_middle();

    spi_receive((unsigned short*)info, sizeof(wl_spi_bootinfo_t) / sizeof(unsigned short));

    /* Raw log of data sent and received to/from STM32. */
    spi_raw_log("BtiH", (unsigned char*)hdr, sizeof(wl_spi_header_t));
    spi_raw_log("BtiR", (unsigned char*)info, 32);

    /* Sanitize path to boot ROM file. */
    info->path[WL_MAX_PATH - 1] = '\0';
}


/* Boot ROM access : read data. */
void spi_boot_readdata(unsigned char rom_id, unsigned long offset, unsigned long len, unsigned char* dst)
{
    wl_spi_header_t hdr_dat;
    wl_spi_header_t* hdr = &hdr_dat;

    /* Setup packet header. */
    spi_init_header(hdr, WL_SPICMD_BOOTREAD, len/*data_len*/);

    /* Setup read parameters. */
    wl_spi_memacc_t* params = (wl_spi_memacc_t*)hdr->params;
    params->rom_id = rom_id;
    params->addr   = offset;
    params->len    = len;

    spi_sync_start();
    spi_send((unsigned short*)hdr, sizeof(wl_spi_header_t) / sizeof(unsigned short));
    spi_sync_middle();

    spi_receive((unsigned short*)dst, len / sizeof(unsigned short));
}


/* SPI ping command.
 *
 * Transfer outline :
 *  1. Send header from MAX 10
 *     | M->S : wl_spi_header_t
 *     |        | (wl_spi_ping_params_t*)params[]
 *     |        | | -> contains CRC test length, test pattern settings etc
 *     | S->M : nothing special
 *  2. Send ping parameters and test data from both MAX 10 and STM32 sides
 *     | M->S : wl_spi_ping_verif_t + data (variable size, indicated in step 1)
 *     | S->M : wl_spi_ping_verif_t + data (variable size, indicated in step 1)
 */
#include <stdlib.h> /* For rand functions. */
unsigned long _spi_ping_prev_seed = 0x12345678;
void spi_ping_test(wl_spi_ping_params_t* params, wl_spi_ping_verif_t* ping_verif_m10, wl_spi_ping_verif_t* ping_verif_s32, unsigned char* txrx_buffer)
{
    wl_spi_header_t hdr_dat;
    wl_spi_header_t* hdr = &hdr_dat;

    /* Data length integrity check. */
    if(params->data_len > (WL_SPI_DATA_MAXLEN - sizeof(wl_spi_ping_verif_t)))
    {
        params->data_len = WL_SPI_DATA_MAXLEN - sizeof(wl_spi_ping_verif_t);
    }
    if(params->crc_len > params->data_len)
    {
        params->crc_len = params->data_len;
    }

    /* Prepare test data. */
    unsigned char pattern = params->pattern;
    wl_spi_ping_verif_t* verif_m10 = (wl_spi_ping_verif_t*)txrx_buffer;
    unsigned char* data_m10 = txrx_buffer + sizeof(wl_spi_ping_verif_t);

    wl_spi_ping_verif_t* verif_s32 = (wl_spi_ping_verif_t*)(txrx_buffer+WL_SPI_DATA_MAXLEN);
    unsigned char* data_s32 = (txrx_buffer+WL_SPI_DATA_MAXLEN) + sizeof(wl_spi_ping_verif_t);

    memcpy(verif_m10, ping_verif_m10, sizeof(wl_spi_ping_verif_t));

    if(pattern != WL_SPI_PING_NOTSET)
    {
        int i;
        unsigned char c;

        if(params->pattern_seed != _spi_ping_prev_seed)
        {
            srand(params->pattern_seed);
            _spi_ping_prev_seed = params->pattern_seed;
        }
        c = (unsigned char)rand();

        for(i=0; i<params->data_len; i++)
        {
            if(pattern == WL_SPI_PING_RANDOM)
            {
                c = (unsigned char)rand();
            }
            else if(pattern == WL_SPI_PING_CONSTANT)
            {
                /* Don't change constant value. */
            }
            else //if(pattern == WL_SPI_PING_INCREMENT)
            {
                c++;
            }

            data_m10[i] = c;
        }
    }

    /* Compute CRC of test data about to send.
     * Note : the case crc_len equal to zero doesn't harms.
     */
    verif_m10->crc_val = crc32_calc(data_m10, params->crc_len);

    /* Setup packet header. */
    spi_init_header(hdr, WL_SPICMD_PING, sizeof(wl_spi_ping_verif_t) + params->data_len);

    /* Setup ping parameters. */
    memcpy(hdr->params, params, sizeof(wl_spi_ping_params_t));

    spi_sync_start();
    spi_send((unsigned short*)hdr, sizeof(wl_spi_header_t) / sizeof(unsigned short));
    spi_sync_middle();

    /* Exchange ping results from previous time and current test data. */
    spi_sendreceive((unsigned short*)verif_m10, (unsigned short*)verif_s32, (sizeof(wl_spi_ping_verif_t) + params->data_len) / sizeof(unsigned short));

    /* Verify CRC of test data received from STM32.
     * (Even in the case crc_len equal to zero, CRC value must be set)
     * 
     * Note : because STM32 have to send packet before checking the one received
     *        from MAX 10, CRC test result from previous request is received.
     */

    // log_to_uart("@@ M10[%02X %02X %02X %02X .. %02X] S32[%02X %02X %02X %02X .. %02X]", 
    //     data_m10[0], data_m10[1], data_m10[2], data_m10[3], data_m10[params->data_len-1], 
    //     data_s32[0], data_s32[1], data_s32[2], data_s32[3], data_s32[params->data_len-1]);


    unsigned long crc = crc32_calc(data_s32, params->crc_len);
    if(crc != verif_s32->crc_val)
    {
        log_to_uart("  ## Error STM32 CRC[%08X] is not %08X", crc, verif_s32->crc_val);
    }
    verif_m10->prev_crc_fail = (crc != verif_s32->crc_val ? 1 : 0);
    if(verif_m10->crc_error_total < 0xFFFF)
    {
        verif_m10->crc_error_total += verif_m10->prev_crc_fail;
    }
    if(verif_m10->count_total < 0xFFFFFFFF)
    {
        verif_m10->count_total++;
    }

    memcpy(ping_verif_m10, verif_m10, sizeof(wl_spi_ping_verif_t));
    memcpy(ping_verif_s32, verif_s32, sizeof(wl_spi_ping_verif_t));
}

