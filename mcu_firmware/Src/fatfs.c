/**
  ******************************************************************************
  * @file   fatfs.c
  * @brief  Code for fatfs applications
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under Ultimate Liberty license
  * SLA0044, the "License"; You may not use this file except in compliance with
  * the License. You may obtain a copy of the License at:
  *                             www.st.com/SLA0044
  *
  ******************************************************************************
  */

#include "fatfs.h"

uint8_t retSD;    /* Return value for SD */
char SDPath[4];   /* SD logical drive path */
FATFS SDFatFS;    /* File system object for SD logical drive */
FIL SDFile;       /* File object for SD */

/* USER CODE BEGIN Variables */
#include <string.h>
DWORD _sd_timestamp = 0;

/* USER CODE END Variables */

void MX_FATFS_Init(void)
{
  /*## FatFS: Link the SD driver ###########################*/
  retSD = FATFS_LinkDriver(&SD_Driver, SDPath);

  /* USER CODE BEGIN Init */
  /* additional user code for init */
  /* USER CODE END Init */
}

/**
  * @brief  Gets Time from RTC
  * @param  None
  * @retval Time in DWORD
  */
DWORD get_fattime(void)
{
  /* USER CODE BEGIN get_fattime */

  if(_sd_timestamp == 0)
  {
    /* If no better timestamp available, set it up
     * according to the build time stamp of this module.
     */
    const char *months_list[12] = {"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};

    char build_date[32] = {'\0'};
    strcpy(build_date, __DATE__);
    build_date[6] = '\0';
    build_date[11] = '\0';

    unsigned long year = (unsigned long)atoi(build_date + 7);

    unsigned long month = 0;
    for (int i = 0; i < 12; i++)
    {
        if (memcmp(build_date, months_list[i], 3) == 0)
        {
            month = i + 1;
            break;
        }
    }

    unsigned long day = (unsigned long)atoi(build_date + 4);

    char build_time[32] = {'\0'};
    strcpy(build_time, __TIME__);
    build_time[2] = '\0';
    build_time[5] = '\0';
    build_time[8] = '\0';

    unsigned long hour   = (unsigned long)atoi(build_time + 0);
    unsigned long minute = (unsigned long)atoi(build_time + 3);
    unsigned long second = (unsigned long)atoi(build_time + 6);

    _sd_timestamp =
        ((year - 1980) << 25)
        | (month       << 21)
        | (day         << 16)
        | (hour        << 11)
        | (minute      <<  5)
        | (second      >>  1);
  }

  return _sd_timestamp;
  /* USER CODE END get_fattime */
}

/* USER CODE BEGIN Application */

/* USER CODE END Application */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
