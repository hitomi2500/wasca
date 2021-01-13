
#include "altera_avalon_performance_counter.h"
#include <stdarg.h>
#include <stdio.h>

/****************************************************************

   Print a formatted report summarizing performance-counter activity.  
   
   The report is printed to STDOUT.  At-present, there is no way
   to choose another stream or print to a string.

   You should do this after you call PERF_STOP_MEASURING--but you'll
   be glad to know this routine calls PERF_STOP_MEASURING inside,
   defensively

****************************************************************/
  

#ifndef SMALL_C_LIB 
int perf_print_formatted_report (void* perf_base, 
                                 alt_u32 clock_freq_hertz,
                                 int num_sections, ...)
{
  va_list name_args;
  double total_sec;
  alt_u64 total_clocks;
  alt_u64 section_clocks;
  char* section_name;
  int section_num = 1;

  const char* separator = 
    "+---------------+-----+-----------+---------------+-----------+\n";
  const char* column_header = 
    "| Section       |  %  | Time (sec)|  Time (clocks)|Occurrences|\n";

  PERF_STOP_MEASURING (perf_base);

  va_start (name_args, num_sections);

  total_clocks = perf_get_total_time (perf_base);
  total_sec    = ((double)total_clocks) / clock_freq_hertz;

  // Print the total at the top:
  printf ("--Performance Counter Report--\nTotal Time: %3G seconds  (%lld clock-cycles)\n%s%s%s",
          total_sec, total_clocks, separator, column_header, separator);

  section_name = va_arg(name_args, char*);

  for (section_num = 1; section_num <= num_sections; section_num++)
    {
      section_clocks = perf_get_section_time (perf_base, section_num);

      printf ("|%-15s|%5.3g|%11.5f|%15lld|%11u|\n%s",
              section_name,
              ((((double) section_clocks)) * 100) / total_clocks,
              (((double) section_clocks)) / clock_freq_hertz,
              section_clocks,
              (unsigned int) perf_get_num_starts (perf_base, section_num),
              separator
              );

      section_name = va_arg(name_args, char*);
    }

  va_end (name_args);

  return 0;
}

#else

/*
 * When the small C library is enabled, the printf function does not support
 * floating point format. This function print the time in usec instead of
 * second.
 */
int perf_print_formatted_report (void* perf_base, 
                                 alt_u32 clock_freq_hertz,
                                 int num_sections, ...)
{
    va_list name_args;
    alt_u64 total_usec;
    alt_u64 total_clocks;
    alt_u64 section_clocks;
    char* section_name;
    int section_num = 1;

    const char* separator =
      "+---------------+-----+------------+---------------+------------+\n";
    
    const char* column_header =
      "| Section       |  %  | Time (usec)|  Time (clocks)|Occurrences |\n";

    PERF_STOP_MEASURING (perf_base);

    va_start (name_args, num_sections);

    total_clocks = perf_get_total_time (perf_base);
    total_usec = total_clocks * 1000000 / clock_freq_hertz;

    // Print the total at the top:
    printf("--Performance Counter Report--\n");
    printf("Total Time : %llu usec ", total_usec);            
    printf("(%llu clock-cycles)\n", total_clocks);            
    printf("%s", separator);
    printf("%s", column_header);
    printf("%s", separator);

    section_name = va_arg(name_args, char*);

    for (section_num = 1; section_num <= num_sections; section_num++)
    {
        section_clocks = perf_get_section_time (perf_base, section_num);
        /* section name, small C library does not support left-justify, 
         * uses right-justify instead.
         */
        printf ("|%15s", section_name);

        /* section usage */
        if (total_clocks) 
        {
            printf ("|%4u ", (unsigned int)(section_clocks * 100 / total_clocks));
        }
        else
        {
            printf ("|%4u ", 0);
        }        

        /* section usecs */
        printf ("|%11llu ", (alt_u64)(section_clocks * 1000000 / clock_freq_hertz));

        /* section clocks */
        printf ("|%14u ", (unsigned int)section_clocks);

        /* section occurrences */
        printf ("|%10u  |\n",
        (unsigned int) perf_get_num_starts (perf_base, section_num));

        printf ("%s", separator);

        section_name = va_arg(name_args, char*);
    }

    va_end (name_args);

    return 0;
}

#endif /* SMALL_C_LIB */


