/*
 * system.h - SOPC Builder system and BSP software package information
 *
 * Machine generated for CPU 'nios2_gen2_0' in SOPC Builder design 'wasca'
 * SOPC Builder design path: ../../wasca.sopcinfo
 *
 * Generated: Sun Jul 04 00:07:37 JST 2021
 */

/*
 * DO NOT MODIFY THIS FILE
 *
 * Changing this file will have subtle consequences
 * which will almost certainly lead to a nonfunctioning
 * system. If you do modify this file, be aware that your
 * changes will be overwritten and lost when this file
 * is generated again.
 *
 * DO NOT MODIFY THIS FILE
 */

/*
 * License Agreement
 *
 * Copyright (c) 2008
 * Altera Corporation, San Jose, California, USA.
 * All rights reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This agreement shall be governed in all respects by the laws of the State
 * of California and by the laws of the United States of America.
 */

#ifndef __SYSTEM_H_
#define __SYSTEM_H_

/* Include definitions from linker script generator */
#include "linker.h"


/*
 * CPU configuration
 *
 */

#define ALT_CPU_ARCHITECTURE "altera_nios2_gen2"
#define ALT_CPU_BIG_ENDIAN 0
#define ALT_CPU_BREAK_ADDR 0x00041020
#define ALT_CPU_CPU_ARCH_NIOS2_R1
#define ALT_CPU_CPU_FREQ 116000000u
#define ALT_CPU_CPU_ID_SIZE 1
#define ALT_CPU_CPU_ID_VALUE 0x00000000
#define ALT_CPU_CPU_IMPLEMENTATION "tiny"
#define ALT_CPU_DATA_ADDR_WIDTH 0x1b
#define ALT_CPU_DCACHE_LINE_SIZE 0
#define ALT_CPU_DCACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_DCACHE_SIZE 0
#define ALT_CPU_EXCEPTION_ADDR 0x00003fe0
#define ALT_CPU_FLASH_ACCELERATOR_LINES 0
#define ALT_CPU_FLASH_ACCELERATOR_LINE_SIZE 0
#define ALT_CPU_FLUSHDA_SUPPORTED
#define ALT_CPU_FREQ 116000000
#define ALT_CPU_HARDWARE_DIVIDE_PRESENT 0
#define ALT_CPU_HARDWARE_MULTIPLY_PRESENT 0
#define ALT_CPU_HARDWARE_MULX_PRESENT 0
#define ALT_CPU_HAS_DEBUG_CORE 1
#define ALT_CPU_HAS_DEBUG_STUB
#define ALT_CPU_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define ALT_CPU_HAS_JMPI_INSTRUCTION
#define ALT_CPU_ICACHE_LINE_SIZE 0
#define ALT_CPU_ICACHE_LINE_SIZE_LOG2 0
#define ALT_CPU_ICACHE_SIZE 0
#define ALT_CPU_INST_ADDR_WIDTH 0x14
#define ALT_CPU_NAME "nios2_gen2_0"
#define ALT_CPU_OCI_VERSION 1
#define ALT_CPU_RESET_ADDR 0x00000000


/*
 * CPU configuration (with legacy prefix - don't use these anymore)
 *
 */

#define NIOS2_BIG_ENDIAN 0
#define NIOS2_BREAK_ADDR 0x00041020
#define NIOS2_CPU_ARCH_NIOS2_R1
#define NIOS2_CPU_FREQ 116000000u
#define NIOS2_CPU_ID_SIZE 1
#define NIOS2_CPU_ID_VALUE 0x00000000
#define NIOS2_CPU_IMPLEMENTATION "tiny"
#define NIOS2_DATA_ADDR_WIDTH 0x1b
#define NIOS2_DCACHE_LINE_SIZE 0
#define NIOS2_DCACHE_LINE_SIZE_LOG2 0
#define NIOS2_DCACHE_SIZE 0
#define NIOS2_EXCEPTION_ADDR 0x00003fe0
#define NIOS2_FLASH_ACCELERATOR_LINES 0
#define NIOS2_FLASH_ACCELERATOR_LINE_SIZE 0
#define NIOS2_FLUSHDA_SUPPORTED
#define NIOS2_HARDWARE_DIVIDE_PRESENT 0
#define NIOS2_HARDWARE_MULTIPLY_PRESENT 0
#define NIOS2_HARDWARE_MULX_PRESENT 0
#define NIOS2_HAS_DEBUG_CORE 1
#define NIOS2_HAS_DEBUG_STUB
#define NIOS2_HAS_ILLEGAL_INSTRUCTION_EXCEPTION
#define NIOS2_HAS_JMPI_INSTRUCTION
#define NIOS2_ICACHE_LINE_SIZE 0
#define NIOS2_ICACHE_LINE_SIZE_LOG2 0
#define NIOS2_ICACHE_SIZE 0
#define NIOS2_INST_ADDR_WIDTH 0x14
#define NIOS2_OCI_VERSION 1
#define NIOS2_RESET_ADDR 0x00000000


/*
 * Define for each module class mastered by the CPU
 *
 */

#define __ABUS_AVALON_SDRAM_BRIDGE
#define __ALTERA_AVALON_ONCHIP_MEMORY2
#define __ALTERA_AVALON_PERFORMANCE_COUNTER
#define __ALTERA_AVALON_UART
#define __ALTERA_NIOS2_GEN2
#define __ALTERA_ONCHIP_FLASH
#define __ALTPLL
#define __BUFFERED_SPI
#define __HEARTBEAT


/*
 * System configuration
 *
 */

#define ALT_DEVICE_FAMILY "MAX 10"
#define ALT_ENHANCED_INTERRUPT_API_PRESENT
#define ALT_IRQ_BASE NULL
#define ALT_LOG_PORT "/dev/null"
#define ALT_LOG_PORT_BASE 0x0
#define ALT_LOG_PORT_DEV null
#define ALT_LOG_PORT_TYPE ""
#define ALT_NUM_EXTERNAL_INTERRUPT_CONTROLLERS 0
#define ALT_NUM_INTERNAL_INTERRUPT_CONTROLLERS 1
#define ALT_NUM_INTERRUPT_CONTROLLERS 1
#define ALT_STDERR "/dev/uart_0"
#define ALT_STDERR_BASE 0x410000
#define ALT_STDERR_DEV uart_0
#define ALT_STDERR_IS_UART
#define ALT_STDERR_PRESENT
#define ALT_STDERR_TYPE "altera_avalon_uart"
#define ALT_STDIN "/dev/uart_0"
#define ALT_STDIN_BASE 0x410000
#define ALT_STDIN_DEV uart_0
#define ALT_STDIN_IS_UART
#define ALT_STDIN_PRESENT
#define ALT_STDIN_TYPE "altera_avalon_uart"
#define ALT_STDOUT "/dev/uart_0"
#define ALT_STDOUT_BASE 0x410000
#define ALT_STDOUT_DEV uart_0
#define ALT_STDOUT_IS_UART
#define ALT_STDOUT_PRESENT
#define ALT_STDOUT_TYPE "altera_avalon_uart"
#define ALT_SYSTEM_NAME "wasca"


/*
 * abus_avalon_sdram_bridge_0_avalon_regs configuration
 *
 */

#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_BASE 0x60000
#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_IRQ -1
#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_NAME "/dev/abus_avalon_sdram_bridge_0_avalon_regs"
#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_SPAN 512
#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_REGS_TYPE "abus_avalon_sdram_bridge"
#define ALT_MODULE_CLASS_abus_avalon_sdram_bridge_0_avalon_regs abus_avalon_sdram_bridge


/*
 * abus_avalon_sdram_bridge_0_avalon_sdram configuration
 *
 */

#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_BASE 0x4000000
#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_IRQ -1
#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_NAME "/dev/abus_avalon_sdram_bridge_0_avalon_sdram"
#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_SPAN 67108864
#define ABUS_AVALON_SDRAM_BRIDGE_0_AVALON_SDRAM_TYPE "abus_avalon_sdram_bridge"
#define ALT_MODULE_CLASS_abus_avalon_sdram_bridge_0_avalon_sdram abus_avalon_sdram_bridge


/*
 * altpll_1 configuration
 *
 */

#define ALTPLL_1_BASE 0x42000
#define ALTPLL_1_IRQ -1
#define ALTPLL_1_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ALTPLL_1_NAME "/dev/altpll_1"
#define ALTPLL_1_SPAN 16
#define ALTPLL_1_TYPE "altpll"
#define ALT_MODULE_CLASS_altpll_1 altpll


/*
 * buffered_spi_0 configuration
 *
 */

#define ALT_MODULE_CLASS_buffered_spi_0 buffered_spi
#define BUFFERED_SPI_0_BASE 0x50000
#define BUFFERED_SPI_0_IRQ -1
#define BUFFERED_SPI_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define BUFFERED_SPI_0_NAME "/dev/buffered_spi_0"
#define BUFFERED_SPI_0_SPAN 32768
#define BUFFERED_SPI_0_TYPE "buffered_spi"


/*
 * hal configuration
 *
 */

#define ALT_INCLUDE_INSTRUCTION_RELATED_EXCEPTION_API
#define ALT_MAX_FD 4
#define ALT_SYS_CLK none
#define ALT_TIMESTAMP_CLK none


/*
 * heartbeat_0 configuration
 *
 */

#define ALT_MODULE_CLASS_heartbeat_0 heartbeat
#define HEARTBEAT_0_BASE 0x511000
#define HEARTBEAT_0_IRQ -1
#define HEARTBEAT_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define HEARTBEAT_0_NAME "/dev/heartbeat_0"
#define HEARTBEAT_0_SPAN 512
#define HEARTBEAT_0_TYPE "heartbeat"


/*
 * onchip_flash_0 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_flash_0 altera_onchip_flash
#define ONCHIP_FLASH_0_BASE 0x0
#define ONCHIP_FLASH_0_BYTES_PER_PAGE 2048
#define ONCHIP_FLASH_0_IRQ -1
#define ONCHIP_FLASH_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_FLASH_0_NAME "/dev/onchip_flash_0"
#define ONCHIP_FLASH_0_READ_ONLY_MODE 1
#define ONCHIP_FLASH_0_SECTOR1_ENABLED 1
#define ONCHIP_FLASH_0_SECTOR1_END_ADDR 0x3fff
#define ONCHIP_FLASH_0_SECTOR1_START_ADDR 0
#define ONCHIP_FLASH_0_SECTOR2_ENABLED 1
#define ONCHIP_FLASH_0_SECTOR2_END_ADDR 0x7fff
#define ONCHIP_FLASH_0_SECTOR2_START_ADDR 0x4000
#define ONCHIP_FLASH_0_SECTOR3_ENABLED 1
#define ONCHIP_FLASH_0_SECTOR3_END_ADDR 0x167ff
#define ONCHIP_FLASH_0_SECTOR3_START_ADDR 0x8000
#define ONCHIP_FLASH_0_SECTOR4_ENABLED 0
#define ONCHIP_FLASH_0_SECTOR4_END_ADDR 0xffffffff
#define ONCHIP_FLASH_0_SECTOR4_START_ADDR 0xffffffff
#define ONCHIP_FLASH_0_SECTOR5_ENABLED 0
#define ONCHIP_FLASH_0_SECTOR5_END_ADDR 0xffffffff
#define ONCHIP_FLASH_0_SECTOR5_START_ADDR 0xffffffff
#define ONCHIP_FLASH_0_SPAN 92160
#define ONCHIP_FLASH_0_TYPE "altera_onchip_flash"


/*
 * onchip_memory2_0 configuration
 *
 */

#define ALT_MODULE_CLASS_onchip_memory2_0 altera_avalon_onchip_memory2
#define ONCHIP_MEMORY2_0_ALLOW_IN_SYSTEM_MEMORY_CONTENT_EDITOR 0
#define ONCHIP_MEMORY2_0_ALLOW_MRAM_SIM_CONTENTS_ONLY_FILE 0
#define ONCHIP_MEMORY2_0_BASE 0x80000
#define ONCHIP_MEMORY2_0_CONTENTS_INFO ""
#define ONCHIP_MEMORY2_0_DUAL_PORT 0
#define ONCHIP_MEMORY2_0_GUI_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_INIT_CONTENTS_FILE "wasca_onchip_memory2_0"
#define ONCHIP_MEMORY2_0_INIT_MEM_CONTENT 0
#define ONCHIP_MEMORY2_0_INSTANCE_ID "NONE"
#define ONCHIP_MEMORY2_0_IRQ -1
#define ONCHIP_MEMORY2_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define ONCHIP_MEMORY2_0_NAME "/dev/onchip_memory2_0"
#define ONCHIP_MEMORY2_0_NON_DEFAULT_INIT_FILE_ENABLED 0
#define ONCHIP_MEMORY2_0_RAM_BLOCK_TYPE "AUTO"
#define ONCHIP_MEMORY2_0_READ_DURING_WRITE_MODE "DONT_CARE"
#define ONCHIP_MEMORY2_0_SINGLE_CLOCK_OP 0
#define ONCHIP_MEMORY2_0_SIZE_MULTIPLE 1
#define ONCHIP_MEMORY2_0_SIZE_VALUE 24576
#define ONCHIP_MEMORY2_0_SPAN 24576
#define ONCHIP_MEMORY2_0_TYPE "altera_avalon_onchip_memory2"
#define ONCHIP_MEMORY2_0_WRITABLE 1


/*
 * performance_counter_0 configuration
 *
 */

#define ALT_MODULE_CLASS_performance_counter_0 altera_avalon_performance_counter
#define PERFORMANCE_COUNTER_0_BASE 0x520000
#define PERFORMANCE_COUNTER_0_HOW_MANY_SECTIONS 1
#define PERFORMANCE_COUNTER_0_IRQ -1
#define PERFORMANCE_COUNTER_0_IRQ_INTERRUPT_CONTROLLER_ID -1
#define PERFORMANCE_COUNTER_0_NAME "/dev/performance_counter_0"
#define PERFORMANCE_COUNTER_0_SPAN 32
#define PERFORMANCE_COUNTER_0_TYPE "altera_avalon_performance_counter"


/*
 * uart_0 configuration
 *
 */

#define ALT_MODULE_CLASS_uart_0 altera_avalon_uart
#define UART_0_BASE 0x410000
#define UART_0_BAUD 115200
#define UART_0_DATA_BITS 8
#define UART_0_FIXED_BAUD 0
#define UART_0_FREQ 116000000
#define UART_0_IRQ 0
#define UART_0_IRQ_INTERRUPT_CONTROLLER_ID 0
#define UART_0_NAME "/dev/uart_0"
#define UART_0_PARITY 'N'
#define UART_0_SIM_CHAR_STREAM ""
#define UART_0_SIM_TRUE_BAUD 0
#define UART_0_SPAN 32
#define UART_0_STOP_BITS 1
#define UART_0_SYNC_REG_DEPTH 2
#define UART_0_TYPE "altera_avalon_uart"
#define UART_0_USE_CTS_RTS 0
#define UART_0_USE_EOP_REGISTER 0

#endif /* __SYSTEM_H_ */
