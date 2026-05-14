#ifndef _WL_SPI_PING_H_
#define _WL_SPI_PING_H_

#include <stdio.h>
#include <string.h>
#include <stdarg.h>

#include "main.h"
#include "stm32f4xx_hal.h"

#include "wasca_defs.h"


/**
 * spi_ping_init
 *
 * Initialize SPI internals.
 * Must be called on application startup.
**/
void spi_ping_init(void);


/**
 * spi_ping_pre_process / spi_ping_post_process
 *
 * Send back and verify SPI ping packet.
 *
 * "Pre"  function : called when header is received.
 * "Post" function : called when header and data are received.
**/
void spi_ping_pre_process(wl_spi_header_t* hdr, unsigned char* data_tx);
void spi_ping_post_process(wl_spi_header_t* hdr, unsigned char* data_rx);


#endif // _WL_SPI_PING_H_
