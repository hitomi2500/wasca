/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2003 Altera Corporation, San Jose, California, USA.           *
* All rights reserved.                                                        *
*                                                                             *
* Permission is hereby granted, free of charge, to any person obtaining a     *
* copy of this software and associated documentation files (the "Software"),  *
* to deal in the Software without restriction, including without limitation   *
* the rights to use, copy, modify, merge, publish, distribute, sublicense,    *
* and/or sell copies of the Software, and to permit persons to whom the       *
* Software is furnished to do so, subject to the following conditions:        *
*                                                                             *
* The above copyright notice and this permission notice shall be included in  *
* all copies or substantial portions of the Software.                         *
*                                                                             *
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR  *
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,    *
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE *
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER      *
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING     *
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER         *
* DEALINGS IN THE SOFTWARE.                                                   *
*                                                                             *
* This agreement shall be governed in all respects by the laws of the State   *
* of California and by the laws of the United States of America.              *
*                                                                             *
******************************************************************************/

#ifndef __ALT_UP_AUDIO_REGS_H__
#define __ALT_UP_AUDIO_REGS_H__
#include <io.h>
#include <alt_types.h>

#define IOWR_ALT_UP_AUDIO_ADDR(base, addr, data)  \
        IOWR(base, addr, data)
/*
 * Control Register 
 */
#define ALT_UP_AUDIO_CONTROL_REG               0

#define IOADDR_ALT_UP_AUDIO_CONTROL(base)      \
        __IO_CALC_ADDRESS_NATIVE(base, ALT_UP_AUDIO_CONTROL_REG)
#define IORD_ALT_UP_AUDIO_CONTROL(base)        \
        IORD(base, ALT_UP_AUDIO_CONTROL_REG)
#define IOWR_ALT_UP_AUDIO_CONTROL(base, data)  \
        IOWR(base, ALT_UP_AUDIO_CONTROL_REG, data)

#define ALT_UP_AUDIO_CONTROL_RE_MSK				(0x00000001)
#define ALT_UP_AUDIO_CONTROL_RE_OFST			(0)
#define ALT_UP_AUDIO_CONTROL_WE_MSK				(0x00000002)
#define ALT_UP_AUDIO_CONTROL_WE_OFST			(1)
#define ALT_UP_AUDIO_CONTROL_CR_MSK				(0x00000004)
#define ALT_UP_AUDIO_CONTROL_CR_OFST				(2)
#define ALT_UP_AUDIO_CONTROL_CW_MSK				(0x00000008)
#define ALT_UP_AUDIO_CONTROL_CW_OFST				(3)
#define ALT_UP_AUDIO_CONTROL_RI_MSK				(0x00000100)
#define ALT_UP_AUDIO_CONTROL_RI_OFST			(8)
#define ALT_UP_AUDIO_CONTROL_WI_MSK				(0x00000200)
#define ALT_UP_AUDIO_CONTROL_WI_OFST			(9)

#define ALT_UP_AUDIO_CONTROL_VALID_MSK		(ALT_UP_AUDIO_CONTROL_RE_MSK 	\
											| ALT_UP_AUDIO_CONTROL_WE_MSK 	\
											| ALT_UP_AUDIO_CONTROL_CR_MSK 	\
											| ALT_UP_AUDIO_CONTROL_CW_MSK 	\
											| ALT_UP_AUDIO_CONTROL_RI_MSK 	\
											| ALT_UP_AUDIO_CONTROL_WI_MSK )
/*
 * Fifospace Register 
 */
#define ALT_UP_AUDIO_FIFOSPACE_REG               1

#define IOADDR_ALT_UP_AUDIO_FIFOSPACE(base)      \
        __IO_CALC_ADDRESS_NATIVE(base, ALT_UP_AUDIO_FIFOSPACE_REG)
#define IORD_ALT_UP_AUDIO_FIFOSPACE(base)        \
        IORD(base, ALT_UP_AUDIO_FIFOSPACE_REG)
// this register is read only

#define ALT_UP_AUDIO_FIFOSPACE_RARC_MSK			(0x000000FF)
#define ALT_UP_AUDIO_FIFOSPACE_RARC_OFST		(0)
#define ALT_UP_AUDIO_FIFOSPACE_RALC_MSK			(0x0000FF00)
#define ALT_UP_AUDIO_FIFOSPACE_RALC_OFST		(8)

#define ALT_UP_AUDIO_FIFOSPACE_WSRC_MSK			(0x00FF0000)
#define ALT_UP_AUDIO_FIFOSPACE_WSRC_OFST		(16)
#define ALT_UP_AUDIO_FIFOSPACE_WSLC_MSK			(0xFF000000)
#define ALT_UP_AUDIO_FIFOSPACE_WSLC_OFST		(24)

#define ALT_UP_AUDIO_FIFOSPACE_VALID_MSK		(ALT_UP_AUDIO_FIFOSPACE_RARC_MSK 	\
												| ALT_UP_AUDIO_FIFOSPACE_RALC_MSK 	\
												| ALT_UP_AUDIO_FIFOSPACE_WSRC_MSK 	\
												| ALT_UP_AUDIO_FIFOSPACE_WSLC_MSK)

/*
 * Leftdata Register 
 */
#define ALT_UP_AUDIO_LEFTDATA_REG               2

#define IOADDR_ALT_UP_AUDIO_LEFTDATA(base)      \
        __IO_CALC_ADDRESS_NATIVE(base, ALT_UP_AUDIO_LEFTDATA_REG)
#define IORD_ALT_UP_AUDIO_LEFTDATA(base)        \
        IORD(base, ALT_UP_AUDIO_LEFTDATA_REG)
#define IOWR_ALT_UP_AUDIO_LEFTDATA(base, data)  \
        IOWR(base, ALT_UP_AUDIO_LEFTDATA_REG, data)

/*
 * Rightdata Register 
 */
#define ALT_UP_AUDIO_RIGHTDATA_REG               3

#define IOADDR_ALT_UP_AUDIO_RIGHTDATA(base)      \
        __IO_CALC_ADDRESS_NATIVE(base, ALT_UP_AUDIO_RIGHTDATA_REG)
#define IORD_ALT_UP_AUDIO_RIGHTDATA(base)        \
        IORD(base, ALT_UP_AUDIO_RIGHTDATA_REG)
#define IOWR_ALT_UP_AUDIO_RIGHTDATA(base, data)  \
        IOWR(base, ALT_UP_AUDIO_RIGHTDATA_REG, data)

#endif /*__ALT_UP_AUDIO_REGS_H__*/
