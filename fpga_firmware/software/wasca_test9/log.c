#include "log.h"

#include "wasca_defs.h"


/*
 * ------------------------------------------
 * - Log stuff ------------------------------
 * ------------------------------------------
 */


#if LOG_ENABLE == 1
/* Circular debugger global definition. */
log_infos_t* _log_inf_ptr = NULL;
#endif // LOG_ENABLE == 1


void log_init(void)
{
// (Nothing really special to implement when simple text output via UART is used)
}
