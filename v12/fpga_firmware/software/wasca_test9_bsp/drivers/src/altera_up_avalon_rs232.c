/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2007 Altera Corporation, San Jose, California, USA.           *
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
* Altera does not recommend, suggest or require that this reference design    *
* file be used in conjunction or combination with any other product.          *
*                                                                             *
******************************************************************************/

#include <errno.h>

#include <priv/alt_file.h>

#include "altera_up_avalon_rs232.h"
#include "altera_up_avalon_rs232_regs.h"


void alt_up_rs232_enable_read_interrupt(alt_up_rs232_dev *rs232)
{
	alt_u32 ctrl_reg;
	ctrl_reg = IORD_ALT_UP_RS232_CONTROL(rs232->base); 
	// set RE to 1 while maintaining other bits the same
	ctrl_reg |= ALT_UP_RS232_CONTROL_RE_MSK;
	IOWR_ALT_UP_RS232_CONTROL(rs232->base, ctrl_reg);
}

void alt_up_rs232_disable_read_interrupt(alt_up_rs232_dev *rs232)
{
	alt_u32 ctrl_reg;
	ctrl_reg = IORD_ALT_UP_RS232_CONTROL(rs232->base); 
	// set RE to 0 while maintaining other bits the same
	ctrl_reg &= ~ALT_UP_RS232_CONTROL_RE_MSK;
	IOWR_ALT_UP_RS232_CONTROL(rs232->base, ctrl_reg);
}

unsigned alt_up_rs232_get_used_space_in_read_FIFO(alt_up_rs232_dev *rs232)
{
	alt_u16 ravail = 0;
	// we can only read the 16 bits for RAVAIL --- a read of DATA will discard the data
//	ravail = IORD_16DIRECT(IOADDR_ALT_UP_RS232_DATA(rs232->base), 2); 
	ravail = IORD_ALT_UP_RS232_RAVAIL(rs232->base); 
//	return ravail;
	return (ravail & ALT_UP_RS232_RAVAIL_MSK) >> ALT_UP_RS232_RAVAIL_OFST;
}

unsigned alt_up_rs232_get_available_space_in_write_FIFO(alt_up_rs232_dev *rs232)
{
	alt_u32 ctrl_reg;
	ctrl_reg = IORD_ALT_UP_RS232_CONTROL(rs232->base); 
	return (ctrl_reg & ALT_UP_RS232_CONTROL_WSPACE_MSK) >> ALT_UP_RS232_CONTROL_WSPACE_OFST;
}

int alt_up_rs232_check_parity(alt_u32 data_reg)
{
	unsigned parity_error = (data_reg & ALT_UP_RS232_DATA_PE_MSK) >> ALT_UP_RS232_DATA_PE_OFST;
	return (parity_error ? -1 : 0);
}

int alt_up_rs232_write_data(alt_up_rs232_dev *rs232, alt_u8 data)
{
	/*alt_u32 data_reg;
	data_reg = IORD_ALT_UP_RS232_DATA(rs232->base);*/
    
	// we can write directly without thinking about other bit fields for this
	// case ONLY, because only DATA field of the data register is writable
	IOWR_ALT_UP_RS232_DATA(rs232->base, (data>>ALT_UP_RS232_DATA_DATA_OFST) & ALT_UP_RS232_DATA_DATA_MSK);
	return 0;
}

int alt_up_rs232_read_data(alt_up_rs232_dev *rs232, alt_u8 *data, alt_u8 *parity_error)
{
	alt_u32 data_reg;
	data_reg = IORD_ALT_UP_RS232_DATA(rs232->base);
	*data = (data_reg & ALT_UP_RS232_DATA_DATA_MSK) >> ALT_UP_RS232_DATA_DATA_OFST;
	*parity_error = alt_up_rs232_check_parity(data_reg);
	return (((data_reg & ALT_UP_RS232_DATA_RVALID_MSK) >> ALT_UP_RS232_DATA_RVALID_OFST) - 1);
}

int alt_up_rs232_read_fd (alt_fd* fd, char* ptr, int len)
{
	alt_up_rs232_dev *rs232 = (alt_up_rs232_dev*)fd->dev;
	int count = 0;
	alt_u8 parity_error;
	while(len--)
	{
		if (alt_up_rs232_read_data(rs232, (alt_u8 *)ptr++, &parity_error)==0)
			count++;
		else
			break;
	}
	return count;
}

int alt_up_rs232_write_fd (alt_fd* fd, const char* ptr, int len)
{
	alt_up_rs232_dev *rs232 = (alt_up_rs232_dev*)fd->dev;
	int count = 0;
	while(len--)
	{
		if (alt_up_rs232_write_data(rs232, *ptr)==0)
		{
			count++;
			ptr++;
		}
		else
			break;
	}
	return count;
}

alt_up_rs232_dev* alt_up_rs232_open_dev(const char* name)
{
  // find the device from the device list 
  // (see altera_hal/HAL/inc/priv/alt_file.h 
  // and altera_hal/HAL/src/alt_find_dev.c 
  // for details)
  alt_up_rs232_dev *dev = (alt_up_rs232_dev*)alt_find_dev(name, &alt_dev_list);

  return dev;
}

