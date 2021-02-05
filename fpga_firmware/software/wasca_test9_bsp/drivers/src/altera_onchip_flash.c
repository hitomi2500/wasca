/******************************************************************************
*                                                                             *
* License Agreement                                                           *
*                                                                             *
* Copyright (c) 2014 Altera Corporation, San Jose, California, USA.           *
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
#include <io.h>
#include <string.h>
#include "sys/param.h"
#include "alt_types.h"
#include "sys/alt_debug.h"
#include "sys/alt_cache.h"
#include "altera_onchip_flash.h"
#include "altera_onchip_flash_regs.h"
#include "priv/alt_busy_sleep.h"

ALT_LLIST_HEAD(altera_onchip_flash_list);

/*
    Public API

    Refer to "Using Flash Devices" in the
    Developing Programs Using the Hardware Abstraction Layer chapter
    of the Nios II Software Developer's Handbook.

*/

/**
 * alt_onchip_flash_read
 *
 * reads data from flash.
**/
int alt_onchip_flash_read
(
    alt_flash_dev *flash_info,
    int           offset,
    void          *dest_addr,
    int           length
)
{
    int ret_code = 0;
    alt_onchip_flash_dev* flash = (alt_onchip_flash_dev*)flash_info;

    /* Make sure the input parameters is not outside of this device's range. */
    if ((offset >= flash->dev.length) || ((offset+length) > flash->dev.length)) {
        return -EFAULT;
    }
    
    memcpy(dest_addr, (alt_u8*)flash->dev.base_addr+offset, length);

    if (NULL != flash->csr_base) {
        int read_status = IORD_ALTERA_ONCHIP_FLASH_STATUS(flash->csr_base) & ALTERA_ONCHIP_FLASH_STATUS_READ_MSK;
        if (read_status != ALTERA_ONCHIP_FLASH_STATUS_READ_PASSED) {
            /* Read failed.  Return error.*/
            ret_code = -EIO;
        }
    }
    return ret_code;
}

/**
 * alt_onchip_flash_get_info
 *
 * gets the details of the erase region.
**/
int alt_onchip_flash_get_info
(
    alt_flash_fd *fd,
    flash_region **info,
    int          *number_of_regions
)
{
    int ret_code = 0;

    alt_flash_dev* flash = (alt_flash_dev*)fd;

    if (NULL != number_of_regions)
    {
        /* Pass the number of region to user */
        *number_of_regions = flash->number_of_regions;
    }

    if (!flash->number_of_regions)
    {
        ret_code = -ENOMEM;
    }
    else if (flash->number_of_regions > ALT_MAX_NUMBER_OF_FLASH_REGIONS)
    {
        ret_code = -EFAULT;
    }
    else
    {
        if (NULL != info)
        {
            /* Pass the table of erase blocks to user */
            *info = &flash->region_info[0];
        }
    }

    return ret_code;
}

/**
  This function erases an individual flash erase block.
**/
int alt_onchip_flash_erase_block
(
    alt_flash_dev *flash_info,
    int           block_offset
)
{
    int ret_code = 0;
    alt_onchip_flash_dev *flash = (alt_onchip_flash_dev*)flash_info;
    int page_address;

    /* Make sure the input parameters is not outside of this device's range. */
    if (block_offset >= flash->dev.length) {
        return -EFAULT;
    }

    /* Make sure IP support write and erase operation */
    if ((flash->csr_base == NULL) || (flash->is_read_only)) {
        return -ENODEV;
    }

    /* The block_offset must be page size aligned */
    if ((block_offset & (flash->page_size - 1)) != 0)
    {
        /* The address is not aligned */
        return -EINVAL;
    }

    /* Wait until flash controller idle */
    ret_code = alt_onchip_flash_poll_for_status_to_go_idle(flash);
    if (ret_code != 0)
    {
        return ret_code;
    }

    /* Enable write and erase operation */
    ALTERA_ONCHIP_FLASH_ENABLE_WRITE_AND_ERASE_OPERATION(flash->csr_base);

    /* Calculate Page erase address, it is 32bit word addressing*/
    page_address = block_offset / 4;

    /* Perform Page erase operation */
    ALTERA_ONCHIP_FLASH_PAGE_ERASE(flash->csr_base, page_address);

    /* Wait until flash controller idle */
    ret_code = alt_onchip_flash_poll_for_status_to_go_idle(flash);

    /* Wait until flash controller indicate erase passed */
    ret_code = alt_onchip_flash_poll_for_status_erase_passed(flash);

    /* Disable write and erase operation */
    ALTERA_ONCHIP_FLASH_DISABLE_WRITE_AND_ERASE_OPERATION(flash->csr_base);

    return ret_code;
}

/**
 * alt_onchip_flash_write_block
 *
 * This function writes one block of data to flash.
 * It assume that someone has kindly erased the appropriate sector(s).
 *
 * Note: "block_offset" is the base of the current erase block.
 * "data_offset" is the absolute address (from the 0-base of this
 * device's memory) of the beginning of the write-destination.
 * This device has no need for "block_offset", but it's included for
 * function type compatibility.
**/
int alt_onchip_flash_write_block
(
    alt_flash_dev *flash_info,
    int           block_offset,
    int           data_offset,
    const void    *data,
    int           length
)
{
    int ret_code = 0;
    alt_onchip_flash_dev *flash = (alt_onchip_flash_dev*)flash_info;
    int buffer_offset = 0;
    int length_of_current_write;
    int current_data_offset = data_offset;
    int next_data_offset;
    alt_u32 chunk_of_data;

    /* Make sure the input parameters is not outside of this device's range. */
    if (
        (block_offset >= flash->dev.length) ||
        (data_offset >= flash->dev.length) ||
        (length > (flash->dev.length - data_offset))
    ) {
        return -EFAULT;
    }

    /* Make sure IP support support write and erase operation */
    if ((flash->csr_base == NULL) || (flash->is_read_only != 0)) {
        return -ENODEV;
    }

    /* Wait until flash controller idle */
    ret_code = alt_onchip_flash_poll_for_status_to_go_idle(flash);
    if (ret_code != 0)
    {
        return ret_code;
    }

    /* Enable write and erase operation */
    ALTERA_ONCHIP_FLASH_ENABLE_WRITE_AND_ERASE_OPERATION(flash->csr_base);

    /* Check data length */
    while (length)
    {
        /* Minimum write size to onchip flash is 32 bits of data */
        chunk_of_data = 0xFFFFFFFF;

        /* The start of data_offset must be 4 bytes (32 bits) aligned */
        if ((current_data_offset & (ALTERA_ONCHIP_FLASH_DATA_ALIGN_SIZE - 1)) == 0)
        {
            /* The address is 4-byte aligned here */
            next_data_offset = (current_data_offset + ALTERA_ONCHIP_FLASH_DATA_ALIGN_SIZE) & ~(ALTERA_ONCHIP_FLASH_DATA_ALIGN_SIZE - 1);
            length_of_current_write = MIN(length, next_data_offset - current_data_offset);
            /* Prepare the 4 bytes chunk of data to be written */
            memcpy(&chunk_of_data, &((alt_u8*)data)[buffer_offset], length_of_current_write);
            buffer_offset += length_of_current_write;
            length -= length_of_current_write;
        } else {
            /* Calculate how many padding bytes need to be added before the start of a data offset */
            int padding = current_data_offset & (ALTERA_ONCHIP_FLASH_DATA_ALIGN_SIZE - 1);

            /* Calculate new 4-byte aligned data offset */
            current_data_offset = current_data_offset - padding;
            next_data_offset = (current_data_offset + ALTERA_ONCHIP_FLASH_DATA_ALIGN_SIZE) & ~(ALTERA_ONCHIP_FLASH_DATA_ALIGN_SIZE - 1);
            length_of_current_write = MIN(length + padding, next_data_offset - current_data_offset);
            /* Prepare the 4 bytes chunk of data to be written */
            memcpy((void *)(((int)&chunk_of_data) + (int)padding), &((alt_u8*)data)[buffer_offset], length_of_current_write - padding);
            buffer_offset += length_of_current_write - padding;
            length -= length_of_current_write - padding;
        }

        /* Writing to flash via IO 32 bits at a time */
        IOWR_32DIRECT(flash->dev.base_addr, current_data_offset, chunk_of_data);

        /* Wait until flash controller idle */
        ret_code = alt_onchip_flash_poll_for_status_to_go_idle(flash);
        if (ret_code != 0)
        {
            break;
        }

        /* Wait until flash controller indicate write passed */
        ret_code = alt_onchip_flash_poll_for_status_write_passed(flash);
        if (ret_code != 0)
        {
            break;
        }

        /* Prepare to write next 4 bytes */
        current_data_offset = next_data_offset;
    }

    /* Disable write and erase operation */
    ALTERA_ONCHIP_FLASH_DISABLE_WRITE_AND_ERASE_OPERATION(flash->csr_base);

    return ret_code;
}

/**
 * alt_onchip_flash_write
 *
 * Program the data into the flash at the selected address.
 *
 * The different between this function and alt_onchip_flash_write_block function
 * is that this function (alt_onchip_flash_write) will automatically erase a block as needed
 *
**/
int alt_onchip_flash_write(
    alt_flash_dev *flash_info,
    int           offset,
    const void    *src_addr,
    int           length
)
{
    int         ret_code = 0;
    int         i,j;
    int         data_to_write;
    int         current_offset;
    int         full_length = length;
    int         start_offset = offset;
    alt_onchip_flash_dev* flash = (alt_onchip_flash_dev*)flash_info;

    /* Make sure the input parameters is not outside of this device's range. */
    if ((offset >= flash->dev.length) || (length > (flash->dev.length - offset)))
    {
        return -EFAULT;
    }

    /*
    * First and foremost which sectors are affected?
    */
    for(i=0;i<flash->dev.number_of_regions;i++)
    {
        /* Is it in this erase block region?*/
        if((offset >= flash->dev.region_info[i].offset) &&
            (offset < (flash->dev.region_info[i].offset +
            flash->dev.region_info[i].region_size)))
        {
            current_offset = flash->dev.region_info[i].offset;

            for(j=0;j<flash->dev.region_info[i].number_of_blocks;j++)
            {
                if ((offset >= current_offset ) &&
                    (offset < (current_offset +
                    flash->dev.region_info[i].block_size)))
                {
                    /*
                    * Check if the contents of the block are different
                    * from the data we wish to put there
                    */
                    data_to_write = (current_offset + flash->dev.region_info[i].block_size - offset);
                    data_to_write = MIN(data_to_write, length);
                    if(memcmp(src_addr, (alt_u8*)flash->dev.base_addr+offset, data_to_write))
                    {
                        ret_code = (*flash->dev.erase_block)(&flash->dev, current_offset);

                        if (!ret_code)
                        {
                            ret_code = (*flash->dev.write_block)(
                                                                &flash->dev,
                                                                current_offset,
                                                                offset,
                                                                src_addr,
                                                                data_to_write);
                        }
                    }

                    /* Was this the last block? */
                    if ((length == data_to_write) || ret_code)
                    {
                        goto finished;
                    }

                    length -= data_to_write;
                    offset = current_offset + flash->dev.region_info[i].block_size;
                    src_addr = (alt_u8*)src_addr + data_to_write;
                }
                current_offset += flash->dev.region_info[i].block_size;
            }
        }
    }

finished:
    alt_dcache_flush((alt_u8*)flash->dev.base_addr+start_offset, full_length);
    return ret_code;
}

/**
 * altera_onchip_flash_init
 *
 * alt_sys_init.c will call this function automatically through macro
 *
**/
void altera_onchip_flash_init
(
    alt_onchip_flash_dev *flash
)
{
    /* A region is a sector of the onchip flash */
    int number_of_regions;
    flash_region* region_info;
    int sector1_status = ALTERA_ONCHIP_FLASH_STATUS_SECTOR1_AVAILABLE;
    int sector2_status = ALTERA_ONCHIP_FLASH_STATUS_SECTOR2_AVAILABLE;
    int sector3_status = ALTERA_ONCHIP_FLASH_STATUS_SECTOR3_AVAILABLE;
    int sector4_status = ALTERA_ONCHIP_FLASH_STATUS_SECTOR4_AVAILABLE;
    int sector5_status = ALTERA_ONCHIP_FLASH_STATUS_SECTOR5_AVAILABLE;

    /* Set up flash_region data structures. */
    number_of_regions = 0;
    region_info = &flash->dev.region_info[0];

    if (flash->csr_base != NULL) {
        sector1_status = IORD_ALTERA_ONCHIP_FLASH_STATUS(flash->csr_base) & ALTERA_ONCHIP_FLASH_STATUS_SECTOR1_MSK;
        sector2_status = IORD_ALTERA_ONCHIP_FLASH_STATUS(flash->csr_base) & ALTERA_ONCHIP_FLASH_STATUS_SECTOR2_MSK;
        sector3_status = IORD_ALTERA_ONCHIP_FLASH_STATUS(flash->csr_base) & ALTERA_ONCHIP_FLASH_STATUS_SECTOR3_MSK;
        sector4_status = IORD_ALTERA_ONCHIP_FLASH_STATUS(flash->csr_base) & ALTERA_ONCHIP_FLASH_STATUS_SECTOR4_MSK;
        sector5_status = IORD_ALTERA_ONCHIP_FLASH_STATUS(flash->csr_base) & ALTERA_ONCHIP_FLASH_STATUS_SECTOR5_MSK;
    }

    if ((flash->sector1_enabled == 1) && (sector1_status != ALTERA_ONCHIP_FLASH_STATUS_SECTOR1_UNAVAILABLE)) {

        region_info[number_of_regions].offset = flash->sector1_start_addr;
        region_info[number_of_regions].region_size = flash->sector1_end_addr - flash->sector1_start_addr + 1;
        region_info[number_of_regions].number_of_blocks = flash->dev.region_info[number_of_regions].region_size / flash->page_size;
        region_info[number_of_regions].block_size = flash->page_size;

        number_of_regions++;
    }

    if ((flash->sector2_enabled == 1) && (sector2_status != ALTERA_ONCHIP_FLASH_STATUS_SECTOR2_UNAVAILABLE)) {

        region_info[number_of_regions].offset = flash->sector2_start_addr;
        region_info[number_of_regions].region_size = flash->sector2_end_addr - flash->sector2_start_addr + 1;
        region_info[number_of_regions].number_of_blocks = flash->dev.region_info[number_of_regions].region_size / flash->page_size;
        region_info[number_of_regions].block_size = flash->page_size;

        number_of_regions++;
	}

    if ((flash->sector3_enabled == 1) && (sector3_status != ALTERA_ONCHIP_FLASH_STATUS_SECTOR3_UNAVAILABLE)) {

        region_info[number_of_regions].offset = flash->sector3_start_addr;
        region_info[number_of_regions].region_size = flash->sector3_end_addr - flash->sector3_start_addr + 1;
        region_info[number_of_regions].number_of_blocks = flash->dev.region_info[number_of_regions].region_size / flash->page_size;
        region_info[number_of_regions].block_size = flash->page_size;

        number_of_regions++;
	}

	if ((flash->sector4_enabled == 1) && (sector4_status != ALTERA_ONCHIP_FLASH_STATUS_SECTOR4_UNAVAILABLE)) {

        region_info[number_of_regions].offset = flash->sector4_start_addr;
        region_info[number_of_regions].region_size = flash->sector4_end_addr - flash->sector4_start_addr + 1;
        region_info[number_of_regions].number_of_blocks = flash->dev.region_info[number_of_regions].region_size / flash->page_size;
        region_info[number_of_regions].block_size = flash->page_size;

        number_of_regions++;
	}

    if ((flash->sector5_enabled == 1) && (sector5_status != ALTERA_ONCHIP_FLASH_STATUS_SECTOR5_UNAVAILABLE)) {

        region_info[number_of_regions].offset = flash->sector5_start_addr;
        region_info[number_of_regions].region_size = flash->sector5_end_addr - flash->sector5_start_addr + 1;
        region_info[number_of_regions].number_of_blocks = flash->dev.region_info[number_of_regions].region_size / flash->page_size;
        region_info[number_of_regions].block_size = flash->page_size;

        number_of_regions++;
    }

    /* Update number of regions. */
    flash->dev.number_of_regions = number_of_regions;

    /*
    *  Register this device as a valid flash device type
    */
    alt_flash_device_register(&(flash->dev));
}

/*
	Private API

	Helper functions used by Public API functions.
*/


/**
 * alt_onchip_flash_poll_for_status_to_go_idle
 *
 * This function return non zero value when polling timeout.
**/
int alt_onchip_flash_poll_for_status_to_go_idle
(
    alt_onchip_flash_dev *flash
)
{
    int ret_code = 0;
    int timeout = ALTERA_ONCHIP_FLASH_STATUS_BIT_POLLING_TIMEOUT_VALUE;
    int count_down = ALTERA_ONCHIP_FLASH_STATUS_BIT_POLLING_TIMEOUT_VALUE;

    while (
        (IORD_ALTERA_ONCHIP_FLASH_STATUS(flash->csr_base) &
              ALTERA_ONCHIP_FLASH_STATUS_BUSY_MSK
        ) !=  ALTERA_ONCHIP_FLASH_STATUS_BUSY_IDLE
    ) {
	 
	alt_busy_sleep(1); /* delay 1us */

        /* If timeout value is zero, it will never timeout. */
        if (timeout != 0) {
            count_down--;
            if (count_down == 0) {
                /* Timeout */
                ret_code = -ETIMEDOUT;
                break;
            }
        }
    }

    return ret_code;
}

/**
 * alt_onchip_flash_poll_for_status_erase_passed
 *
 * This function return non zero value when polling timeout.
**/
int alt_onchip_flash_poll_for_status_erase_passed
(
    alt_onchip_flash_dev *flash
)
{
    int ret_code = 0;
    int timeout = ALTERA_ONCHIP_FLASH_STATUS_BIT_POLLING_TIMEOUT_VALUE;
    int count_down = ALTERA_ONCHIP_FLASH_STATUS_BIT_POLLING_TIMEOUT_VALUE;

    while (
        (IORD_ALTERA_ONCHIP_FLASH_STATUS(flash->csr_base) &
              ALTERA_ONCHIP_FLASH_STATUS_ERASE_MSK
        ) !=  ALTERA_ONCHIP_FLASH_STATUS_ERASE_PASSED
    ) {

	alt_busy_sleep(1); /* delay 1us */

        /* If timeout value is zero, it will never timeout. */
        if (timeout != 0) {
            count_down--;
            if (count_down == 0) {
                /* Timeout */
                ret_code = -ETIMEDOUT;
                break;
            }
        }
    }

    return ret_code;
}

/**
 * alt_onchip_flash_poll_for_status_write_passed
 *
 * This function return non zero value when polling timeout.
**/
int alt_onchip_flash_poll_for_status_write_passed
(
    alt_onchip_flash_dev *flash
)
{
    int ret_code = 0;
    int timeout = ALTERA_ONCHIP_FLASH_STATUS_BIT_POLLING_TIMEOUT_VALUE;
    int count_down = ALTERA_ONCHIP_FLASH_STATUS_BIT_POLLING_TIMEOUT_VALUE;

    while (
        (IORD_ALTERA_ONCHIP_FLASH_STATUS(flash->csr_base) &
              ALTERA_ONCHIP_FLASH_STATUS_WRITE_MSK
        ) !=  ALTERA_ONCHIP_FLASH_STATUS_WRITE_PASSED
    ) {

	alt_busy_sleep(1); /* delay 1us */

        /* If timeout value is zero, it will never timeout. */
        if (timeout != 0) {
            count_down--;
            if (count_down == 0) {
                /* Timeout */
                ret_code = -ETIMEDOUT;
                break;
            }
        }
    }

    return ret_code;
}

