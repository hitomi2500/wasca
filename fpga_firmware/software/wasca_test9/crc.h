#ifndef __CRC__H__
#define __CRC__H__

#include <stdio.h>

//----------------------------------------------------------------------
// CRC32
//----------------------------------------------------------------------
unsigned long crc32_update(unsigned long crc, const void *buf, unsigned long size);
#define CRC32_INITVAL 0
#define crc32_calc(_BUFF_, _SIZE_) crc32_update(CRC32_INITVAL, _BUFF_, _SIZE_)

#endif      /* __CRC__H__ */
