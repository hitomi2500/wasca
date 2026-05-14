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


#include "altera_avalon_performance_counter.h"
#include "system.h"

alt_u64 perf_get_section_time (void* hw_base_address, int which_section)
{
  alt_u32 lo;
  alt_u32 hi;
  alt_u64 result = 0;

  PERF_STOP_MEASURING(hw_base_address);
  lo = IORD(hw_base_address, ( which_section*4   ));
  hi = IORD(hw_base_address, ((which_section*4)+1));

  result = ((alt_u64)(((alt_u64) hi) << ((alt_u64)32))) | 
           ((alt_u64)(((alt_u64) lo)                 ))  ;
  return result;
}

alt_u64 perf_get_total_time   (void* hw_base_address)
{
  return perf_get_section_time (hw_base_address, 0);
}

alt_u32 perf_get_num_starts   (void* hw_base_address, int which_section)
{
  return IORD(hw_base_address, ((which_section*4)+2));
}

/*
 * This is a hack to allow a program to get the hardware base address of the
 * performance counter peripheral.  It only works if the name of the
 * performance counter peripheral in SOPC Builder is "peripheral_counter_0".
 * If is named something else, it returns a zero pointer.
 *
 * This should probably be replaced with a routine that works independent of
 * the name.  The name should be provided on the system library bind page
 * in Nios II IDE just like is done for the system clock timer and
 * timestamp timer.
 */
void* 
alt_get_performance_counter_base()
{
#ifdef PERFORMANCE_COUNTER_0_BASE
    return (void*)PERFORMANCE_COUNTER_0_BASE;
#else
    return (void*)0;
#endif
}

/*
 * This returns the CPU frequency in units of Hz.
 * If the performance counter peripheral is in a different time domain,
 * this won't necessarily be the same frequency of the CPU.
 */
alt_u32 
alt_get_cpu_freq()
{
    return ALT_CPU_FREQ;
}
