/**
 *  Wasca Link - base definition
 *  by cafe-alpha.
 *  WWW: http://ppcenter.free.fr/devblog/
 *
 *  See LICENSE file for details.
**/

#ifndef WASCA_LINK_BASE_H
#define WASCA_LINK_BASE_H

/* Select compilation target : BCB or NIOS or STM32. */
#ifdef TARGET_STM32
#else
#   ifndef _BCB
#       define TARGET_NIOS
#   else // _BCB
#       undef TARGET_NIOS
#   endif
#endif

/* Inclusion of structure alignment macros. */
#ifdef TARGET_STM32
#   define SC_ALIGN_4_BYTES(_STRUCT_NAME_) _STRUCT_NAME_
#   define SC_ALIGN_2_BYTES(_STRUCT_NAME_) _STRUCT_NAME_
#else
#   ifdef TARGET_NIOS
#       define SC_ALIGN_4_BYTES(_STRUCT_NAME_) _STRUCT_NAME_ __attribute__((aligned(4)))
#       define SC_ALIGN_2_BYTES(_STRUCT_NAME_) _STRUCT_NAME_ __attribute__((aligned(2)))
#   else // _BCB
#       define SC_ALIGN_4_BYTES(_STRUCT_NAME_) _STRUCT_NAME_
#       define SC_ALIGN_2_BYTES(_STRUCT_NAME_) _STRUCT_NAME_
#   endif
#endif

/* Definition of 64 bits integer type. */
#ifdef TARGET_STM32
#   define ulonglong_t unsigned __int64
#else // !TARGET_STM32
#   ifdef TARGET_NIOS
#       include <alt_types.h>
#       define ulonglong_t alt_u64
#   else // _BCB
#       define ulonglong_t unsigned __int64
#   endif
#endif

#endif // WASCA_LINK_BASE_H
