#include <stdio.h>
#include <string.h>
#include "spi_max10.h"

#include "bup_bootrom.h"
#include "log.h"

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



/* Global variable indicating SPI communication state.
 * This is shared between SPI interrupt handler
 * and main routines.
 */
#define SPI_STATE_PREPARE_RCV   0
#define SPI_STATE_RCV_IDLE      1
#define SPI_STATE_MSGPROC_START 2
#define SPI_STATE_MSGPROC_DONE  3
#define SPI_STATE_SEND_RESPONSE 4
#define SPI_STATE_SEND_IDLE     5

int _spi_state = SPI_STATE_PREPARE_RCV;

/* SPI state machine update. */
void spi_update_state(int spi_state);



void SPI_IRQHandler(void)
{
    /* USER CODE BEGIN SPI1_IRQn 0 */
    spi_logout("^^^ Tick[0x%08X] SPI_IRQHandler STT", (unsigned int)HAL_GetTick());
    /* USER CODE END SPI1_IRQn 0 */

    HAL_SPI_IRQHandler(&hspi1);

    /* USER CODE BEGIN SPI1_IRQn 1 */
    spi_logout("^^^ Tick[0x%08X] SPI_IRQHandler STT", (unsigned int)HAL_GetTick());
    /* USER CODE END SPI1_IRQn 1 */
}

// https://stm32f4-discovery.net/2014/08/stm32f4-external-interrupts-tutorial/
// http://www.lxtronic.com/index.php/basic-spi-simple-read-write

/* Rx/Tx buffers. */
wl_spi_pkt_t _spi_trans_hdr_rx;
wl_spi_pkt_t _spi_trans_hdr_tx;

/* Packet reception work buffer. */
wl_spi_pkt_t _spi_rx_wk_buff;



/* SPI flow control macros.
 * For internal use here only.
 */
#define SPI_MASTER_REQUESTING() (HAL_GPIO_ReadPin(SPI_SYNC_MOSI_GPIO_Port, SPI_SYNC_MOSI_Pin) == GPIO_PIN_RESET)
#define SPI_INDICATE_READY() HAL_GPIO_WritePin(SPI_SYNC_MISO_GPIO_Port, SPI_SYNC_MISO_Pin, GPIO_PIN_RESET)
#define SPI_INDICATE_IDLE()  HAL_GPIO_WritePin(SPI_SYNC_MISO_GPIO_Port, SPI_SYNC_MISO_Pin, GPIO_PIN_SET  )

// (Will remove these ones soon)
#define SPI_MAX10_RCV_HDR_READY() HAL_GPIO_WritePin(SPI_SYNC_MISO_GPIO_Port, SPI_SYNC_MISO_Pin, GPIO_PIN_RESET)
#define SPI_MAX10_SND_RSP_READY() HAL_GPIO_WritePin(SPI_SYNC_MISO_GPIO_Port, SPI_SYNC_MISO_Pin, GPIO_PIN_SET  )

/* Internals to receive and process log messages from MAX 10. */
int _logs_process_flag = 0;
unsigned short _logs_msg_len = 0;
unsigned char _logs_buffer[WL_LOG_BUFFER_SIZE] = {'\0'};



unsigned char char2pchar(unsigned char c)
{
    /* Display differently null and FF characters.
     * It helps to spot them in screen full of hexa codes.
     */
    if(c == 0x00) return '~';
    if(c == 0xFF) return 'X';

    /* Non-displayable characters. */
    if(c < ' ') return '.';
    if(c > 127) return '?';

    return c;
}


void spi_init(void)
{
    /* Reset internals for logs from MAX 10. */
    _logs_process_flag = 0;
    _logs_msg_len      = 0;
    memset(&_logs_buffer, 0, sizeof(_logs_buffer));

//    /* Prevent from receiving data while transaction header isn't yet processed. */
//    HAL_GPIO_WritePin(SPI_SYNC_MISO_GPIO_Port, SPI_SYNC_MISO_Pin, GPIO_PIN_RESET);

    /* Reset the internals. */
    memset(&_spi_trans_hdr_rx, 0, sizeof(wl_spi_pkt_t));
    memset(&_spi_trans_hdr_tx, 0, sizeof(wl_spi_pkt_t));
    memset(&_spi_rx_wk_buff  , 0, sizeof(wl_spi_pkt_t));

    /* Prepare reception of first transmission header. */
    _spi_state = SPI_STATE_PREPARE_RCV;
    spi_update_state(_spi_state);
}


/* Simple function to translate memory alias.
 * Note : handles only translation to physical
 *        address : logs access etc must be
 *        implemented separately.
 */
unsigned long spi_memacc_translate(wl_spicomm_memacc_t* param)
{
    unsigned long addr_prefix = param->addr >> 24;
    unsigned long addr_tmp;

    switch(addr_prefix)
    {
    /* STM32 Flash ROM, first 1MB. */
    case(((WL_STADR_FLASH) >> 24) + 0x00):
        addr_tmp = param->addr & 0x00FFFFFF;
        addr_tmp += 0x08000000;
        param->addr = addr_tmp;
        break;
    /* STM32 Flash ROM, second 1MB. */
    case(((WL_STADR_FLASH) >> 24) + 0x01):
        addr_tmp = param->addr & 0x00FFFFFF;
        addr_tmp += 0x08100000;
        param->addr = addr_tmp;
        break;

    /* SRAM. */
    case((WL_STADR_SRAM) >> 24):
        addr_tmp = param->addr & 0x00FFFFFF;
        addr_tmp += 0x20000000;
        param->addr = addr_tmp;
        break;

    /* Direct access, or alias unsupported here. */
    default:
        break;
    }

    /* Return address prefix, so that caller
     * can do whatever they want with it.
     */
    return addr_prefix;
}




void HAL_SPI_RxTxCpltCallback(SPI_HandleTypeDef* hspi)
{
    spi_logout("Tick[0x%08X][%s::%d] HAL_SPI_RxTxCpltCallback called"
        , (unsigned int)HAL_GetTick()
        , __FILE__, __LINE__);
}


//void HAL_SPI_RxHalfCpltCallback (SPI_HandleTypeDef *hspi)
//{
//    spi_logout("Tick[0x%08X][%s::%d] HAL_SPI_RxHalfCpltCallback called"
//        , (unsigned int)HAL_GetTick()
//        , __FILE__, __LINE__);
//}


void HAL_SPI_TxCpltCallback(SPI_HandleTypeDef* hspi)
{
    spi_logout("Tick[0x%08X][%s::%d] HAL_SPI_TxCpltCallback called state[%d]"
        , (unsigned int)HAL_GetTick()
        , __FILE__, __LINE__
        , _spi_state);

    /* Indicate that SPI must be re-init for next transation.
     * We are currently in interrupt handler, and this must be
     * done on main module side, hence the trick below with
     * global variable.
     */
    _spi_state = SPI_STATE_PREPARE_RCV;
}

unsigned long _spi_rcv_cnt   = 0; // DEBUG
unsigned long _spi_shift_cnt = 0; // DEBUG
void HAL_SPI_RxCpltCallback(SPI_HandleTypeDef* hspi)
{
    spi_logout("Tick[0x%08X][%s::%d] HAL_SPI_RxCpltCallback called state[%d]"
        , (unsigned int)HAL_GetTick()
        , __FILE__, __LINE__
        , _spi_state);

    wl_spi_pkt_t* pkt_rx = &_spi_trans_hdr_rx;

    if(_spi_rx_wk_buff.cmn.magic_ca == 0xCA)
    {
        memcpy(pkt_rx, &_spi_rx_wk_buff, sizeof(wl_spi_pkt_t));
    }
    else
    {
        /* Dirty tweak ... */
        unsigned short* dst = (unsigned short*)pkt_rx;
        unsigned short* src = (unsigned short*)&_spi_rx_wk_buff;
        for(int i=0; i<((sizeof(wl_spi_pkt_t)-1) / sizeof(unsigned short)); i++)
        {
            dst[i] = src[i+1];
        }
//termout(WL_LOG_DEBUGNORMAL, "[HAL_SPI_RxCpltCallback] Warning : packet contents was shifted.");
        _spi_shift_cnt++;
    }
    _spi_rcv_cnt++;

    /* Log transmission header contents. */
    spi_logout("*** magic:%02X %02X, len:%u"
        , pkt_rx->cmn.magic_ca
        , pkt_rx->cmn.magic_fe
        , pkt_rx->cmn.pkt_len);

    if((pkt_rx->cmn.magic_ca != 0xCA)
    && (pkt_rx->cmn.magic_fe != 0xFE))
    {
        spi_error_out("*** SPI ERROR *** Invalid header ! magic:%02X %02X, len:%u"
            , pkt_rx->cmn.magic_ca
            , pkt_rx->cmn.magic_fe
            , pkt_rx->cmn.pkt_len);
        for(int i=0; i<16; i++)
        {
            unsigned char* ptr = (unsigned char*)pkt_rx;
            spi_error_out("| Rcv[%3d]:0x%02X (%c)", i, ptr[i], ptr[i]);
        }

        _spi_state = SPI_STATE_PREPARE_RCV;
        return;
    }


    if(_spi_state == SPI_STATE_RCV_IDLE)
    { /* Finished to receive packet from MAX10 : will prepare answer packet outside of this IRQ handler. */
        _spi_state = SPI_STATE_MSGPROC_START;
    }
    else if(_spi_state == SPI_STATE_MSGPROC_DONE)
    { /* Answered back to MAX 10. */
    }
    else
    { /* Finished to send back packet to MAX10 : prepare for receiving next packet. */
        spi_logout("HAL_SPI_Transmit END");

        _spi_state = SPI_STATE_PREPARE_RCV;
    }
}


void spi_send_answer(void)
{
    // Will remove soon !
}

void spi_update_state(int spi_state)
{
    // Will remove soon !
}


int spi_periodic_check(void)
{
    if(!SPI_MASTER_REQUESTING())
    {
        return 0;
    }

    unsigned long rxtx_timeout = 1000;
    wl_spi_pkt_t* pkt_rx = &_spi_trans_hdr_rx;
    wl_spi_pkt_t* pkt_tx = &_spi_trans_hdr_tx;

    /* Process request from MAX 10. */
    SPI_INDICATE_READY();

    /* We need to be fast between the time we indicate MAX 10
     * that we are ready and the time we are actually ready
     * to process input from SPI.
     * 
     * So extra processing (log output etc) is prohibited here.
     */
    if(HAL_SPI_Receive(&hspi1, (uint8_t*)&_spi_rx_wk_buff, sizeof(wl_spi_pkt_t) / sizeof(unsigned short), rxtx_timeout) != HAL_OK)
    {
        Error_Handler();
    }


    if(_spi_rx_wk_buff.cmn.magic_ca == 0xCA)
    {
        memcpy(pkt_rx, &_spi_rx_wk_buff, sizeof(wl_spi_pkt_t));
    }
    else
    {
        /* Dirty tweak ... */
        unsigned short* dst = (unsigned short*)pkt_rx;
        unsigned short* src = (unsigned short*)&_spi_rx_wk_buff;
        for(int i=0; i<((sizeof(wl_spi_pkt_t)-1) / sizeof(unsigned short)); i++)
        {
            dst[i] = src[i+1];
        }
//termout(WL_LOG_DEBUGNORMAL, "[HAL_SPI_RxCpltCallback] Warning : packet contents was shifted.");
        _spi_shift_cnt++;
    }


    /* Copy back header from Rx to Tx buffer. */
    memcpy(&(pkt_tx->cmn), &(pkt_rx->cmn), sizeof(wl_spi_common_hdr_t));

    /* Initialize CRC length : it will be set
     * a bit after if integrity check is enabled.
     */
    pkt_tx->params_crc_len = 0;
    pkt_tx->data_crc_len   = 0;

    /******************************************/
    /* Prepare response for sending to MAX10. */
    spi_logout("Tick[0x%08X] MAGIC[%02X %02X] CMD[0x%02X]", (unsigned int)HAL_GetTick(), pkt_rx->cmn.magic_ca, pkt_rx->cmn.magic_fe, pkt_rx->cmn.command);

    if(pkt_rx->cmn.command == WL_SPICMD_VERSION)
    { /* MAX10/STM32 firmware versions exchange. */
        /* Display MAX 10 firmware version informations. */
        wl_verinfo_ext_t* m10_ver = (wl_verinfo_ext_t*)pkt_rx->data;
        m10_ver->dev_type[sizeof(m10_ver->dev_type) - 1] = '\0';
        m10_ver->prj_name[sizeof(m10_ver->prj_name) - 1] = '\0';
        spi_logout("*** MAX 10 version : DEV[%s]", m10_ver->dev_type);
        spi_logout("*** MAX 10 version : PL[%u %04u]", m10_ver->pl_time, m10_ver->pl_date);
        spi_logout("*** MAX 10 version : NAME[%s]", m10_ver->prj_name);


        /* Send back STM32 firmware informations to MAX 10. */
        wl_spicomm_version_t* ver = (wl_spicomm_version_t*)pkt_tx->data;
        memset(ver, 0, sizeof(wl_spicomm_version_t));

        char* build_date = __DATE__;
        char* build_time = __TIME__;
        strcpy(ver->build_date, build_date);
        strcpy(ver->build_time, build_time);

        spi_logout("Tick[0x%08X] Version[%s][%s]", (unsigned int)HAL_GetTick(), ver->build_date, ver->build_time);
    }
    else if(pkt_rx->cmn.command == WL_SPICMD_LOGS)
    { /* Log messages from MAX 10. */
        wl_spicomm_logs_t* logs_param = (wl_spicomm_logs_t*)pkt_rx->params;
        unsigned char* logs_data = pkt_rx->data;

        if(logs_param->block_id != 0)
        {
            unsigned short offset = (logs_param->block_id - 1) * WL_SPI_DATA_LEN;
            unsigned short len    = logs_param->block_len;
            memcpy(_logs_buffer + offset, logs_data, len);

            /* Indicate to process log messages when last block is received. */
            if(logs_param->block_id == logs_param->block_cnt)
            {
                _logs_msg_len = offset + len;
                _logs_process_flag = 1;
            }
        }

    }
    else if(pkt_rx->cmn.command == WL_SPICMD_MEMREAD)
    { /* STM32 memory/registers read. */
        wl_spicomm_memacc_t* rd_params = (wl_spicomm_memacc_t*)pkt_rx->params;

        /* Translate address alias. */
        unsigned long addr_prefix = spi_memacc_translate(rd_params);

        spi_logout("Tick[0x%08X] MemRead[0x%08X][%u]", (unsigned int)HAL_GetTick(), (unsigned int)rd_params->addr, rd_params->len);

        if(addr_prefix == (WL_STADR_LOGS_FIFO >> 24))
        {
            /* Special alias when reading logs from circular buffer :
             *  - Address is ignored and logs data
             *    are read from start of circular buffer.
             *  - Read data size is limited to amount
             *    of data available in circular buffer.
             *
             * Additionally, special alias at offset 0x01_0000
             * returns amount of data into circular buffer without
             * touching its contents.
             */
            if(rd_params->addr == WL_STADR_LOGS_STAT)
            {
                 memset(pkt_tx->data, 0x00, rd_params->len);

                if(rd_params->len == sizeof(wla_logs_stats_t))
                {
                    /* Return logs circular buffer status. */
                    wla_logs_stats_t* st = (wla_logs_stats_t*)pkt_tx->data;

                    //spi_logout("@@@ Tick[0x%08X] log_cbmem_use:%5u"
                    //    , (unsigned int)HAL_GetTick()
                    //    , (unsigned int)log_cbmem_use());

                    st->buffer_size = log_cbmem_total();
                    st->usage       = log_cbmem_use();
                 }
            }
            else
            {
                /* Read logs from circular buffer. */
                unsigned short read_len = log_cbmem_use();
                // spi_logout("@@@ Tick[0x%08X] logs_cb_read:%5u, len:%5u"
                //     , (unsigned int)HAL_GetTick()
                //     , (unsigned int)read_len
                //     , (unsigned int)rd_params->len);

                if(rd_params->len < read_len)
                {
                   read_len = rd_params->len;
                }

                memset(pkt_tx->data, 'P', rd_params->len);
                log_cbread(pkt_tx->data, read_len, 1/*update_rp*/);
             }
        }
        else
        {
            /* Direct read from specified (physical or alias) address. */
            memcpy(pkt_tx->data, (void*)(rd_params->addr), rd_params->len);
        }
    }
    else if(pkt_rx->cmn.command == WL_SPICMD_MEMWRITE)
    { /* STM32 memory/registers write. */
        wl_spicomm_memacc_t* wr_params = (wl_spicomm_memacc_t*)pkt_rx->params;
        unsigned char* wr_data = pkt_rx->data;

        /* Translate address alias. */
        spi_memacc_translate(wr_params);

        spi_logout("Tick[0x%08X] MemWrite[0x%08X][%u] Data[0x%02X %02X %02X %02x ...]", 
            (unsigned int)HAL_GetTick(), 
            (unsigned int)wr_params->addr, wr_params->len, 
            (unsigned int)(wr_data[0]), (unsigned int)(wr_data[1]), (unsigned int)(wr_data[2]), (unsigned int)(wr_data[3]));

        memcpy((void*)(wr_params->addr), wr_data, wr_params->len);
    }
    else if(WL_SPICMD_IS_BUP(pkt_rx->cmn.command))
    { /* Backup memory read/write/etc access. */

        bup_file_process(pkt_rx, pkt_tx);
    }
    else if(WL_SPICMD_IS_BOOTROM(pkt_rx->cmn.command))
    { /* Cartridge boot ROM file access. */

        bootrom_process(pkt_rx, pkt_tx);
    }
    else
    { /* Dummy answer. */

        pkt_tx->cmn.command = WL_SPICMD_DUMMY;

        pkt_tx->data[WL_SPI_DATA_LEN - 1] = '\0';

        spi_logout("HAL_SPI_Receive DATA[%s]", (char*)(pkt_rx->data));

        char answer_tmp[30];
        memcpy(answer_tmp, pkt_tx->data, sizeof(answer_tmp)-1);
        answer_tmp[sizeof(answer_tmp)-1] = '\0';

        sprintf((char*)pkt_tx->data, "Tick[%08X][%s]Hello, this is STM32, hope you are well."
            , (unsigned int)HAL_GetTick()
            , answer_tmp);
        pkt_tx->data[WL_SPI_DATA_LEN - 1] = '\0';
    }

    spi_logout("Tick[0x%08X]Response str[%c%c%c%c%c%c%c%c%c%c%c%c]"
        , (unsigned int)HAL_GetTick()
        , pkt_tx->data[ 0], pkt_tx->data[ 1], pkt_tx->data[ 2], pkt_tx->data[ 3]
        , pkt_tx->data[ 4], pkt_tx->data[ 5], pkt_tx->data[ 6], pkt_tx->data[ 7]
        , pkt_tx->data[ 8], pkt_tx->data[ 9], pkt_tx->data[10], pkt_tx->data[11]);


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
    if(HAL_SPI_Transmit(&hspi1, (uint8_t*)pkt_tx, sizeof(wl_spi_pkt_t) / sizeof(unsigned short), rxtx_timeout) != HAL_OK)
    {
        Error_Handler();
    }

// TODO : allow reception when it's necessary :
//   HAL_SPI_TransmitReceive(SPI_HandleTypeDef *hspi, uint8_t *pTxData, uint8_t *pRxData, uint16_t Size, uint32_t Timeout)
//   HAL_SPI_Receive(SPI_HandleTypeDef *hspi, uint8_t *pData, uint16_t Size, uint32_t Timeout)


    return 1;
}
