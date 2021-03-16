#include "log.h"



/*
 * ------------------------------------------
 * - Log stuff ------------------------------
 * ------------------------------------------
 */


#if LOG_ENABLE == 1
/* Circular debugger global definition. */
log_infos_t _log_inf_data;
log_infos_t* _log_inf_ptr = NULL;
#endif // LOG_ENABLE == 1


void log_init(void)
{
#if LOG_ENABLE == 1
    /* Initialize pointer to log informations structure. */
    _log_inf_ptr = &_log_inf_data;

    /* Initialize log internals themselves. */
    log_infos_t* logs = _log_inf_ptr;
    memset(logs, 0, sizeof(log_infos_t));

    /* Reset circular buffer pointers. */
    logs->readptr  = 0;
    logs->writeptr = logs->readptr;

    /* Set internals. */
    logs->start_address = (unsigned long)logs->circbuff;
    logs->end_address   = logs->start_address + sizeof(logs->circbuff) - 1;
    logs->buffer_size   = sizeof(logs->circbuff);
#endif // LOG_ENABLE == 1
}


/**
 * Write type+datalen+data in Circular buffer.
 * It modifies circular buffer's write pointer.
**/
void log_cbwrite(unsigned char* data, unsigned long datalen)
{
#if LOG_ENABLE == 1
    log_infos_t* logs = _log_inf_ptr;

    unsigned long log_mem_free = logs->buffer_size - log_cbmem_use();

    if(datalen >= log_mem_free)
    {
        //termout(WL_LOG_DEBUGNORMAL, "$ | Tick[0x%08X] log_cbwrite datalen:%5u ABNORMAL #1"
        //    , (unsigned int)HAL_GetTick()
        //    , (unsigned int)datalen);

        return;
    }

    //termout(WL_LOG_DEBUGNORMAL, "$$$ Tick[0x%08X] log_cbwrite WR[%5u] RD[%5u] datalen:%5u STT"
    //    , (unsigned int)HAL_GetTick()
    //    , (unsigned int)logs->writeptr
    //    , (unsigned int)logs->readptr
    //    , (unsigned int)datalen);

    unsigned long end_space = logs->buffer_size - logs->writeptr;

    if(end_space >= datalen)
    { /* Enough space until the end of the buffer. */
        memcpy((void*)(logs->start_address+logs->writeptr), 
               (void*)(data), 
               datalen);

        /* Update write pointer. */
        logs->writeptr = logs->writeptr + datalen;
    }
    else
    { /* Need to write the data in 2 times: end of buffer, and the remaining from the buffer start */
        memcpy((void*)(logs->start_address+logs->writeptr), 
               (void*)(data), 
               end_space);

        memcpy((void*)(logs->start_address), 
               (void*)(data+end_space), 
               datalen - end_space);

        /* Update write pointer. */
        logs->writeptr = logs->writeptr + datalen - logs->buffer_size;
    }


    //termout(WL_LOG_DEBUGNORMAL, "$ | Tick[0x%08X] log_cbwrite WR[%5u] RD[%5u] datalen:%5u END"
    //    , (unsigned int)HAL_GetTick()
    //    , (unsigned int)logs->writeptr
    //    , (unsigned int)logs->readptr
    //    , (unsigned int)datalen);
#endif // LOG_ENABLE != 1
}


/**
 * Return circular buffer memory total/usage.
**/
unsigned short log_cbmem_total(void)
{
#if LOG_ENABLE == 1
    log_infos_t* logs = _log_inf_ptr;

    return logs->buffer_size;
#else
    return 0;
#endif // LOG_ENABLE != 1
}
unsigned short log_cbmem_use(void)
{
#if LOG_ENABLE == 1
    log_infos_t* logs = _log_inf_ptr;
    unsigned long ret;

    //termout(WL_LOG_DEBUGNORMAL, "### Tick[0x%08X] log_cbmem_use WR:%5u, RD:%5u"
    //    , (unsigned int)HAL_GetTick()
    //    , (unsigned int)logs->writeptr
    //    , (unsigned int)logs->readptr);

    if(logs->writeptr == logs->readptr)
    {
        ret = 0;
    }
    else if(logs->writeptr > logs->readptr)
    {
        ret = logs->writeptr - logs->readptr/* + 1*/;
    }
    else //!if(d->writeptr >= d->readptr)
    {
        ret  = logs->buffer_size - logs->readptr;
        ret += logs->writeptr /*+ 1*/;
    }

    //termout(WL_LOG_DEBUGNORMAL, "# | Tick[0x%08X] log_cbmem_use WR[%5u] RD[%5u] ret:%5u END"
    //    , (unsigned int)HAL_GetTick()
    //    , (unsigned int)logs->writeptr
    //    , (unsigned int)logs->readptr
    //    , (unsigned int)ret);

    return ret;
#else
    return 0;
#endif // LOG_ENABLE != 1
}


/**
 * Read specified length from logs circular buffer.
 * If specified, circular buffer read pointer is updated.
 *
 * Note : it won't behave correctly if specified read length
 *        is higher than used length in circular buffer.
**/
void log_cbread(unsigned char* data, unsigned long read_len, int update_rp)
{
#if LOG_ENABLE == 1
    log_infos_t* logs = _log_inf_ptr;

    //termout(WL_LOG_DEBUGNORMAL, "^^^ Tick[0x%08X] log_cbread WR[%5u] RD[%5u] read_len:%5u STT"
    //    , (unsigned int)HAL_GetTick()
    //    , (unsigned int)logs->writeptr
    //    , (unsigned int)logs->readptr
    //    , (unsigned int)read_len);

    if(read_len == 0)
    {
        /* Nothing to read ? */
        return;
    }

    if(logs->writeptr > logs->readptr)
    {
        memcpy((void*)(data), 
               (void*)(logs->start_address+logs->readptr), 
               read_len);
    }
    else
    {
        unsigned long first_len = logs->buffer_size - logs->readptr;
        memcpy((void*)(data), 
               (void*)(logs->start_address+logs->readptr), 
               (read_len > first_len ? first_len : read_len));

        if(read_len > first_len)
        {
            memcpy((void*)(data + first_len), 
                   (void*)(logs->start_address), 
                   read_len - first_len);
        }
    }

    /* If requested, update read pointer. */
    if(update_rp)
    {
        unsigned long ptr = logs->readptr + read_len;
        logs->readptr = (ptr >= logs->buffer_size ? ptr - logs->buffer_size : ptr);
    }

    //termout(WL_LOG_DEBUGNORMAL, "^ | Tick[0x%08X] log_cbread WR[%5u] RD[%5u] read_len:%5u END"
    //    , (unsigned int)HAL_GetTick()
    //    , (unsigned int)logs->writeptr
    //    , (unsigned int)logs->readptr
    //    , (unsigned int)read_len);
#endif // LOG_ENABLE == 1
}



void logout_internal(int to_uart, int to_usb, int level, const char* fmt, ... )
{
#if LOG_ENABLE == 1

    if((to_uart == 0) && (to_usb == 0))
    {
        return;
    }

    log_infos_t* logs = _log_inf_ptr;

    va_list argptr;

    /* Buffer where to format log message.
     * First two bytes are used to store message length.
     */
    unsigned short len = 0;
    char* buff = (char*)(logs->format_buff + sizeof(len));
    int buff_len = sizeof(logs->format_buff) - sizeof(len) - 4;

    /* Print the log message to the memory. */
    va_start(argptr, fmt);
    len += vsnprintf(buff, buff_len, fmt, argptr); buff[buff_len-1] = '\0';
    va_end(argptr);

    if(to_uart)
    {
        /* Simply throw log message to UART.
         * That's slow, but handy when log via USB can't be used.
         */
        printf("%s\r\n", buff);
    }

    if(to_usb)
    {
        /* Append to circular buffer shared between this device and PC.
         * First two bytes are used to store message length.
         * Then, log message without terminating null character is stored.
         */
        len += sizeof(len);
        memcpy(logs->format_buff, &len, sizeof(len));
        log_cbwrite(logs->format_buff, len);
    }
#endif // LOG_ENABLE == 1
}


void logflush_internal(void)
{
#if LOG_ENABLE == 1
//    log_infos_t* logs = _log_inf_ptr;
//
//    /* Wait until logs read ptr == write ptr. */
//    do
//    {
//        link_do_io();
//    }while(logs->writeptr != logs->readptr);
#endif // LOG_ENABLE == 1
}

