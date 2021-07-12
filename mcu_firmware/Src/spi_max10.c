#include <stdio.h>
#include <string.h>
#include "spi_max10.h"

#include "bup_bootrom.h"
#include "log.h"
#include "settings.h"
#include "spi_ping.h"

/* External definitions for our SPI interface. */
extern SPI_HandleTypeDef hspi1;
extern DMA_HandleTypeDef hdma_spi1_rx;
extern DMA_HandleTypeDef hdma_spi1_tx;

/* Enable below to output logs for SPI debug. */
#define SPI_DEBUG_LOGS 0

#if SPI_DEBUG_LOGS == 1
#   define spi_logout(...) termout(WL_LOG_DEBUGNORMAL, __VA_ARGS__)
#else // SPI_DEBUG_LOGS
#   define spi_logout(...)
#endif // !SPI_DEBUG_LOGS

/* Output error messages to UART without consideration
 * of the log output setting above
 */
#define spi_error_out(...) termout(WL_LOG_DEBUGNORMAL, __VA_ARGS__)




/* SPI flow control macros.
 * For internal use here only.
 */
#define SPI_MASTER_REQUESTING() (HAL_GPIO_ReadPin(SPI_SYNC_MOSI_GPIO_Port, SPI_SYNC_MOSI_Pin) == GPIO_PIN_RESET)
#define SPI_INDICATE_READY() HAL_GPIO_WritePin(SPI_SYNC_MISO_GPIO_Port, SPI_SYNC_MISO_Pin, GPIO_PIN_RESET)
#define SPI_INDICATE_IDLE()  HAL_GPIO_WritePin(SPI_SYNC_MISO_GPIO_Port, SPI_SYNC_MISO_Pin, GPIO_PIN_SET  )


/* SPI Rx/Tx buffers :
 *  1.  [M->S] packet header
 *  2a. [M->S] Rx data block
 *  2b. [S->M] Tx data block
 *
 * Both Rx and Tx are rarely used simultaneously, but in order to ease
 * the implementation whole memory for them is allocated.
 */
#define SPI_DEBUG_GAP 8
unsigned short _spi_buffer[(sizeof(wl_spi_header_t) + SPI_DEBUG_GAP + WL_SPI_DATA_MAXLEN + SPI_DEBUG_GAP + WL_SPI_DATA_MAXLEN + SPI_DEBUG_GAP) / sizeof(unsigned short)];



/* Internals to receive and process log messages from MAX 10. */
int _logs_process_flag = 0;
unsigned short _logs_msg_len = 0;
unsigned char _logs_buffer[WL_LOG_BUFFER_SIZE] = {'\0'};


void spi_init(void)
{
    /* Reset internals for logs from MAX 10. */
    _logs_process_flag = 0;
    _logs_msg_len      = 0;
    memset(&_logs_buffer, 0, sizeof(_logs_buffer));

//    /* Prevent from receiving data while transaction header isn't yet processed. */
//    HAL_GPIO_WritePin(SPI_SYNC_MISO_GPIO_Port, SPI_SYNC_MISO_Pin, GPIO_PIN_RESET);

    /* Reset the internals. */
    memset(_spi_buffer, 0, sizeof(_spi_buffer));
}




void HAL_SPI_RxTxCpltCallback(SPI_HandleTypeDef* hspi)
{
    spi_logout("Tick[0x%08X][%s::%d] HAL_SPI_RxTxCpltCallback called"
        , (unsigned int)HAL_GetTick()
        , __FILE__, __LINE__);
}


unsigned long _spi_rcv_cnt   = 0; // DEBUG
unsigned long _spi_shift_cnt = 0; // DEBUG

int spi_periodic_check(void)
{
    if(!SPI_MASTER_REQUESTING())
    {
        return 0;
    }

    unsigned long rxtx_timeout = 1000;
    wl_spi_header_t* hdr = (wl_spi_header_t*)_spi_buffer;

    unsigned char* data_rx = (unsigned char*)(_spi_buffer + ((sizeof(wl_spi_header_t) + SPI_DEBUG_GAP) / sizeof(unsigned short)));
    unsigned char* data_tx = (unsigned char*)(_spi_buffer + ((sizeof(wl_spi_header_t) + SPI_DEBUG_GAP + WL_SPI_DATA_MAXLEN + SPI_DEBUG_GAP) / sizeof(unsigned short)));


    /* Process request from MAX 10. */
    SPI_INDICATE_READY();

    /* We need to be fast between the time we indicate MAX 10
     * that we are ready and the time we are actually ready
     * to process input from SPI.
     * 
     * So extra processing (log output etc) is prohibited here.
     */
    if(HAL_SPI_Receive(&hspi1, (uint8_t*)hdr, sizeof(wl_spi_header_t) / sizeof(unsigned short), rxtx_timeout) != HAL_OK)
    {
        Error_Handler();
    }


    if(hdr->magic_ca != 0xCA)
    {
        /* Dirty tweak ... */
        hdr = (wl_spi_header_t*)(_spi_buffer + 1);
        //termout(WL_LOG_DEBUGNORMAL, "[HAL_SPI_RxCpltCallback] Warning : packet contents was shifted.");
        _spi_shift_cnt++;
    }
    _spi_rcv_cnt++;


    /******************************************/
    /* Prepare response for sending to MAX10. */
    spi_logout("Tick[0x%08X] MAGIC[%02X %02X] CMD[0x%02X]", (unsigned int)HAL_GetTick(), hdr->magic_ca, hdr->magic_fe, hdr->command);

    if(hdr->command == WL_SPICMD_VERSION)
    { /* MAX10/STM32 firmware versions exchange. */

        /* Prepare STM32 firmware informations to send to MAX 10. */
        wl_verinfo_stm_t* s32_ver = (wl_verinfo_stm_t*)data_tx;
        memset(s32_ver, 0, sizeof(wl_verinfo_stm_t));

        char* build_date = __DATE__;
        char* build_time = __TIME__;
        strcpy(s32_ver->build_date, build_date);
        strcpy(s32_ver->build_time, build_time);

        /* Pack MAX 10 base settings with STM32 version information. */
        memcpy(&s32_ver->set, &_wasca_set.max, sizeof(wl_baseset_max_t));

        spi_logout("Tick[0x%08X] Version[%s][%s]", (unsigned int)HAL_GetTick(), s32_ver->build_date, s32_ver->build_time);
    }
    else if(WL_SPICMD_IS_BUP(hdr->command))
    { /* Backup memory read/write/etc access. */

        bup_file_pre_process(hdr, data_tx);
    }
    else if(WL_SPICMD_IS_BOOTROM(hdr->command))
    { /* Cartridge boot ROM file access. */

        bootrom_pre_process(hdr, data_tx);
    }
    else if(hdr->command == WL_SPICMD_PING)
    { /* SPI ping. */
        spi_ping_pre_process(hdr, data_tx);
    }

//     spi_logout("Tick[0x%08X]Response str[%c%c%c%c%c%c%c%c%c%c%c%c]"
//         , (unsigned int)HAL_GetTick()
//         , pkt_tx->data[ 0], pkt_tx->data[ 1], pkt_tx->data[ 2], pkt_tx->data[ 3]
//         , pkt_tx->data[ 4], pkt_tx->data[ 5], pkt_tx->data[ 6], pkt_tx->data[ 7]
//         , pkt_tx->data[ 8], pkt_tx->data[ 9], pkt_tx->data[10], pkt_tx->data[11]);


    /* As response data is ready, indicate that we are
     * ready to send it back to MAX 10.
     */
    SPI_INDICATE_IDLE();

    /* Similarly to packet reception, we need to be fast
     * between the time we indicate MAX 10 that we are
     * ready to reply and the time we are actually ready
     * to process input from SPI.
     * 
     * So extra processing (log output etc) is prohibited here.
     */
    if(hdr->data_len >= sizeof(unsigned short))
    {
        if(HAL_SPI_TransmitReceive(&hspi1, data_tx, data_rx, hdr->data_len / sizeof(unsigned short), rxtx_timeout) != HAL_OK)
        {
            Error_Handler();
        }
    }


    if(hdr->command == WL_SPICMD_VERSION)
    { /* MAX10/STM32 firmware versions exchange. */

        /* Display MAX 10 firmware version informations. */
        wl_verinfo_max_t* m10_ver = (wl_verinfo_max_t*)data_rx;
        m10_ver->dev_type[sizeof(m10_ver->dev_type) - 1] = '\0';
        spi_logout("*** MAX 10 version : DEV[%s]", m10_ver->dev_type);
        spi_logout("*** MAX 10 version : PL[%u %04u]", m10_ver->pl_time, m10_ver->pl_date);

    }
    else if(hdr->command == WL_SPICMD_LOGS)
    { /* Log messages from MAX 10. */
#if 0
        /* Keep logs messages received from MAX 10 in a circular buffer
         * so that they can be to sent to PC via USB when needed.
         *
         * TODO : should verify if log data last character is null or not, 
         *        because last character may not be sent when size of data
         *        sent over SPI is not a even number of bytes.
         */
        unsigned short logs_datalen = hdr->data_len;
        unsigned char* logs_data = data_rx;

        log_cbwrite(logs_data, logs_datalen);
#endif
    }
    else if(WL_SPICMD_IS_BUP(hdr->command))
    { /* Backup memory read/write/etc access. */

        bup_file_post_process(hdr, data_rx);
    }
    else if(WL_SPICMD_IS_BOOTROM(hdr->command))
    { /* Cartridge boot ROM file access. */

        bootrom_post_process(hdr, data_rx);
    }
    else if(hdr->command == WL_SPICMD_PING)
    { /* SPI ping. */
        spi_ping_post_process(hdr, data_rx);
    }

    return 1;
}
