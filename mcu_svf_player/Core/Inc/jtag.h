/*
 * Copyright (C) 2020 Sean Gonsalves
 *
 * This file is heavily based on Neo CD SD Loader.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 51 Franklin Street,
 * Boston, MA 02110-1301, USA.
 */

#include <stdint.h>

#ifndef __CPLD_UPDATE_H__
#define __CPLD_UPDATE_H__

#define TMS_PORT GPIOA
#define TCK_PORT GPIOB
#define TDI_PORT GPIOA
#define TDO_PORT GPIOB

//#define TMS_HIGH LL_GPIO_SetOutputPin(GPIOA, GPIO_PIN_10);
#define TMS_HIGH HAL_GPIO_WritePin(TMS_PORT, MAX_TMS_Pin, GPIO_PIN_SET);
//#define TMS_LOW LL_GPIO_ResetOutputPin(GPIOA, GPIO_PIN_10);
#define TMS_LOW HAL_GPIO_WritePin(TMS_PORT, MAX_TMS_Pin, GPIO_PIN_RESET);

//#define TCK_HIGH LL_GPIO_SetOutputPin(GPIOA, GPIO_PIN_15);
#define TCK_HIGH HAL_GPIO_WritePin(TCK_PORT, MAX_TCK_Pin, GPIO_PIN_SET);
//#define TCK_LOW LL_GPIO_ResetOutputPin(GPIOA, GPIO_PIN_15);
#define TCK_LOW HAL_GPIO_WritePin(TCK_PORT, MAX_TCK_Pin, GPIO_PIN_RESET);

//#define TDI_SET(v) GPIOA->BSRR = ((v) ? GPIO_BSRR_BS_13 : GPIO_BSRR_BR_13);
void TDI_SET(int v);

#define JTAG_BYPASS			0b1111111111
#define JTAG_IDCODE 		0b0000000110
#define JTAG_USERCODE 		0b0000000111

#define ISC_ENABLE 			0b1011001100
#define ISC_DISABLE 		0b1000000001
#define ISC_PROGRAM 		0b1011110100
#define ISC_ERASE 			0b1011110010
#define ISC_ADDRESS_SHIFT 	0b1000000011
#define ISC_READ 			0b1000000101
#define ISC_NOOP 			0b1000010000

void JTAG_Reset();
void JTAG_SIR(uint32_t data_in, const uint32_t length);
uint32_t JTAG_SDR(uint32_t data_in, const uint32_t length);

#endif /* __CPLD_UPDATE_H__ */
