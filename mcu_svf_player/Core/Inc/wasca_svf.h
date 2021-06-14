enum JTAG_PIN {
	TDI=10,
	TDO=11,
	TMS=12,
	TCK=13,
	};

enum STATES {
	IDLE=20,
	};

enum FLAGS {
	ENDSTATE=30,
	MASK=31,
	};

enum CMDS {
	__cmd_SIR_3,
	__cmd_SDR_3,
	__cmd_SDR_5,
	__cmd_RUNTEST_2,
	__cmd_RUNTEST_5,
	__cmd_SDR_7
};

#define RUNTEST_128_TCK 0
#define RUNTEST_IDLE_128_TCK_ENDSTATE_IDLE 1
#define RUNTEST_8000_TCK 2
#define RUNTEST_25000_TCK 3
#define RUNTEST_8750003_TCK 4
#define SDR_23_TDI 5
#define SDR_32_TDI 6
#define SDR_32_TDI_0_TDO_F_MASK_F 7
#define SDR_32_TDI_0_TDO_F 8
#define SDR_32_TDI_0_TDO 9
#define SDR_32_TDI_0_TDO_MASK 10
#define SDR_1_TDI_0_TDO_1_MASK_1 11
#define SIR_10_TDI 12

/*struct CMD_ARGS {
	unsigned char cmd;
	unsigned char arg1_8;
	unsigned char arg2_8;
	unsigned int arg3_32;
	unsigned char arg4_8;
	unsigned int arg5_32;
	unsigned char arg6_8;
	unsigned int arg7_32;
};*/

/*
void __do_SIR_3(int a,enum JTAG_PIN b,int c);

void __do_SDR_3(int a,enum JTAG_PIN b,int c);

void __do_SDR_5(int a,enum JTAG_PIN b,int c, enum JTAG_PIN d,int e);

void __do_RUNTEST_2(int a,enum JTAG_PIN b);

void __do_RUNTEST_5(enum STATES a,int b,enum JTAG_PIN c,enum FLAGS d,enum STATES e);

void __do_SDR_7(int a,enum JTAG_PIN b,int c,enum JTAG_PIN d,int e,enum FLAGS f,int g);

*/
