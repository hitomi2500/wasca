#ifndef _WL_SPI_MAX10_H_
#define _WL_SPI_MAX10_H_

#include "main.h"
#include "stm32f4xx_hal.h"

#include "wasca_defs.h"

/*
 * ------------------------------------------
 * - SPI stuff ------------------------------
 * ------------------------------------------
 */

/* Global variables for debug usage. */
extern unsigned long _spi_rcv_cnt;
extern unsigned long _spi_shift_cnt;


/* Initialize SPI internals. */
void spi_init(void);



/* Do periodic check of SPI status.
 * This must be done on main module side, away from interrupts
 * throwing log messages.
 *
 * Returns 1 when finished to process a SPI packet, zero else.
 */
int spi_periodic_check(void);

#endif // _WL_SPI_MAX10_H_
