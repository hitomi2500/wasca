/******************************************************************************
*																			 *
* License Agreement														   *
*																			 *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.		   *
* All rights reserved.														*
*																			 *
* Permission is hereby granted, free of charge, to any person obtaining a	 *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,	*
* and/or sell copies of the Software, and to permit persons to whom the	   *
* Software is furnished to do so, subject to the following conditions:		*
*																			 *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.						 *
*																			 *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,	*
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER	  *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING	 *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER		 *
* DEALINGS IN THE SOFTWARE.												   *
*																			 *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.			  *
*																			 *
******************************************************************************/

#ifndef __ALT_UP_RS232_REGS_H__
#define __ALT_UP_RS232_REGS_H__
#include <io.h>
#include <alt_types.h>

#define IOWR_ALT_UP_RS232_ADDR(base, addr, data)  \
		IOWR(base, addr, data)
/*
 * Data Register 
 */
#define ALT_UP_RS232_DATA_REG			   0

#define IOADDR_ALT_UP_RS232_DATA(base)	  \
		__IO_CALC_ADDRESS_NATIVE(base, ALT_UP_RS232_DATA_REG)
#define IORD_ALT_UP_RS232_DATA(base)		\
		IORD(base, ALT_UP_RS232_DATA_REG)
#define IOWR_ALT_UP_RS232_DATA(base, data)  \
		IOWR(base, ALT_UP_RS232_DATA_REG, data)

#define ALT_UP_RS232_DATA_DATA_MSK			(0x000001FF)
#define ALT_UP_RS232_DATA_DATA_OFST			(0)
#define ALT_UP_RS232_DATA_PE_MSK			(0x00000200)
#define ALT_UP_RS232_DATA_PE_OFST			(9)
#define ALT_UP_RS232_DATA_RVALID_MSK		(0x00008000)
#define ALT_UP_RS232_DATA_RVALID_OFST		(15)
#define ALT_UP_RS232_DATA_RAVAIL_MSK		(0xFFFF0000)
#define ALT_UP_RS232_DATA_RAVAIL_OFST		(16)

#define ALT_UP_RS232_DATA_REG_RAVAIL		2
#define IORD_ALT_UP_RS232_RAVAIL(base)		\
		IORD_16DIRECT(base, ALT_UP_RS232_DATA_REG_RAVAIL)
#define ALT_UP_RS232_RAVAIL_MSK				(0x0000FFFF)
#define ALT_UP_RS232_RAVAIL_OFST			(0)

#define ALT_UP_RS232_DATA_VALID_MSK			(ALT_UP_RS232_DATA_DATA_MSK 	\
											| ALT_UP_RS232_DATA_PE_MSK 	\
											| ALT_UP_RS232_DATA_RAVAIL_MSK)
/*
 * Control Register 
 */
#define ALT_UP_RS232_CONTROL_REG				1

#define IOADDR_ALT_UP_RS232_CONTROL(base)		\
		__IO_CALC_ADDRESS_NATIVE(base, ALT_UP_RS232_CONTROL_REG)
#define IORD_ALT_UP_RS232_CONTROL(base)			\
		IORD(base, ALT_UP_RS232_CONTROL_REG)
#define IOWR_ALT_UP_RS232_CONTROL(base, data)	\
		IOWR(base, ALT_UP_RS232_CONTROL_REG, data)

#define ALT_UP_RS232_CONTROL_RE_MSK				(0x00000001)
#define ALT_UP_RS232_CONTROL_RE_OFST			(0)
#define ALT_UP_RS232_CONTROL_WE_MSK				(0x00000002)
#define ALT_UP_RS232_CONTROL_WE_OFST			(1)
#define ALT_UP_RS232_CONTROL_RI_MSK				(0x00000100)
#define ALT_UP_RS232_CONTROL_RI_OFST			(8)
#define ALT_UP_RS232_CONTROL_WI_MSK				(0x00000200)
#define ALT_UP_RS232_CONTROL_WI_OFST			(9)
#define ALT_UP_RS232_CONTROL_WSPACE_MSK			(0xFFFF0000)
#define ALT_UP_RS232_CONTROL_WSPACE_OFST		(16)

#define ALT_UP_RS232_CONTROL_VALID_MSK			(ALT_UP_RS232_CONTROL_RE_MSK 	\
												| ALT_UP_RS232_CONTROL_WE_MSK 	\
												| ALT_UP_RS232_CONTROL_RI_MSK 	\
												| ALT_UP_RS232_CONTROL_WI_MSK 	\
												| ALT_UP_RS232_CONTROL_WSPACE_MSK)
#endif /*__ALT_UP_RS232_REGS_H__*/	
