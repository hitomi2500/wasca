/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2020 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under Ultimate Liberty license
  * SLA0044, the "License"; You may not use this file except in compliance with
  * the License. You may obtain a copy of the License at:
  *                             www.st.com/SLA0044
  *
  ******************************************************************************
  */
/* USER CODE END Header */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __MAIN_H
#define __MAIN_H

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f4xx_hal.h"

/* Private includes ----------------------------------------------------------*/
/* USER CODE BEGIN Includes */

/* USER CODE END Includes */

/* Exported types ------------------------------------------------------------*/
/* USER CODE BEGIN ET */

/* USER CODE END ET */

/* Exported constants --------------------------------------------------------*/
/* USER CODE BEGIN EC */

/* USER CODE END EC */

/* Exported macro ------------------------------------------------------------*/
/* USER CODE BEGIN EM */

/* USER CODE END EM */

/* Exported functions prototypes ---------------------------------------------*/
#define Error_Handler() Error_Handler_Ex(__BASE_FILE__, __LINE__, __FUNCTION__)

/* USER CODE BEGIN EFP */
void Error_Handler_Ex(const char* file, int line, const char* func);
/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define LD1_R_Pin GPIO_PIN_13
#define LD1_R_GPIO_Port GPIOC
#define LD1_G_Pin GPIO_PIN_14
#define LD1_G_GPIO_Port GPIOC
#define LD1_B_Pin GPIO_PIN_15
#define LD1_B_GPIO_Port GPIOC
#define SPI_SYNC_MOSI_Pin GPIO_PIN_4
#define SPI_SYNC_MOSI_GPIO_Port GPIOA
#define SD_GND_DETECT_Pin GPIO_PIN_5
#define SD_GND_DETECT_GPIO_Port GPIOC
#define B1_Pin GPIO_PIN_14
#define B1_GPIO_Port GPIOB
#define LD3_Pin GPIO_PIN_15
#define LD3_GPIO_Port GPIOB
#define SD_DETECT_Pin GPIO_PIN_6
#define SD_DETECT_GPIO_Port GPIOC
#define TMS_Pin GPIO_PIN_13
#define TMS_GPIO_Port GPIOA
#define TCK_Pin GPIO_PIN_14
#define TCK_GPIO_Port GPIOA
#define LD2_Pin GPIO_PIN_12
#define LD2_GPIO_Port GPIOC
#define SWO_Pin GPIO_PIN_3
#define SWO_GPIO_Port GPIOB
#define SPI_SYNC_MISO_Pin GPIO_PIN_6
#define SPI_SYNC_MISO_GPIO_Port GPIOB
#define BUFFER_ENABLE_Pin GPIO_PIN_2
#define BUFFER_ENABLE_GPIO_Port GPIOA
#define SATURN_POWER_Pin GPIO_PIN_3
#define SATURN_POWER_GPIO_Port GPIOA
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
