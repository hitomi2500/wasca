/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file           : main.h
  * @brief          : Header for main.c file.
  *                   This file contains the common defines of the application.
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
void Error_Handler(void);

/* USER CODE BEGIN EFP */

/* USER CODE END EFP */

/* Private defines -----------------------------------------------------------*/
#define LD1_B_Pin GPIO_PIN_13
#define LD1_B_GPIO_Port GPIOC
#define LD1_R_Pin GPIO_PIN_14
#define LD1_R_GPIO_Port GPIOC
#define LD1_G_Pin GPIO_PIN_15
#define LD1_G_GPIO_Port GPIOC
#define MAX_TDI_Pin GPIO_PIN_0
#define MAX_TDI_GPIO_Port GPIOA
#define MAX_TMS_Pin GPIO_PIN_1
#define MAX_TMS_GPIO_Port GPIOA
#define MAX_TDO_Pin GPIO_PIN_14
#define MAX_TDO_GPIO_Port GPIOB
#define MAX_TCK_Pin GPIO_PIN_15
#define MAX_TCK_GPIO_Port GPIOB
#define LD2_Pin GPIO_PIN_12
#define LD2_GPIO_Port GPIOC
/* USER CODE BEGIN Private defines */

/* USER CODE END Private defines */

#ifdef __cplusplus
}
#endif

#endif /* __MAIN_H */

/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/
