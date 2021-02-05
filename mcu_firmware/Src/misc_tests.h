#ifndef _MISC_TESTS_H_
#define _MISC_TESTS_H_

#include <stdio.h>
#include <string.h>
#include <stdarg.h>



/* SD card access test.
 * Initialize FatFs, list, read, write etc the contents of SD card.
 * Also, measure the read speed for a given file.
 *
 * About SDCARD_ACCESS_TEST_ENABLE :
 *  - 0 : disable the test
 *  - 1 : enable the test when Nucleo board's blue button is pushed
 */
#define SDCARD_ACCESS_TEST_ENABLE 0

#if SDCARD_ACCESS_TEST_ENABLE == 1
void sdcard_access_test(void);
#endif // SDCARD_ACCESS_TEST_ENABLE == 1



/* BUP file test bench.
 *
 * About BUP_TEST_BENCH_ENABLE :
 *  - 0 : disable the test bench
 *  - 1 : enable the test bench when Nucleo board's blue button is pushed
 */
#define BUP_TEST_BENCH_ENABLE 1

#if BUP_TEST_BENCH_ENABLE == 1
void bup_test_bench(void);
#endif // BUP_TEST_BENCH_ENABLE == 1



/* Test(s) execution function.
 * Call it periodically from program main loop.
 */
void do_tests(void);


#endif // _SDCARD_TEST_H_
