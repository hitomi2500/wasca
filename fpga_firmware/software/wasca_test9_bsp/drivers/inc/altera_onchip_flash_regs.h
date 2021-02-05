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

#ifndef __ALTERA_ONCHIP_FLASH_REGS_H__
#define __ALTERA_ONCHIP_FLASH_REGS_H__

#include <io.h>

/*
 * Status Register
*/
#define ALTERA_ONCHIP_FLASH_STATUS_REG                          0
#define ALTERA_ONCHIP_FLASH_STATUS_MSK                          (0x00007FFF)

#define ALTERA_ONCHIP_FLASH_STATUS_BUSY_MSK                     (0x00000003)
#define ALTERA_ONCHIP_FLASH_STATUS_BUSY_IDLE                    (0x00000000)
#define ALTERA_ONCHIP_FLASH_STATUS_BUSY_ERASE                   (0x00000001)
#define ALTERA_ONCHIP_FLASH_STATUS_BUSY_WRITE                   (0x00000002)
#define ALTERA_ONCHIP_FLASH_STATUS_BUSY_READ                    (0x00000003)

#define ALTERA_ONCHIP_FLASH_STATUS_READ_MSK                     (0x00000004)
#define ALTERA_ONCHIP_FLASH_STATUS_READ_PASSED                  (0x00000004)
#define ALTERA_ONCHIP_FLASH_STATUS_READ_FAILED                  (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_WRITE_MSK                    (0x00000008)
#define ALTERA_ONCHIP_FLASH_STATUS_WRITE_PASSED                 (0x00000008)
#define ALTERA_ONCHIP_FLASH_STATUS_WRITE_FAILED                 (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_ERASE_MSK                    (0x00000010)
#define ALTERA_ONCHIP_FLASH_STATUS_ERASE_PASSED                 (0x00000010)
#define ALTERA_ONCHIP_FLASH_STATUS_ERASE_FAILED                 (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR1_MSK                  (0x00000020)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR1_UNAVAILABLE          (0x00000020)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR1_AVAILABLE            (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR2_MSK                  (0x00000040)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR2_UNAVAILABLE          (0x00000040)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR2_AVAILABLE            (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR3_MSK                  (0x00000080)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR3_UNAVAILABLE          (0x00000080)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR3_AVAILABLE            (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR4_MSK                  (0x00000100)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR4_UNAVAILABLE          (0x00000100)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR4_AVAILABLE            (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR5_MSK                  (0x00000200)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR5_UNAVAILABLE          (0x00000200)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR5_AVAILABLE            (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR1_READONLY_MSK         (0x00000400)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR1_READONLY             (0x00000400)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR1_READWRITE            (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR2_READONLY_MSK         (0x00000800)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR2_READONLY             (0x00000800)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR2_READWRITE            (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR3_READONLY_MSK         (0x00001000)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR3_READONLY             (0x00001000)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR3_READWRITE            (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR4_READONLY_MSK         (0x00002000)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR4_READONLY             (0x00002000)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR4_READWRITE            (0x00000000)

#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR5_READONLY_MSK         (0x00004000)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR5_READONLY             (0x00004000)
#define ALTERA_ONCHIP_FLASH_STATUS_SECTOR5_READWRITE            (0x00000000)

#define IOADDR_ALTERA_ONCHIP_FLASH_STATUS(base)                  \
                 __IO_CALC_ADDRESS_NATIVE(base, ALTERA_ONCHIP_FLASH_STATUS_REG)

#define   IORD_ALTERA_ONCHIP_FLASH_STATUS(base)                  \
                                     IORD(base, ALTERA_ONCHIP_FLASH_STATUS_REG)

#define   IOWR_ALTERA_ONCHIP_FLASH_STATUS(base, data)            \
                                     IOWR(base, ALTERA_ONCHIP_FLASH_STATUS_REG, data)


/*
 * Control Register
*/
#define ALTERA_ONCHIP_FLASH_CONTROL_REG                         1
#define ALTERA_ONCHIP_FLASH_CONTROL_MSK                         (0xCFFFFFFF)

#define ALTERA_ONCHIP_FLASH_CONTROL_PAGE_ERASE_MSK              (0x000FFFFF)
#define ALTERA_ONCHIP_FLASH_CONTROL_PAGE_ERASE_NOT_SET          (0x000FFFFF)

#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_MSK            (0x00700000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_SECTOR1        (0x00100000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_SECTOR2        (0x00200000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_SECTOR3        (0x00300000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_SECTOR4        (0x00400000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_SECTOR5        (0x00500000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_NOT_SET        (0x00700000)

#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR1_WRITE_PROTECT_MSK   (0x00800000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR1_WRITE_ENABLE        (0x00000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR1_WRITE_DISABLE       (0x00800000)

#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR2_WRITE_PROTECT_MSK   (0x01000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR2_WRITE_ENABLE        (0x00000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR2_WRITE_DISABLE       (0x01000000)

#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR3_WRITE_PROTECT_MSK   (0x02000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR3_WRITE_ENABLE        (0x00000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR3_WRITE_DISABLE       (0x02000000)

#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR4_WRITE_PROTECT_MSK   (0x04000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR4_WRITE_ENABLE        (0x00000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR4_WRITE_DISABLE       (0x04000000)

#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR5_WRITE_PROTECT_MSK   (0x08000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR5_WRITE_ENABLE        (0x00000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_SECTOR5_WRITE_DISABLE       (0x08000000)

#define ALTERA_ONCHIP_FLASH_CONTROL_ALLSECTOR_WRITE_PROTECT_MSK (0x0F800000)
#define ALTERA_ONCHIP_FLASH_CONTROL_ALLSECTOR_WRITE_ENABLE      (0x00000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_ALLSECTOR_WRITE_DISABLE     (0x0F800000)

#define ALTERA_ONCHIP_FLASH_CONTROL_ERASE_STATE_MSK             (0xC0000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_ERASE_STATE_IDLE            (0x00000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_ERASE_STATE_PENDING         (0x40000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_ERASE_STATE_BUSY            (0x80000000)
#define ALTERA_ONCHIP_FLASH_CONTROL_ERASE_STATE_RSVD            (0xC0000000)

#define IOADDR_ALTERA_ONCHIP_FLASH_CONTROL(base)                  \
                  __IO_CALC_ADDRESS_NATIVE(base, ALTERA_ONCHIP_FLASH_CONTROL_REG)

#define   IORD_ALTERA_ONCHIP_FLASH_CONTROL(base)                  \
                                      IORD(base, ALTERA_ONCHIP_FLASH_CONTROL_REG)

#define   IOWR_ALTERA_ONCHIP_FLASH_CONTROL(base, data)            \
                                      IOWR(base, ALTERA_ONCHIP_FLASH_CONTROL_REG, data)


/*
 * Constant value
*/
#define ALTERA_ONCHIP_FLASH_DATA_ALIGN_SIZE                     (32/8)
/* 0.7 sec time out */
#define ALTERA_ONCHIP_FLASH_STATUS_BIT_POLLING_TIMEOUT_VALUE    700000

/*
 * Functional Macros
*/

/* Enable Write and Erase Operation */
#define ALTERA_ONCHIP_FLASH_ENABLE_WRITE_AND_ERASE_OPERATION(base)              \
    (                                                                           \
        IOWR_ALTERA_ONCHIP_FLASH_CONTROL((base),                                \
            (IORD_ALTERA_ONCHIP_FLASH_CONTROL((base))                           \
            &                                                                   \
                ~(                                                              \
                    ALTERA_ONCHIP_FLASH_CONTROL_ALLSECTOR_WRITE_PROTECT_MSK |   \
                    ALTERA_ONCHIP_FLASH_CONTROL_PAGE_ERASE_MSK |                \
                    ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_MSK                \
                )                                                               \
            )                                                                   \
            |                                                                   \
                (                                                               \
                    ALTERA_ONCHIP_FLASH_CONTROL_ALLSECTOR_WRITE_ENABLE |        \
                    ALTERA_ONCHIP_FLASH_CONTROL_PAGE_ERASE_NOT_SET |            \
                    ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_NOT_SET            \
                )                                                               \
        )                                                                       \
    )

/* Disable Write and Erase Operation */
#define ALTERA_ONCHIP_FLASH_DISABLE_WRITE_AND_ERASE_OPERATION(base)             \
    (                                                                           \
        IOWR_ALTERA_ONCHIP_FLASH_CONTROL((base),                                \
            (IORD_ALTERA_ONCHIP_FLASH_CONTROL((base))                           \
            &                                                                   \
                ~(                                                              \
                    ALTERA_ONCHIP_FLASH_CONTROL_ALLSECTOR_WRITE_PROTECT_MSK |   \
                    ALTERA_ONCHIP_FLASH_CONTROL_PAGE_ERASE_MSK |                \
                    ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_MSK                \
                )                                                               \
            )                                                                   \
            |                                                                   \
                (                                                               \
                    ALTERA_ONCHIP_FLASH_CONTROL_ALLSECTOR_WRITE_DISABLE |       \
                    ALTERA_ONCHIP_FLASH_CONTROL_PAGE_ERASE_NOT_SET |            \
                    ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_NOT_SET            \
                )                                                               \
        )                                                                       \
    )

/* Page Erase Operation */
#define ALTERA_ONCHIP_FLASH_PAGE_ERASE(base, page_erase_block_address)          \
    (                                                                           \
        IOWR_ALTERA_ONCHIP_FLASH_CONTROL((base),                                \
            (IORD_ALTERA_ONCHIP_FLASH_CONTROL((base))                           \
            &                                                                   \
                ~(                                                              \
                    ALTERA_ONCHIP_FLASH_CONTROL_ALLSECTOR_WRITE_PROTECT_MSK |   \
                    ALTERA_ONCHIP_FLASH_CONTROL_PAGE_ERASE_MSK |                \
                    ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_MSK                \
                )                                                               \
            )                                                                   \
            |                                                                   \
                (                                                               \
                    ALTERA_ONCHIP_FLASH_CONTROL_ALLSECTOR_WRITE_ENABLE  |       \
                    (page_erase_block_address) |                                \
                    ALTERA_ONCHIP_FLASH_CONTROL_SECTOR_ERASE_NOT_SET            \
                )                                                               \
        )                                                                       \
    )

#endif /* __ALTERA_ONCHIP_FLASH_REGS_H__ */
