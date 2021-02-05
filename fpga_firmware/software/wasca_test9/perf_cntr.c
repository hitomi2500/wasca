#include "perf_cntr.h"

#include <unistd.h>
#include <fcntl.h>

#include "wasca_defs.h"
#include "log.h"

#ifdef __ALTERA_AVALON_PERFORMANCE_COUNTER

unsigned long wasca_perf_get_usec(alt_u64 elapsed_time)
{
    alt_u64 total_clocks = elapsed_time;
    //unsigned long clk_cnt_u32;

    unsigned long clkhz = alt_get_cpu_freq();
    unsigned long time_usec;

    //clk_cnt_u32 = (unsigned long)total_clocks;

    total_clocks *= 1000*1000;
    time_usec = (unsigned long)(total_clocks / clkhz);

    return time_usec;
}

void wasca_perf_logout(char* name, alt_u64 elapsed_time)
{
#if LOG_ENABLE == 1
    unsigned long time_usec = wasca_perf_get_usec(elapsed_time);

    //logout("PERF[%s]:%u CLK (%u usec)", name, clk_cnt_u32, time_usec);
    logout("PERF[%s]:%u usec", name, time_usec);
#endif // LOG_ENABLE == 1
}

#endif // __ALTERA_AVALON_PERFORMANCE_COUNTER
