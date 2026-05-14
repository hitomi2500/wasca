#include "wasca_svf.h"
#include "jtag.h"
#include "main.h"

//these numbers must be copied from auto-generated wasca_svf.c
#define CMDLIST_SIZE 133931
#define ARGS1_SIZE 53583
#define ARGS2_SIZE 55

extern const unsigned char cmdlist[CMDLIST_SIZE];
extern const unsigned int args1_list[ARGS1_SIZE];
extern const unsigned int args2_list[ARGS2_SIZE];
extern int iErrorCount;

void __do_RUNTEST_TCK(unsigned int value)
{
	JTAG_Ticks(value);
}

void __do_RUNTEST_TCK_ENDSTATE_IDLE(unsigned int value)
{
	__do_RUNTEST_TCK(value);
	//JTAG_Reset();
}

void __do_SDR_TDI(unsigned int length, unsigned int value)
{
	JTAG_SDR(value,length);
}

void __do_SDR_TDI_TDO(unsigned int value1, unsigned int value2)
{
	unsigned int res = JTAG_SDR(value1,32);
	if (res != value2)
	{
		iErrorCount++;
	}
}

void __do_SDR_TDI_TDO_MASK(unsigned int value1, unsigned int value2, unsigned int value3)
{
	unsigned int res = JTAG_SDR(value1,32);
	if ((res&value3) != (value2&value3))
	{
		iErrorCount++;
	}
}

void __do_SDR_1_TDI_0_TDO_1_MASK_1()
{
	JTAG_SDR(0,1);
}

void __do_SIR_10_TDI(unsigned int value1)
{
	JTAG_SIR(value1,10);
}

void __do_play_xsvf()
{
	int iArgsIndex;
	iErrorCount = 0;
	//struct CMD_ARGS _args;
	int iArgs1_Index = 0;
	int iArgs2_Index = 0;
	unsigned char cmd;
	GPIO_InitTypeDef GPIO_InitStruct = {0};

	//set led to blue
	HAL_GPIO_WritePin(LD1_R_GPIO_Port, LD1_R_Pin, GPIO_PIN_RESET); /* (Green on my board) */
	HAL_GPIO_WritePin(LD1_G_GPIO_Port, LD1_G_Pin, GPIO_PIN_RESET); /* (Blue on my board)  */
	HAL_GPIO_WritePin(LD1_B_GPIO_Port, LD1_B_Pin, GPIO_PIN_SET); /* (Red on my board)   */

	/*Configure GPIO pins as outputs : TDI and TMS */
	GPIO_InitStruct.Pin = MAX_TDI_Pin|MAX_TMS_Pin;
	GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

	/*Configure GPIO pins as outputs : TCK, keeping TDO as input */
	GPIO_InitStruct.Pin = MAX_TCK_Pin;
	GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
	HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);

	JTAG_Reset();

	for (int i=0;i<CMDLIST_SIZE;i++)
	{
		cmd = cmdlist[i];
		switch (cmd)
		{
		case RUNTEST_128_TCK:
			__do_RUNTEST_TCK(128);
			break;
		case RUNTEST_IDLE_128_TCK_ENDSTATE_IDLE:
			__do_RUNTEST_TCK_ENDSTATE_IDLE(128);
			break;
		case RUNTEST_8000_TCK:
			__do_RUNTEST_TCK(8000);
			break;
		case RUNTEST_25000_TCK:
			__do_RUNTEST_TCK(25000);
			break;
		case RUNTEST_8750003_TCK:
			__do_RUNTEST_TCK(8750003);
			break;
		case SDR_23_TDI:
			__do_SDR_TDI(23,args1_list[iArgs1_Index]);
			iArgs1_Index++;
			break;
		case SDR_32_TDI:
			__do_SDR_TDI(32,args1_list[iArgs1_Index]);
			iArgs1_Index++;
			break;
		case SDR_32_TDI_0_TDO_F_MASK_F:
			__do_SDR_TDI_TDO_MASK(0, 0xFFFFFFFF, 0xFFFFFFFF);
			break;
		case SDR_32_TDI_0_TDO_F:
			__do_SDR_TDI_TDO(0,0xFFFFFFFF);
			break;
		case SDR_32_TDI_0_TDO:
			__do_SDR_TDI_TDO(0,args1_list[iArgs1_Index]);
			iArgs1_Index++;
			break;
		case SDR_32_TDI_0_TDO_MASK:
			__do_SDR_TDI_TDO_MASK(0, args1_list[iArgs1_Index], args2_list[iArgs2_Index]);
			iArgs1_Index++;
			iArgs2_Index++;
			break;
		case SDR_1_TDI_0_TDO_1_MASK_1:
			__do_SDR_1_TDI_0_TDO_1_MASK_1();
			break;
		case SIR_10_TDI:
			__do_SIR_10_TDI(args1_list[iArgs1_Index]);
			iArgs1_Index++;
			break;
		}

		if (i%10000 < 5000)
		{
			  //set led to blue
			  HAL_GPIO_WritePin(LD1_R_GPIO_Port, LD1_R_Pin, GPIO_PIN_RESET); /* (Green on my board) */
			  HAL_GPIO_WritePin(LD1_G_GPIO_Port, LD1_G_Pin, GPIO_PIN_RESET); /* (Blue on my board)  */
			  HAL_GPIO_WritePin(LD1_B_GPIO_Port, LD1_B_Pin, GPIO_PIN_SET); /* (Red on my board)   */
		}
		else
		{
			  //set led to yellow
			  HAL_GPIO_WritePin(LD1_R_GPIO_Port, LD1_R_Pin, GPIO_PIN_SET); /* (Green on my board) */
			  HAL_GPIO_WritePin(LD1_G_GPIO_Port, LD1_G_Pin, GPIO_PIN_SET); /* (Blue on my board)  */
			  HAL_GPIO_WritePin(LD1_B_GPIO_Port, LD1_B_Pin, GPIO_PIN_RESET); /* (Red on my board)   */
		}

		if (iErrorCount > 0)
		{
			  //set led to red
			  HAL_GPIO_WritePin(LD1_R_GPIO_Port, LD1_R_Pin, GPIO_PIN_SET); /* (Green on my board) */
			  HAL_GPIO_WritePin(LD1_G_GPIO_Port, LD1_G_Pin, GPIO_PIN_RESET); /* (Blue on my board)  */
			  HAL_GPIO_WritePin(LD1_B_GPIO_Port, LD1_B_Pin, GPIO_PIN_RESET); /* (Red on my board)   */
			  while(1);
		}

	}

	//set led to green
	HAL_GPIO_WritePin(LD1_R_GPIO_Port, LD1_R_Pin, GPIO_PIN_RESET); /* (Green on my board) */
	HAL_GPIO_WritePin(LD1_G_GPIO_Port, LD1_G_Pin, GPIO_PIN_SET); /* (Blue on my board)  */
	HAL_GPIO_WritePin(LD1_B_GPIO_Port, LD1_B_Pin, GPIO_PIN_RESET); /* (Red on my board)   */

	if (iArgs1_Index != ARGS1_SIZE)
	{
		//set led to yellow
		HAL_GPIO_WritePin(LD1_R_GPIO_Port, LD1_R_Pin, GPIO_PIN_SET); /* (Green on my board) */
		HAL_GPIO_WritePin(LD1_G_GPIO_Port, LD1_G_Pin, GPIO_PIN_SET); /* (Blue on my board)  */
		HAL_GPIO_WritePin(LD1_B_GPIO_Port, LD1_B_Pin, GPIO_PIN_RESET); /* (Red on my board)   */
	}
	if (iArgs2_Index != ARGS2_SIZE)
	{
		//set led to violet
		HAL_GPIO_WritePin(LD1_R_GPIO_Port, LD1_R_Pin, GPIO_PIN_SET); /* (Green on my board) */
		HAL_GPIO_WritePin(LD1_G_GPIO_Port, LD1_G_Pin, GPIO_PIN_RESET); /* (Blue on my board)  */
		HAL_GPIO_WritePin(LD1_B_GPIO_Port, LD1_B_Pin, GPIO_PIN_SET); /* (Red on my board)   */
	}

	//back to inputs

	/*Configure GPIO pins : MAX_TDI_Pin MAX_TMS_Pin */
	GPIO_InitStruct.Pin = MAX_TDI_Pin|MAX_TMS_Pin;
	GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

	/*Configure GPIO pins : MAX_TDO_Pin MAX_TCK_Pin */
	GPIO_InitStruct.Pin = MAX_TDO_Pin|MAX_TCK_Pin;
	GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	HAL_GPIO_Init(GPIOB, &GPIO_InitStruct);
}
