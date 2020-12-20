/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2006 Altera Corporation, San Jose, California, USA.           *
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

#include <errno.h>

#include <priv/alt_file.h>

#include "altera_up_avalon_audio.h"
#include "altera_up_avalon_audio_regs.h"

///////////////////////////////////////////////////////////////////////////
// Direct functions
alt_up_audio_dev* alt_up_audio_open_dev(const char* name)
{
  // find the device from the device list 
  // (see altera_hal/HAL/inc/priv/alt_file.h 
  // and altera_hal/HAL/src/alt_find_dev.c 
  // for details)
  alt_up_audio_dev *dev = (alt_up_audio_dev*)alt_find_dev(name, &alt_dev_list);
  return dev;
}

void alt_up_audio_enable_read_interrupt(alt_up_audio_dev *audio)
{
	unsigned int ctrl_reg;
	ctrl_reg = IORD_ALT_UP_AUDIO_CONTROL(audio->base); 
	// set RE to 1 while maintaining other bits the same
	ctrl_reg |= ALT_UP_AUDIO_CONTROL_RE_MSK;
	IOWR_ALT_UP_AUDIO_CONTROL(audio->base, ctrl_reg);
}

void alt_up_audio_disable_read_interrupt(alt_up_audio_dev *audio)
{
	unsigned int ctrl_reg;
	ctrl_reg = IORD_ALT_UP_AUDIO_CONTROL(audio->base); 
	// set RE to 0 while maintaining other bits the same
	ctrl_reg &= ~ALT_UP_AUDIO_CONTROL_RE_MSK;
	IOWR_ALT_UP_AUDIO_CONTROL(audio->base, ctrl_reg);
}

void alt_up_audio_enable_write_interrupt(alt_up_audio_dev *audio)
{
	unsigned int ctrl_reg;
	ctrl_reg = IORD_ALT_UP_AUDIO_CONTROL(audio->base); 
	// set WE to 1 while maintaining other bits the same
	ctrl_reg |= ALT_UP_AUDIO_CONTROL_WE_MSK;
	IOWR_ALT_UP_AUDIO_CONTROL(audio->base, ctrl_reg);
}

void alt_up_audio_disable_write_interrupt(alt_up_audio_dev *audio)
{
	unsigned int ctrl_reg;
	ctrl_reg = IORD_ALT_UP_AUDIO_CONTROL(audio->base); 
	// set WE to 0 while maintaining other bits the same
	ctrl_reg &= ~ALT_UP_AUDIO_CONTROL_WE_MSK;
	IOWR_ALT_UP_AUDIO_CONTROL(audio->base, ctrl_reg);
}

int alt_up_audio_read_interrupt_pending(alt_up_audio_dev *audio)
{
	unsigned int ctrl_reg;
	ctrl_reg = IORD_ALT_UP_AUDIO_CONTROL(audio->base); 
	// return 1 if RI is set to 1
	return ( (ctrl_reg & ALT_UP_AUDIO_CONTROL_RI_MSK) ? 1 : 0 );
}

int alt_up_audio_write_interrupt_pending(alt_up_audio_dev *audio)
{
	unsigned int ctrl_reg;
	ctrl_reg = IORD_ALT_UP_AUDIO_CONTROL(audio->base); 
	// return the WI value
	return ( (ctrl_reg & ALT_UP_AUDIO_CONTROL_WI_MSK) ? 1 : 0 );
}

void alt_up_audio_reset_audio_core(alt_up_audio_dev *audio)
{
	unsigned int ctrl_reg;
	ctrl_reg = IORD_ALT_UP_AUDIO_CONTROL(audio->base); 
	// set CR and CW to 1 while maintaining other bits the same
	ctrl_reg |= ALT_UP_AUDIO_CONTROL_CR_MSK;
	ctrl_reg |= ALT_UP_AUDIO_CONTROL_CW_MSK;
	IOWR_ALT_UP_AUDIO_CONTROL(audio->base, ctrl_reg);
	// set CR and CW to 0 while maintaining other bits the same
	ctrl_reg &= ~ALT_UP_AUDIO_CONTROL_CR_MSK;
	ctrl_reg &= ~ALT_UP_AUDIO_CONTROL_CW_MSK;
	IOWR_ALT_UP_AUDIO_CONTROL(audio->base, ctrl_reg);
}

/* Provides number of words of data available in the incoming FIFO: RALC or RARC */
unsigned int alt_up_audio_read_fifo_avail(alt_up_audio_dev *audio, int channel)
{
	unsigned int fifospace;
	// read the whole fifospace register
	fifospace = IORD_ALT_UP_AUDIO_FIFOSPACE(audio->base);
	// extract the part for proper Channel Read Space
	fifospace = (channel == ALT_UP_AUDIO_LEFT) ? 
		(fifospace & ALT_UP_AUDIO_FIFOSPACE_RALC_MSK) >> ALT_UP_AUDIO_FIFOSPACE_RALC_OFST :
		(fifospace & ALT_UP_AUDIO_FIFOSPACE_RARC_MSK) >> ALT_UP_AUDIO_FIFOSPACE_RARC_OFST;
	return (fifospace);
}

/* Checks if the read FIFO for the right channel has at least BUF_THRESHOLD data words 
 * available. If it doesn't, then just returns 0. If it does, then data is read from the
 * FIFO up to a maximum of len words, and stored into buf.
 */
unsigned int alt_up_audio_record_r(alt_up_audio_dev *audio, unsigned int *buf, int len)
{
	unsigned int data_words = alt_up_audio_read_fifo_avail (audio, ALT_UP_AUDIO_RIGHT);
	if (data_words <= BUF_THRESHOLD)
		return 0;
	else
		return (alt_up_audio_read_fifo(audio, buf, len, ALT_UP_AUDIO_RIGHT));
}

/* Checks if the read FIFO for the left channel has at least BUF_THRESHOLD data words 
 * available. If it doesn't, then just returns 0. If it does, then data is read from the
 * FIFO up to a maximum of len words, and stored into buf.
 */
unsigned int alt_up_audio_record_l(alt_up_audio_dev *audio, unsigned int *buf, int len)
{
	unsigned int data_words = alt_up_audio_read_fifo_avail (audio, ALT_UP_AUDIO_LEFT);
	if (data_words <= BUF_THRESHOLD)
		return 0;
	else
		return (alt_up_audio_read_fifo(audio, buf, len, ALT_UP_AUDIO_LEFT));
}

/* Provides the amount of empty space available in the outgoing FIFO: WSLC or WSRC */
unsigned int alt_up_audio_write_fifo_space(alt_up_audio_dev *audio, int channel)
{
	unsigned int fifospace;
	// read the whole fifospace register
	fifospace = IORD_ALT_UP_AUDIO_FIFOSPACE(audio->base);
	// extract the part for proper Channel Read Space
	fifospace = (channel == ALT_UP_AUDIO_LEFT) ? 
		(fifospace & ALT_UP_AUDIO_FIFOSPACE_WSLC_MSK) >> ALT_UP_AUDIO_FIFOSPACE_WSLC_OFST :
		(fifospace & ALT_UP_AUDIO_FIFOSPACE_WSRC_MSK) >> ALT_UP_AUDIO_FIFOSPACE_WSRC_OFST;
	return (fifospace);
}

/* Checks if the write FIFO for the right channel has at least BUF_THRESHOLD space available.
 * If it doesn't, then just returns 0. If it does, then data from buf is written into the 
 * FIFO, up to a maximum of len words.
 */
unsigned int alt_up_audio_play_r(alt_up_audio_dev *audio, unsigned int *buf, int len)
{
	unsigned int space = alt_up_audio_write_fifo_space (audio, ALT_UP_AUDIO_RIGHT);
	if (space <= BUF_THRESHOLD)
		return 0;
	else
		return (alt_up_audio_write_fifo(audio, buf, len, ALT_UP_AUDIO_RIGHT));
}

/* Checks if the write FIFO for the left channel has at least BUF_THRESHOLD space available.
 * If it doesn't, then just returns 0. If it does, then data from buf is written into the 
 * FIFO, up to a maximum of len words.
 */
unsigned int alt_up_audio_play_l(alt_up_audio_dev *audio, unsigned int *buf, int len)
{
	unsigned int space = alt_up_audio_write_fifo_space (audio, ALT_UP_AUDIO_LEFT);
	if (space <= BUF_THRESHOLD)
		return 0;
	else
		return (alt_up_audio_write_fifo(audio, buf, len, ALT_UP_AUDIO_LEFT));
}

int alt_up_audio_read_fifo(alt_up_audio_dev *audio, unsigned int *buf, int len, int channel)
{
	unsigned int fifospace;
	int count = 0;
	while ( count < len ) 
	{
		// read the whole fifospace register
		fifospace = IORD_ALT_UP_AUDIO_FIFOSPACE(audio->base);
		// extract the part for proper Channel Read Space
		fifospace = (channel == ALT_UP_AUDIO_LEFT) ? 
			(fifospace & ALT_UP_AUDIO_FIFOSPACE_RALC_MSK) >> ALT_UP_AUDIO_FIFOSPACE_RALC_OFST 
			:
			(fifospace & ALT_UP_AUDIO_FIFOSPACE_RARC_MSK) >> ALT_UP_AUDIO_FIFOSPACE_RARC_OFST;
		if (fifospace > 0) 
		{
			buf[count] = (channel == ALT_UP_AUDIO_LEFT) ? 
				IORD_ALT_UP_AUDIO_LEFTDATA(audio->base) :
				IORD_ALT_UP_AUDIO_RIGHTDATA(audio->base);
			count ++;
		}
		else
		{
			// no more data to read
			break;
		}
	}
	return count;
}

int alt_up_audio_write_fifo(alt_up_audio_dev *audio, unsigned int *buf, int len, int channel)
{
	unsigned int fifospace;
	int count = 0;
	while ( count < len ) 
	{
		// read the whole fifospace register
		fifospace = IORD_ALT_UP_AUDIO_FIFOSPACE(audio->base);
		// extract the part for Left Channel Write Space 
		fifospace = (channel == ALT_UP_AUDIO_LEFT) ? 
			(fifospace & ALT_UP_AUDIO_FIFOSPACE_WSLC_MSK) >> ALT_UP_AUDIO_FIFOSPACE_WSLC_OFST :
			(fifospace & ALT_UP_AUDIO_FIFOSPACE_WSRC_MSK) >> ALT_UP_AUDIO_FIFOSPACE_WSRC_OFST;
		if (fifospace > 0) 
		{
			if (channel == ALT_UP_AUDIO_LEFT) 
				IOWR_ALT_UP_AUDIO_LEFTDATA(audio->base, buf[count++]);
			else
				IOWR_ALT_UP_AUDIO_RIGHTDATA(audio->base, buf[count++]);
		}
		else
		{
			// no more space to write
			break;
		}
	}
	return count;
}

unsigned int alt_up_audio_read_fifo_head(alt_up_audio_dev *audio, int channel)
{
	return ( (channel == ALT_UP_AUDIO_LEFT) ?  IORD_ALT_UP_AUDIO_LEFTDATA(audio->base) :
				IORD_ALT_UP_AUDIO_RIGHTDATA(audio->base) );
}

void alt_up_audio_write_fifo_head(alt_up_audio_dev *audio, unsigned int data, int channel)
{
	if (channel == ALT_UP_AUDIO_LEFT) 
		IOWR_ALT_UP_AUDIO_LEFTDATA(audio->base, data);
	else
		IOWR_ALT_UP_AUDIO_RIGHTDATA(audio->base, data);
}

