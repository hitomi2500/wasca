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

#ifndef __ALTERA_UP_AVALON_RS232_H__
#define __ALTERA_UP_AVALON_RS232_H__

#include <stddef.h>
#include <alt_types.h>
#include <sys/alt_dev.h>

#ifdef __cplusplus
extern "C"
{
#endif /* __cplusplus */

/*
 * Device structure definition. Each instance of the driver uses one
 * of these structures to hold its associated state.
 */
typedef struct alt_up_rs232_dev {
	/// @brief character mode device structure 
	/// @sa Developing Device Drivers for the HAL in Nios II Software Developer's Handbook
	alt_dev dev;
	/// @brief the base address of the device
	unsigned int base;
} alt_up_rs232_dev;


//////////////////////////////////////////////////////////////////////////
// HAL system functions

/**
 * @brief Enable the read interrupts for the RS232 UART core.
 *
 * @param rs232 -- the RS232 device structure
 **/
void alt_up_rs232_enable_read_interrupt(alt_up_rs232_dev *rs232);

/**
 * @brief Disable the read interrupts for the RS232 UART core.
 *
 * @param rs232 -- the RS232 device structure
 *
 **/
void alt_up_rs232_disable_read_interrupt(alt_up_rs232_dev *rs232);

/**
 * @brief Check whether the DATA field has a parity error.
 *
 * @param data_reg -- the date register
 *
 * @return 0 for no errors, \f$-1\f$ for parity error.
 **/
int alt_up_rs232_check_parity(alt_u32 data_reg);

/**
 * @brief Gets the number of data words remaining in the read FIFO.
 *
 * @param rs232 -- the RS232 device structure
 *
 * @return The number of data words remaining.
 **/
unsigned alt_up_rs232_get_used_space_in_read_FIFO(alt_up_rs232_dev *rs232);

/**
 * @brief Gets the amount of available space remaining in the write FIFO.
 *
 * @param rs232 -- the RS232 device structure
 *
 * @return The amount of available space remaining.
 **/
unsigned alt_up_rs232_get_available_space_in_write_FIFO(alt_up_rs232_dev *rs232);

/**
 * @brief Write data to the RS232 UART core.
 *
 * @param rs232 -- the RS232 device structure
 * @param data  -- the character to be transferred to the RS232 UART Core.
 *
 * @note User should ensure the write FIFO is not full before writing, otherwise the character is lost.
 *
 * @return 0 for success or \f$-1\f$ on error.
 **/
int alt_up_rs232_write_data(alt_up_rs232_dev *rs232, alt_u8 data);

/**
 * @brief Read data from the RS232 UART core.
 *
 * @param rs232  -- the RS232 device structure
 * @param data   -- pointer to the memory where the character read from the RS232 UART core should be stored.
 * @param parity_error -- pointer to the memory where the parity error should be stored.
 *
 * @return 0 for success or \f$-1\f$ on error.
 *
 * @note This function will clear the DATA field of the data register after reading and it
 * uses the \c alt_up_rs232_check_parity function to check the parity for the
 * DATA field.
 **/
int alt_up_rs232_read_data(alt_up_rs232_dev *rs232, alt_u8 *data, alt_u8 *parity_error);

//////////////////////////////////////////////////////////////////////////
// file-like operation functions
int alt_up_rs232_read_fd (alt_fd* fd, char* ptr, int len);
int alt_up_rs232_write_fd (alt_fd* fd, const char* ptr, int len);

//////////////////////////////////////////////////////////////////////////
// direct operation functions

/**
 * @brief Open the RS232 device according to device name 
 *
 * @param name -- the device name in SOPC Builder
 *
 * @return the \c alt_up_rs232_dev device structure
 **/
alt_up_rs232_dev* alt_up_rs232_open_dev(const char* name);

/*
 * Macros used by alt_sys_init 
 */
#define ALTERA_UP_AVALON_RS232_INSTANCE(name, device)	\
  static alt_up_rs232_dev device =		\
  {                                                 	\
    {                                               	\
      ALT_LLIST_ENTRY,                              	\
      name##_NAME,                                  	\
      NULL , /* open */									\
      NULL , /* close */								\
      alt_up_rs232_read_fd , /* read */					\
      alt_up_rs232_write_fd , /* write */				\
      NULL , /* lseek */								\
      NULL , /* fstat */								\
      NULL , /* ioctl */								\
    },                                              	\
    name##_BASE,                                		\
  }

#define ALTERA_UP_AVALON_RS232_INIT(name, device)  \
  {															\
	/* make the device available to the system */			\
    alt_dev_reg(&device.dev);								\
  }



#ifdef __cplusplus
}
#endif /* __cplusplus */

#endif /* __ALTERA_UP_AVALON_RS232_H__ */


