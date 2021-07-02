/*
 * Copyright (C) 2020 Sean Gonsalves
 *
 * This file is part of Neo CD SD Loader.
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

#include "main.h"
#include "jtag.h"
#ifdef STANDALONE
#include "util.h"
#include <stdio.h>
#endif

#define LAST_STATE_IDLE 0
#define LAST_STATE_PAUSE_IR 1
#define LAST_STATE_PAUSE_DR 2

int iLastState;

void TDI_SET(int v) {
	if (0 == v)
		HAL_GPIO_WritePin(TDI_PORT, MAX_TDI_Pin, GPIO_PIN_RESET);
	else
		HAL_GPIO_WritePin(TDI_PORT, MAX_TDI_Pin, GPIO_PIN_SET);
}

const unsigned int MAX_TCK_Pin_32 = MAX_TCK_Pin;
const unsigned int MAX_TCK_Pin_32_L16 = (uint32_t)MAX_TCK_Pin << 16U;

void JTAG_Tick() {
	//asm("nop");//delay_us(1);
	//TCK_HIGH
	TCK_PORT->BSRR = MAX_TCK_Pin_32;
	//asm("nop");//delay_us(1);
	//TCK_LOW
	TCK_PORT->BSRR = MAX_TCK_Pin_32_L16;
}

void JTAG_Ticks(int number) {
	for (int i=0;i<number;i++)
	{
		//TCK_HIGH
		TCK_PORT->BSRR = MAX_TCK_Pin_32;
		//TCK_LOW
		TCK_PORT->BSRR = MAX_TCK_Pin_32_L16;
	}
}


void JTAG_Reset() {
	// JTAG state is random on power up, send 5 CLKs with TMS high to ensure state goes to Test-Logic-Reset
	TMS_HIGH
	JTAG_Tick();
	JTAG_Tick();
	JTAG_Tick();
	JTAG_Tick();
	JTAG_Tick();
	TMS_LOW
	JTAG_Tick();
	iLastState = LAST_STATE_IDLE;
}

void JTAG_SIR(uint32_t data_in, const uint32_t length) {
	// Scan Instruction Register
	switch (iLastState)
	{
	case LAST_STATE_IDLE:
		// From Idle state
		TMS_HIGH
		JTAG_Tick();	// Select-DR
		JTAG_Tick();	// Select-IR
		TMS_LOW
		JTAG_Tick();	// Capture-IR
		JTAG_Tick();	// Shift-IR
		break;
	case LAST_STATE_PAUSE_IR:
		// From Pause-IR state
		TMS_HIGH
		JTAG_Tick();	// Exit2-IR
		TMS_LOW
		JTAG_Tick();	// Shift-IR
		break;
	}

	for (uint32_t b = 0; b < length; b++) {
		if (b == length-1)
			TMS_HIGH
		TDI_SET(data_in & 1);
		JTAG_Tick();
		data_in >>= 1;
	}
	//TMS_LOW
	//JTAG_Tick();	// Pause-IR
	//iLastState = LAST_STATE_PAUSE_IR;
	JTAG_Tick();	// Update-IR
	TMS_LOW
	JTAG_Tick();	// Back to Idle
	iLastState = LAST_STATE_IDLE;
}

uint32_t JTAG_SDR(uint32_t data_in, const uint32_t length) {
	uint32_t sr = 0;

	// Scan Data Register
	switch (iLastState)
	{
	case LAST_STATE_IDLE:
		// From Idle state
		TMS_HIGH
		JTAG_Tick();	// Select-DR
		TMS_LOW
		JTAG_Tick();	// Capture-DR
		JTAG_Tick();	/// Shift-DR
		break;
	case LAST_STATE_PAUSE_IR:
		// From Pause-IR state
		TMS_HIGH
		JTAG_Tick();	// Exit2-IR
		JTAG_Tick();	// Update-IR
		JTAG_Tick();	// Select-DR
		TMS_LOW
		JTAG_Tick();	// Capture-DR
		JTAG_Tick();	/// Shift-DR
		break;
	}


	for (uint32_t b = 0; b < length; b++) {
		if (b == length-1)
			TMS_HIGH
		sr |= (((TDO_PORT->IDR & MAX_TDO_Pin) ? 1 : 0) << b);	// TDO
		TDI_SET(data_in & 1);
		JTAG_Tick();
		data_in >>= 1;
	}
	JTAG_Tick();	// Update-DR
	TMS_LOW
	JTAG_Tick();	// Back to Idle

	iLastState = LAST_STATE_IDLE;

	return sr;
}

/*void JTAG_Run(uint32_t ticks) {
	for (uint32_t c = 0; c < ticks; c++)
		delay_us(2);
}*/

/*void JTAG_SetAddress(uint32_t address) {
	JTAG_SIR(ISC_ADDRESS_SHIFT, 10);
	JTAG_Run(6);
	JTAG_SDR(address, 13);
}*/

/*uint32_t JTAG_Code(const uint32_t cmd) {
	// This is NOT the silicon ID !
	// 5M240ZT100 IDCODE is 0x020A50DD

	JTAG_Reset();
	JTAG_SIR(cmd, 10);

	return JTAG_SDR(0xFFFF, 32);
}*/

/*void JTAG_Erase() {
	JTAG_SetAddress(0x0011);
	JTAG_SIR(ISC_ERASE, 10);
	JTAG_Run(250000);	// Wait 500ms

	JTAG_SetAddress(0x0001);
	JTAG_SIR(ISC_ERASE, 10);
	JTAG_Run(250000);	// Wait 500ms

	JTAG_SetAddress(0x0000);
	JTAG_SIR(ISC_ERASE, 10);
	JTAG_Run(250000);	// Wait 500ms
}*/

/*void JTAG_Enable() {
	JTAG_SIR(ISC_ENABLE, 10);
	JTAG_Run(500);	// Wait 1ms
}

void JTAG_Disable() {
	JTAG_SIR(ISC_DISABLE, 10);
	JTAG_Run(500);	// Wait 1ms
	JTAG_SIR(JTAG_BYPASS, 10);
	JTAG_Run(500);	// Wait 1ms
}*/



/*void JTAG_StartProgram() {
	JTAG_SetAddress(0x0000);
	JTAG_SIR(ISC_PROGRAM, 10);
	JTAG_Run(6);
}

/*void JTAG_Program(const uint16_t * data_ptr, uint32_t size) {
	for (uint32_t c = 0; c < size; c++) {
		JTAG_SDR(*data_ptr++, 16);
		JTAG_Run(50);	// Wait 100us
	}
}*/

/*void JTAG_StartRead() {
	JTAG_SetAddress(0x0000);
	JTAG_SIR(ISC_READ, 10);
	JTAG_Run(6);
}*/

/*uint32_t JTAG_Verify(const uint16_t * data_ptr, uint32_t size) {
	for (uint32_t c = 0; c < size; c++) {
#ifdef STANDALONE
	    char buffer_print[64];
		uint16_t readback = JTAG_SDR(0xFFFF, 16);
		if (*data_ptr != readback) {
			sprintf(buffer_print, "%04lx: %04x vs %04x", c, *data_ptr, readback);
			CDCPrint(buffer_print);
			return 1;	// Error
		}
		data_ptr++;
#else
		if (*data_ptr++ != JTAG_SDR(0xFFFF, 16))
			return 1;	// Error
#endif
	}
	return 0;
}*/

/*void JTAG_ProgramDone() {
	JTAG_SetAddress(0x0000);
	JTAG_SIR(ISC_PROGRAM, 10);
	JTAG_Run(6);

	JTAG_SDR(0x7BFF, 16);
	JTAG_Run(50);	// Wait 100us
	// Same as already programmed data. Following operations are not needed ?
	JTAG_SDR(0xFFFF, 16);
	JTAG_Run(50);	// Wait 100us
	JTAG_SDR(0xBFFF, 16);
	JTAG_Run(50);	// Wait 100us
	JTAG_SDR(0xFFFF, 16);
	JTAG_Run(50);	// Wait 100us
}*/
