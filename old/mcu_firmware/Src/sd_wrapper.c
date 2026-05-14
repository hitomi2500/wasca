#include <stdio.h>
#include <string.h>
#include "sd_wrapper.h"

#include "log.h"

int _sdcard_available = 0;


void sdcard_reset(void)
{
    _sdcard_available = 0;
}


void sdcard_init(void)
{
  termout(WL_LOG_DEBUGNORMAL, "retSD:%d SDPath:%c%c%c%c", retSD, SDPath[0], SDPath[1], SDPath[2], SDPath[3]);
  termout(WL_LOG_DEBUGNORMAL, "BSP_SD_IsDetected:%d", BSP_SD_IsDetected());

  _sdcard_available = 0;

  if(retSD == 0)
  {
    /* success: set the orange LED on */
    // HAL_GPIO_WritePin(GPIOG, GPIO_PIN_7, GPIO_PIN_RESET);

    /*##-2- Register the file system object to the FatFs module ###*/
    termout(WL_LOG_DEBUGNORMAL, "FatFs Initialization STT ...");
    if(f_mount(&SDFatFS, (TCHAR const*)SDPath, 0) == FR_OK)
    {
        _sdcard_available = 1;
    }
    else
    {
        /* FatFs Initialization Error : set the red LED on */
        termout(WL_LOG_DEBUGNORMAL, "FatFs Initialization Error !");
        //HAL_GPIO_WritePin(GPIOG, GPIO_PIN_10, GPIO_PIN_RESET);
        //while(1);
    }
  }
}
