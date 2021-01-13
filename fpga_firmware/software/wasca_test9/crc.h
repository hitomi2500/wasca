/**
 * \file crc.h
 * Functions and types for CRC checks.
 *
 * Generated on Sun Jun  3 22:08:52 2012,
 * by pycrc v0.7.10, http://www.tty1.net/pycrc/
 * using the configuration:
 *    Width        = 8
 *    Poly         = 0x07
 *    XorIn        = 0x00
 *    ReflectIn    = False
 *    XorOut       = 0x00
 *    ReflectOut   = False
 *    Algorithm    = table-driven
 *****************************************************************************/
#ifndef __CRC__H__
#define __CRC__H__

#include <stdlib.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif


/**
 * The definition of the used algorithm.
 *****************************************************************************/
#define CRC_ALGO_TABLE_DRIVEN 1


/**
 * The type of the CRC values.
 *
 * This type must be big enough to contain at least 8 bits.
 *****************************************************************************/
typedef uint8_t crc_t;


/**
 * Calculate the initial crc value.
 *
 * \return     The initial crc value.
 *****************************************************************************/
static inline crc_t crc_init(void)
{
    return 0x00;
}


/**
 * Update the crc value with new data.
 *
 * \param crc      The current crc value.
 * \param data     Pointer to a buffer of \a data_len bytes.
 * \param data_len Number of bytes in the \a data buffer.
 * \return         The updated crc value.
 *****************************************************************************/
crc_t crc_update(crc_t crc, const unsigned char *data, size_t data_len);


/**
 * Calculate the final crc value.
 *
 * \param crc  The current crc value.
 * \return     The final crc value.
 *****************************************************************************/
static inline crc_t crc_finalize(crc_t crc)
{
    return crc ^ 0x00;
}


//----------------------------------------------------------------------
// CRC32
//----------------------------------------------------------------------
unsigned long crc32_update(unsigned long crc, const void *buf, unsigned long size);
#define CRC32_INITVAL 0
#define crc32_calc(_BUFF_, _SIZE_) crc32_update(CRC32_INITVAL, _BUFF_, _SIZE_)


#ifdef __cplusplus
}           /* closing brace for extern "C" */
#endif

#endif      /* __CRC__H__ */
