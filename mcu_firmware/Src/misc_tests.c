#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "main.h"
#include "log.h"
#include "stm32f4xx_hal.h"

#include "satcom_lib/wasca_link.h"

#include "misc_tests.h"

#include "fatfs.h"
#include "bup_bootrom.h"




/*
 * ------------------------------------------
 * - SD card access test --------------------
 * ------------------------------------------
 */
#if SDCARD_ACCESS_TEST_ENABLE == 1

FIL MyFile;     /* File object */
const char wtext[] = "Hello World!";
unsigned char _sdcard_read_test[32*1024];

void sdcard_access_test(void)
{
  FRESULT res;               /* FatFs function common result code */
  uint32_t byteswritten, bytesread; /* File write/read counts */
  char rtext[256];                /* File read buffer */

/*##-0- Turn all LEDs off(red, green, orange and blue) */
//    HAL_GPIO_WritePin(GPIOG, (GPIO_PIN_10 | GPIO_PIN_6 | GPIO_PIN_7 | GPIO_PIN_12), GPIO_PIN_SET);

    /*##-3- Create a FAT file system (format) on the logical drive#*/
        /* WARNING: Formatting the uSD card will delete all content on the
    device */
    //  if(f_mkfs((TCHAR const*)SDPath, 0, 0) != FR_OK){
    //    /* FatFs Format Error : set the red LED on */
    //    //HAL_GPIO_WritePin(GPIOG, GPIO_PIN_10, GPIO_PIN_RESET);
    //    while(1);
    //  }
    //  else
    {


#if 1
        if(f_open(&MyFile, "/sonicr.iso", FA_READ) != FR_OK)
        {
            /* 'Hello.txt' file Open for read Error : set the red LED on */
            //HAL_GPIO_WritePin(GPIOG, GPIO_PIN_10, GPIO_PIN_RESET);
            termout(WL_LOG_DEBUGNORMAL, "'sonicr.iso' file Open for read Error !");
            //while(1);
        }
        else
        {
            //res = f_read(&MyFile, rtext, sizeof(wtext), (UINT*)&bytesread);

            unsigned char ip_header[128] = { 0 };
#define READ_TEST_CNT (256)
            unsigned long sdcard_read_stt = HAL_GetTick();
            for(int ite=0; ite<READ_TEST_CNT; ite++)
            {
                //f_lseek(&MyFile, 14102528/8);
                res = f_read(&MyFile, _sdcard_read_test, sizeof(_sdcard_read_test), (UINT*)&bytesread);

                if(ite == 0)
                {
                    memcpy(ip_header, _sdcard_read_test, sizeof(ip_header));
                }
            }
            unsigned long sdcard_read_end = HAL_GetTick();

            if(res != FR_OK)
            {
                /* 'Hello.txt' file Read or EOF Error : set the red LED on */
                //HAL_GPIO_WritePin(GPIOG, GPIO_PIN_10, GPIO_PIN_RESET);
                termout(WL_LOG_DEBUGNORMAL, "'sonicr.iso' file Read Error !");
                //while(1);
            }
            else
            {
                termout(WL_LOG_DEBUGNORMAL, "'sonicr.iso' file Read success !");

                unsigned long sdcard_read_diff = sdcard_read_end - sdcard_read_stt;
                unsigned long sdcard_read_speed = (((READ_TEST_CNT*sizeof(_sdcard_read_test)) / 1024) * 1000) / sdcard_read_diff;
                termout(WL_LOG_DEBUGNORMAL, "%u KB read in %u msec. speed = %u KB/s", READ_TEST_CNT*sizeof(_sdcard_read_test) >> 10, sdcard_read_diff, sdcard_read_speed);

#define CHAR_PER_LINE 16
                for (int j = 0; j < (sizeof(ip_header) / CHAR_PER_LINE); j++)
                {
                    char tmp[CHAR_PER_LINE + 1] = { '\0' };

                    for (int i = 0; i < CHAR_PER_LINE; i++)
                    {
unsigned char char2pchar(unsigned char c);
                        tmp[i] = char2pchar(ip_header[(j*CHAR_PER_LINE) + i]);
                    }

                    termout(WL_LOG_DEBUGNORMAL, "%03X: %s", j*CHAR_PER_LINE, tmp);
                }
#undef CHAR_PER_LINE


            }
        }
        //while(1){}
#endif // 0



/*##-4- Create & Open a new text file object with write access#*/
        termout(WL_LOG_DEBUGNORMAL, "'Hello.txt' file Open STT ...");
        int fopen_ret = f_open(&MyFile, "Hello.txt", FA_CREATE_ALWAYS | FA_WRITE);
        if(fopen_ret != FR_OK)
        {
            /* 'Hello.txt' file Open for write Error : set the red LED on */
            //HAL_GPIO_WritePin(GPIOG, GPIO_PIN_10, GPIO_PIN_RESET);
            termout(WL_LOG_DEBUGNORMAL, "'Hello.txt' file Open for write Error ! ret:%d", fopen_ret);


            // typedef enum {
            // 	FR_OK = 0,				/* (0) Succeeded */
            // 	FR_DISK_ERR,			/* (1) A hard error occurred in the low level disk I/O layer */
            // 	FR_INT_ERR,				/* (2) Assertion failed */
            // 	FR_NOT_READY,			/* (3) The physical drive cannot work */
            // 	FR_NO_FILE,				/* (4) Could not find the file */
            // 	FR_NO_PATH,				/* (5) Could not find the path */
            // 	FR_INVALID_NAME,		/* (6) The path name format is invalid */
            // 	FR_DENIED,				/* (7) Access denied due to prohibited access or directory full */
            // 	FR_EXIST,				/* (8) Access denied due to prohibited access */
            // 	FR_INVALID_OBJECT,		/* (9) The file/directory object is invalid */
            // 	FR_WRITE_PROTECTED,		/* (10) The physical drive is write protected */
            // 	FR_INVALID_DRIVE,		/* (11) The logical drive number is invalid */
            // 	FR_NOT_ENABLED,			/* (12) The volume has no work area */
            // 	FR_NO_FILESYSTEM,		/* (13) There is no valid FAT volume */
            // 	FR_MKFS_ABORTED,		/* (14) The f_mkfs() aborted due to any problem */
            // 	FR_TIMEOUT,				/* (15) Could not get a grant to access the volume within defined period */
            // 	FR_LOCKED,				/* (16) The operation is rejected according to the file sharing policy */
            // 	FR_NOT_ENOUGH_CORE,		/* (17) LFN working buffer could not be allocated */
            // 	FR_TOO_MANY_OPEN_FILES,	/* (18) Number of open files > _FS_LOCK */
            // 	FR_INVALID_PARAMETER	/* (19) Given parameter is invalid */
            // } FRESULT;






                //while(1);
        }
        else
        {
            /*##-5- Write data to the text file ####################*/
            res = f_write(&MyFile, wtext, sizeof(wtext), (void*)&byteswritten);
            if((byteswritten == 0) || (res != FR_OK))
            {
                /* 'Hello.txt' file Write or EOF Error : set the red LED on */
                //HAL_GPIO_WritePin(GPIOG, GPIO_PIN_10, GPIO_PIN_RESET);
                termout(WL_LOG_DEBUGNORMAL, "'Hello.txt' file Write or EOF Error !");
                //while(1);
            }
            else
            {
                /*##-6- Successful open/write : set the blue LED on */
                //HAL_GPIO_WritePin(GPIOG, GPIO_PIN_12, GPIO_PIN_RESET);
                f_close(&MyFile);
                /*##-7- Open the text file object with read access #*/
                if(f_open(&MyFile, "Hello.txt", FA_READ) != FR_OK)
                {
                    /* 'Hello.txt' file Open for read Error : set the red LED on */
                    //HAL_GPIO_WritePin(GPIOG, GPIO_PIN_10, GPIO_PIN_RESET);
                    termout(WL_LOG_DEBUGNORMAL, "'Hello.txt' file Open for read Error !");
                    //while(1);
                }
                else
                {
                    /*##-8- Read data from the text file #########*/
                    res = f_read(&MyFile, rtext, sizeof(wtext), (UINT*)&bytesread);

                    if((strcmp(rtext, wtext) != 0) || (res != FR_OK))
                    {
                        /* 'Hello.txt' file Read or EOF Error : set the red LED on */
                        //HAL_GPIO_WritePin(GPIOG, GPIO_PIN_10, GPIO_PIN_RESET);
                        termout(WL_LOG_DEBUGNORMAL, "'Hello.txt' file Read or EOF Error !");
                        //while(1);
                    }
                    else
                    {
                        /* Successful read : set the green LED On */
                        //HAL_GPIO_WritePin(GPIOG, GPIO_PIN_6, GPIO_PIN_RESET);
                        termout(WL_LOG_DEBUGNORMAL, "Successful read :]");
                        /*##-9- Close the open text file ################*/
                        f_close(&MyFile);
                    }
                }
            }
        }
    }
    /*##-10- Unlink the micro SD disk I/O driver #########*/

    BSP_SD_CardInfo CardInfo;
    BSP_SD_GetCardInfo(&CardInfo);
    termout(WL_LOG_DEBUGNORMAL, "CardType     : %u", CardInfo.CardType);
    termout(WL_LOG_DEBUGNORMAL, "CardVersion  : %u", CardInfo.CardVersion);
    termout(WL_LOG_DEBUGNORMAL, "Class        : %u", CardInfo.Class);
    termout(WL_LOG_DEBUGNORMAL, "RelCardAdd   : %u", CardInfo.RelCardAdd);
    termout(WL_LOG_DEBUGNORMAL, "BlockNbr     : %u", CardInfo.BlockNbr);
    termout(WL_LOG_DEBUGNORMAL, "BlockSize    : %u", CardInfo.BlockSize);
    termout(WL_LOG_DEBUGNORMAL, "LogBlockNbr  : %u", CardInfo.LogBlockNbr);
    termout(WL_LOG_DEBUGNORMAL, "LogBlockSize : %u", CardInfo.LogBlockSize);
}
#endif // SDCARD_ACCESS_TEST_ENABLE == 1



/*
 * ------------------------------------------
 * - BUP file test bench --------------------
 * ------------------------------------------
 */
#if BUP_TEST_BENCH_ENABLE == 1

wl_spi_pkt_t _bup_testbench_in  = { 0 };
wl_spi_pkt_t _bup_testbench_out = { 0 };

void bup_test_bench(void)
{
    wl_spi_pkt_t* pkt_in  = &_bup_testbench_in ;
    wl_spi_pkt_t* pkt_out = &_bup_testbench_out;
    wl_spicomm_memacc_t* params_in  = (wl_spicomm_memacc_t*)pkt_in ->params;
    wl_spicomm_memacc_t* params_out = (wl_spicomm_memacc_t*)pkt_out->params;

    /* ------------------------------------------ */
    /* Open a backup file. */
    memset(pkt_in , 0, sizeof(wl_spi_pkt_t));
    memset(pkt_out, 0, sizeof(wl_spi_pkt_t));
    pkt_in->cmn.command = WL_SPICMD_BUPOPEN;
    params_in->len = 1024; // 1MB

    bup_file_process(pkt_in, pkt_out);

    termout(WL_LOG_DEBUGNORMAL, "[bup_test_bench::OPEN]len:%u -> %s", params_out->len, (params_out->len == 0 ? "NG" : "OK"));

    /* ------------------------------------------ */
    /* Write one block of backup data. */
    unsigned char dummy_block[512];
    unsigned long block_id = 0; // First block
    for(int i=0; i<sizeof(dummy_block); i++)
    {
        dummy_block[i] = (unsigned char)(i*i);
    }

    memset(pkt_in , 0, sizeof(wl_spi_pkt_t));
    memset(pkt_out, 0, sizeof(wl_spi_pkt_t));
    pkt_in->cmn.command = WL_SPICMD_BUPWRITE;
    params_in->addr = block_id;
    params_in->len  = sizeof(dummy_block);
    memcpy(pkt_in->data, dummy_block, sizeof(dummy_block));

    bup_file_process(pkt_in, pkt_out);

    termout(WL_LOG_DEBUGNORMAL, "[bup_test_bench::WRITE]len:%u -> %s", params_out->len, (params_out->len == 0 ? "NG" : "OK"));


    /* ------------------------------------------ */
    /* Read back the block written just before. */
    memset(pkt_in , 0, sizeof(wl_spi_pkt_t));
    memset(pkt_out, 0, sizeof(wl_spi_pkt_t));
    pkt_in->cmn.command = WL_SPICMD_BUPREAD;
    params_in->addr = block_id;
    params_in->len  = sizeof(dummy_block);

    bup_file_process(pkt_in, pkt_out);

    int compare_result = memcmp(pkt_out->data, dummy_block, sizeof(dummy_block));

    termout(WL_LOG_DEBUGNORMAL, "[bup_test_bench::READ]len:%u compare:%u -> %s", params_out->len, compare_result, ((params_out->len == 0) || (compare_result != 0) ? "NG" : "OK"));

}
#endif // BUP_TEST_BENCH_ENABLE == 1





/*
 * ------------------------------------------
 * - Test(s) execution function -------------
 * ------------------------------------------
 */
void do_tests(void)
{
    /* Do tests only when blue button is pushed. */
    if(HAL_GPIO_ReadPin(B1_GPIO_Port, B1_Pin) == GPIO_PIN_SET)
    {
        return;
    }


#if SDCARD_ACCESS_TEST_ENABLE == 1
    sdcard_access_test();
#endif // SDCARD_ACCESS_TEST_ENABLE == 1

#if BUP_TEST_BENCH_ENABLE == 1
    bup_test_bench();
#endif // BUP_TEST_BENCH_ENABLE == 1
}
