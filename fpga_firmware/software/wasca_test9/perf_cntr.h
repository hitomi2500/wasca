#ifndef _WL_PERF_CNTR_H_
#define _WL_PERF_CNTR_H_

#include <sys/alt_stdio.h>
#include <string.h>
#include <system.h>
#include <altera_avalon_pio_regs.h>

#include <altera_avalon_performance_counter.h>


/*
 * ------------------------------------------
 * - Performance counter stuff --------------
 * ------------------------------------------
 */

#ifdef __ALTERA_AVALON_PERFORMANCE_COUNTER

#define WASCA_PERF_START_MEASURE() PERF_RESET(PERFORMANCE_COUNTER_0_BASE); PERF_START_MEASURING(PERFORMANCE_COUNTER_0_BASE)
#define WASCA_PERF_STOP_MEASURE()  PERF_STOP_MEASURING(PERFORMANCE_COUNTER_0_BASE)
#define WASCA_PERF_GET_TIME()      perf_get_total_time((void*)PERFORMANCE_COUNTER_0_BASE)

unsigned long wasca_perf_get_usec(alt_u64 elapsed_time);

void wasca_perf_logout(char* name, alt_u64 elapsed_time);

#else // !__ALTERA_AVALON_PERFORMANCE_COUNTER

#define WASCA_PERF_START_MEASURE()
#define WASCA_PERF_STOP_MEASURE()
#define WASCA_PERF_GET_TIME() 0

#define wasca_perf_get_usec(_ELAPSED_TIME_) 0

#define wasca_perf_logout(_NAME_, _ELAPSED_TIME_)

#endif // !__ALTERA_AVALON_PERFORMANCE_COUNTER

#endif // _WL_PERF_CNTR_H_
