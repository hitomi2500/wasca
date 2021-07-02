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
	//TCK_HIGH
	TCK_PORT->BSRR = MAX_TCK_Pin_32;
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
