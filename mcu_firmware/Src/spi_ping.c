#include "spi_ping.h"

#include "crc.h"


/*
 * ------------------------------------------
 * - SPI test with ping ---------------------
 * ------------------------------------------
 */


/* SPI ping command. */
#include <stdlib.h> /* For rand functions. */
unsigned long _spi_ping_prev_seed = 0x12345678;
wl_spi_ping_verif_t _spi_ping_verif = {0};

void spi_ping_init(void)
{
    _spi_ping_prev_seed = 0x12345678;
    memset(&_spi_ping_verif, 0, sizeof(wl_spi_ping_verif_t));
}

void spi_ping_pre_process(wl_spi_header_t* hdr, unsigned char* data_tx)
{
    wl_spi_ping_params_t* params = (wl_spi_ping_params_t*)hdr->params;

    /* STM32 side verification results are kept in global variable because
     * it contains cumulative CRC error count.
     */
    wl_spi_ping_verif_t* verif_s32 = &_spi_ping_verif;
    unsigned char* data_s32 = data_tx + sizeof(wl_spi_ping_verif_t);


    /* Data length integrity check. */
    if(params->data_len > (WL_SPI_DATA_MAXLEN - sizeof(wl_spi_ping_verif_t)))
    {
        params->data_len = WL_SPI_DATA_MAXLEN - sizeof(wl_spi_ping_verif_t);
    }
    if(params->crc_len > params->data_len)
    {
        params->crc_len = params->data_len;
    }



    /* Prepare test data to send back to MAX 10. */
    unsigned char pattern = params->pattern;

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

            data_s32[i] = c;
        }
    }

    /* Compute CRC of test data about to send.
     * Note : the case crc_len equal to zero doesn't harms.
     */
    verif_s32->crc_val = crc32_calc(data_s32, params->crc_len);


    /* As total error count is sent to MAX 10, verification results
     * must be kept in global variable and copied just before it is sent.
     */
    memcpy(data_tx, verif_s32, sizeof(wl_spi_ping_verif_t));
}

void spi_ping_post_process(wl_spi_header_t* hdr, unsigned char* data_rx)
{
    wl_spi_ping_params_t* params = (wl_spi_ping_params_t*)hdr->params;

    /* Result of verification done on MAX 10 side is not checked because
     * SPI communication verification is done on MAX 10 side, in preparation of
     * providing the results to Saturn.
     */
    //wl_spi_ping_verif_t* verif_m10 = (wl_spi_ping_verif_t*)data_rx;
    unsigned char* data_m10 = data_rx + sizeof(wl_spi_ping_verif_t);

    wl_spi_ping_verif_t* verif_s32 = &_spi_ping_verif;


    /* Verify CRC of test data received from STM32.
     * (Even in the case crc_len equal to zero, CRC value must be set)
     */
    unsigned long crc = crc32_calc(data_m10, params->crc_len);
    verif_s32->prev_crc_fail = (crc != verif_s32->crc_val ? 1 : 0);
    if(verif_s32->crc_error_total < 0xFFFF)
    {
        verif_s32->crc_error_total += verif_s32->prev_crc_fail;
    }
    if(verif_s32->count_total < 0xFFFFFFFF)
    {
        verif_s32->count_total++;
    }
}

