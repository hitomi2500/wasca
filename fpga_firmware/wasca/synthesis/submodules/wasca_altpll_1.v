//altpll_avalon avalon_use_separate_sysclk="NO" CBX_SINGLE_OUTPUT_FILE="ON" CBX_SUBMODULE_USED_PORTS="altpll:areset,clk,locked,inclk" address areset c0 c1 c2 c3 c4 clk configupdate locked phasecounterselect phasedone phasestep phaseupdown read readdata reset scanclk scanclkena scandata scandataout scandone write writedata bandwidth_type="AUTO" clk0_divide_by=2 clk0_duty_cycle=50 clk0_multiply_by=25 clk0_phase_shift="0" compensate_clock="CLK0" device_family="MAX10" inclk0_input_frequency=125000 intended_device_family="MAX 10" operation_mode="normal" pll_type="AUTO" port_clk0="PORT_USED" port_clk1="PORT_UNUSED" port_clk2="PORT_UNUSED" port_clk3="PORT_UNUSED" port_clk4="PORT_UNUSED" port_clk5="PORT_UNUSED" port_extclk0="PORT_UNUSED" port_extclk1="PORT_UNUSED" port_extclk2="PORT_UNUSED" port_extclk3="PORT_UNUSED" port_inclk1="PORT_UNUSED" port_phasecounterselect="PORT_UNUSED" port_phasedone="PORT_UNUSED" port_scandata="PORT_UNUSED" port_scandataout="PORT_UNUSED" width_clock=5
//VERSION_BEGIN 18.1 cbx_altclkbuf 2019:04:11:16:04:12:SJ cbx_altiobuf_bidir 2019:04:11:16:04:12:SJ cbx_altiobuf_in 2019:04:11:16:04:12:SJ cbx_altiobuf_out 2019:04:11:16:04:12:SJ cbx_altpll 2019:04:11:16:04:12:SJ cbx_cycloneii 2019:04:11:16:04:12:SJ cbx_lpm_add_sub 2019:04:11:16:04:12:SJ cbx_lpm_compare 2019:04:11:16:04:12:SJ cbx_lpm_counter 2019:04:11:16:04:12:SJ cbx_lpm_decode 2019:04:11:16:04:12:SJ cbx_lpm_mux 2019:04:11:16:04:12:SJ cbx_lpm_shiftreg 2019:04:11:16:04:12:SJ cbx_max10_altpll_avalon 2019:04:11:16:04:12:SJ cbx_mgl 2019:04:11:16:07:46:SJ cbx_nadder 2019:04:11:16:04:12:SJ cbx_stratix 2019:04:11:16:04:12:SJ cbx_stratixii 2019:04:11:16:04:12:SJ cbx_stratixiii 2019:04:11:16:04:12:SJ cbx_stratixv 2019:04:11:16:04:12:SJ cbx_util_mgl 2019:04:11:16:04:12:SJ  VERSION_END
// synthesis VERILOG_INPUT_VERSION VERILOG_2001
// altera message_off 10463



// Copyright (C) 2019  Intel Corporation. All rights reserved.
//  Your use of Intel Corporation's design tools, logic functions 
//  and other software and tools, and any partner logic 
//  functions, and any output files from any of the foregoing 
//  (including device programming or simulation files), and any 
//  associated documentation or information are expressly subject 
//  to the terms and conditions of the Intel Program License 
//  Subscription Agreement, the Intel Quartus Prime License Agreement,
//  the Intel FPGA IP License Agreement, or other applicable license
//  agreement, including, without limitation, that your use is for
//  the sole purpose of programming logic devices manufactured by
//  Intel and sold by Intel or its authorized distributors.  Please
//  refer to the applicable agreement for further details, at
//  https://fpgasoftware.intel.com/eula.




//altera_std_synchronizer CBX_SINGLE_OUTPUT_FILE="ON" clk din dout reset_n
//VERSION_BEGIN 18.1 cbx_mgl 2019:04:11:16:07:46:SJ cbx_stratixii 2019:04:11:16:04:12:SJ cbx_util_mgl 2019:04:11:16:04:12:SJ  VERSION_END


//dffpipe CBX_SINGLE_OUTPUT_FILE="ON" DELAY=3 WIDTH=1 clock clrn d q ALTERA_INTERNAL_OPTIONS=AUTO_SHIFT_REGISTER_RECOGNITION=OFF
//VERSION_BEGIN 18.1 cbx_mgl 2019:04:11:16:07:46:SJ cbx_stratixii 2019:04:11:16:04:12:SJ cbx_util_mgl 2019:04:11:16:04:12:SJ  VERSION_END

//synthesis_resources = reg 3 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
(* ALTERA_ATTRIBUTE = {"AUTO_SHIFT_REGISTER_RECOGNITION=OFF"} *)
module  wasca_altpll_1_dffpipe_l2c
	( 
	clock,
	clrn,
	d,
	q) /* synthesis synthesis_clearbox=1 */;
	input   clock;
	input   clrn;
	input   [0:0]  d;
	output   [0:0]  q;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   clock;
	tri1   clrn;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	[0:0]	dffe4a;
	reg	[0:0]	dffe5a;
	reg	[0:0]	dffe6a;
	wire ena;
	wire prn;
	wire sclr;

	// synopsys translate_off
	initial
		dffe4a = 0;
	// synopsys translate_on
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe4a <= {1{1'b1}};
		else if (clrn == 1'b0) dffe4a <= 1'b0;
		else if  (ena == 1'b1)   dffe4a <= (d & (~ sclr));
	// synopsys translate_off
	initial
		dffe5a = 0;
	// synopsys translate_on
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe5a <= {1{1'b1}};
		else if (clrn == 1'b0) dffe5a <= 1'b0;
		else if  (ena == 1'b1)   dffe5a <= (dffe4a & (~ sclr));
	// synopsys translate_off
	initial
		dffe6a = 0;
	// synopsys translate_on
	always @ ( posedge clock or  negedge prn or  negedge clrn)
		if (prn == 1'b0) dffe6a <= {1{1'b1}};
		else if (clrn == 1'b0) dffe6a <= 1'b0;
		else if  (ena == 1'b1)   dffe6a <= (dffe5a & (~ sclr));
	assign
		ena = 1'b1,
		prn = 1'b1,
		q = dffe6a,
		sclr = 1'b0;
endmodule //wasca_altpll_1_dffpipe_l2c

//synthesis_resources = reg 3 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  wasca_altpll_1_stdsync_sv6
	( 
	clk,
	din,
	dout,
	reset_n) /* synthesis synthesis_clearbox=1 */;
	input   clk;
	input   din;
	output   dout;
	input   reset_n;

	wire  [0:0]   wire_dffpipe3_q;

	wasca_altpll_1_dffpipe_l2c   dffpipe3
	( 
	.clock(clk),
	.clrn(reset_n),
	.d(din),
	.q(wire_dffpipe3_q));
	assign
		dout = wire_dffpipe3_q;
endmodule //wasca_altpll_1_stdsync_sv6


//altpll bandwidth_type="AUTO" CBX_SINGLE_OUTPUT_FILE="ON" clk0_divide_by=2 clk0_duty_cycle=50 clk0_multiply_by=25 clk0_phase_shift="0" compensate_clock="CLK0" device_family="MAX10" inclk0_input_frequency=125000 intended_device_family="MAX 10" operation_mode="normal" pll_type="AUTO" port_clk0="PORT_USED" port_clk1="PORT_UNUSED" port_clk2="PORT_UNUSED" port_clk3="PORT_UNUSED" port_clk4="PORT_UNUSED" port_clk5="PORT_UNUSED" port_extclk0="PORT_UNUSED" port_extclk1="PORT_UNUSED" port_extclk2="PORT_UNUSED" port_extclk3="PORT_UNUSED" port_inclk1="PORT_UNUSED" port_phasecounterselect="PORT_UNUSED" port_phasedone="PORT_UNUSED" port_scandata="PORT_UNUSED" port_scandataout="PORT_UNUSED" width_clock=5 areset clk inclk locked
//VERSION_BEGIN 18.1 cbx_altclkbuf 2019:04:11:16:04:12:SJ cbx_altiobuf_bidir 2019:04:11:16:04:12:SJ cbx_altiobuf_in 2019:04:11:16:04:12:SJ cbx_altiobuf_out 2019:04:11:16:04:12:SJ cbx_altpll 2019:04:11:16:04:12:SJ cbx_cycloneii 2019:04:11:16:04:12:SJ cbx_lpm_add_sub 2019:04:11:16:04:12:SJ cbx_lpm_compare 2019:04:11:16:04:12:SJ cbx_lpm_counter 2019:04:11:16:04:12:SJ cbx_lpm_decode 2019:04:11:16:04:12:SJ cbx_lpm_mux 2019:04:11:16:04:12:SJ cbx_mgl 2019:04:11:16:07:46:SJ cbx_nadder 2019:04:11:16:04:12:SJ cbx_stratix 2019:04:11:16:04:12:SJ cbx_stratixii 2019:04:11:16:04:12:SJ cbx_stratixiii 2019:04:11:16:04:12:SJ cbx_stratixv 2019:04:11:16:04:12:SJ cbx_util_mgl 2019:04:11:16:04:12:SJ  VERSION_END

//synthesis_resources = fiftyfivenm_pll 1 reg 1 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
(* ALTERA_ATTRIBUTE = {"SUPPRESS_DA_RULE_INTERNAL=C104;SUPPRESS_DA_RULE_INTERNAL=R101"} *)
module  wasca_altpll_1_altpll_et22
	( 
	areset,
	clk,
	inclk,
	locked) /* synthesis synthesis_clearbox=1 */;
	input   areset;
	output   [4:0]  clk;
	input   [1:0]  inclk;
	output   locked;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri0   areset;
	tri0   [1:0]  inclk;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	reg	pll_lock_sync;
	wire  [4:0]   wire_pll7_clk;
	wire  wire_pll7_fbout;
	wire  wire_pll7_locked;

	// synopsys translate_off
	initial
		pll_lock_sync = 0;
	// synopsys translate_on
	always @ ( posedge wire_pll7_locked or  posedge areset)
		if (areset == 1'b1) pll_lock_sync <= 1'b0;
		else  pll_lock_sync <= 1'b1;
	fiftyfivenm_pll   pll7
	( 
	.activeclock(),
	.areset(areset),
	.clk(wire_pll7_clk),
	.clkbad(),
	.fbin(wire_pll7_fbout),
	.fbout(wire_pll7_fbout),
	.inclk(inclk),
	.locked(wire_pll7_locked),
	.phasedone(),
	.scandataout(),
	.scandone(),
	.vcooverrange(),
	.vcounderrange()
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_off
	`endif
	,
	.clkswitch(1'b0),
	.configupdate(1'b0),
	.pfdena(1'b1),
	.phasecounterselect({3{1'b0}}),
	.phasestep(1'b0),
	.phaseupdown(1'b0),
	.scanclk(1'b0),
	.scanclkena(1'b1),
	.scandata(1'b0)
	`ifndef FORMAL_VERIFICATION
	// synopsys translate_on
	`endif
	);
	defparam
		pll7.bandwidth_type = "auto",
		pll7.clk0_divide_by = 2,
		pll7.clk0_duty_cycle = 50,
		pll7.clk0_multiply_by = 25,
		pll7.clk0_phase_shift = "0",
		pll7.compensate_clock = "clk0",
		pll7.inclk0_input_frequency = 125000,
		pll7.operation_mode = "normal",
		pll7.pll_type = "auto",
		pll7.lpm_type = "fiftyfivenm_pll";
	assign
		clk = {wire_pll7_clk[4:0]},
		locked = (wire_pll7_locked & pll_lock_sync);
endmodule //wasca_altpll_1_altpll_et22

//synthesis_resources = fiftyfivenm_pll 1 reg 6 
//synopsys translate_off
`timescale 1 ps / 1 ps
//synopsys translate_on
module  wasca_altpll_1
	( 
	address,
	areset,
	c0,
	c1,
	c2,
	c3,
	c4,
	clk,
	configupdate,
	locked,
	phasecounterselect,
	phasedone,
	phasestep,
	phaseupdown,
	read,
	readdata,
	reset,
	scanclk,
	scanclkena,
	scandata,
	scandataout,
	scandone,
	write,
	writedata) /* synthesis synthesis_clearbox=1 */;
	input   [1:0]  address;
	input   areset;
	output   c0;
	output   c1;
	output   c2;
	output   c3;
	output   c4;
	input   clk;
	input   configupdate;
	output   locked;
	input   [2:0]  phasecounterselect;
	output   phasedone;
	input   phasestep;
	input   phaseupdown;
	input   read;
	output   [31:0]  readdata;
	input   reset;
	input   scanclk;
	input   scanclkena;
	input   scandata;
	output   scandataout;
	output   scandone;
	input   write;
	input   [31:0]  writedata;

	wire  wire_stdsync2_dout;
	wire  [4:0]   wire_sd1_clk;
	wire  wire_sd1_locked;
	(* ALTERA_ATTRIBUTE = {"POWER_UP_LEVEL=HIGH"} *)
	reg	pfdena_reg;
	wire	wire_pfdena_reg_ena;
	reg	prev_reset;
	wire  w_locked;
	wire  w_pfdena;
	wire  w_phasedone;
	wire  w_pll_areset_in;
	wire  w_reset;
	wire  w_select_control;
	wire  w_select_status;

	wasca_altpll_1_stdsync_sv6   stdsync2
	( 
	.clk(clk),
	.din(wire_sd1_locked),
	.dout(wire_stdsync2_dout),
	.reset_n((~ reset)));
	wasca_altpll_1_altpll_et22   sd1
	( 
	.areset((w_pll_areset_in | areset)),
	.clk(wire_sd1_clk),
	.inclk({{1{1'b0}}, clk}),
	.locked(wire_sd1_locked));
	// synopsys translate_off
	initial
		pfdena_reg = {1{1'b1}};
	// synopsys translate_on
	always @ ( posedge clk or  posedge reset)
		if (reset == 1'b1) pfdena_reg <= {1{1'b1}};
		else if  (wire_pfdena_reg_ena == 1'b1)   pfdena_reg <= writedata[1];
	assign
		wire_pfdena_reg_ena = (write & w_select_control);
	// synopsys translate_off
	initial
		prev_reset = 0;
	// synopsys translate_on
	always @ ( posedge clk or  posedge reset)
		if (reset == 1'b1) prev_reset <= 1'b0;
		else  prev_reset <= w_reset;
	assign
		c0 = wire_sd1_clk[0],
		c1 = wire_sd1_clk[1],
		c2 = wire_sd1_clk[2],
		c3 = wire_sd1_clk[3],
		c4 = wire_sd1_clk[4],
		locked = wire_sd1_locked,
		phasedone = 1'b0,
		readdata = {{30{1'b0}}, (read & ((w_select_control & w_pfdena) | (w_select_status & w_phasedone))), (read & ((w_select_control & w_pll_areset_in) | (w_select_status & w_locked)))},
		scandataout = 1'b0,
		scandone = 1'b0,
		w_locked = wire_stdsync2_dout,
		w_pfdena = pfdena_reg,
		w_phasedone = 1'b1,
		w_pll_areset_in = prev_reset,
		w_reset = ((write & w_select_control) & writedata[0]),
		w_select_control = ((~ address[1]) & address[0]),
		w_select_status = ((~ address[1]) & (~ address[0]));
endmodule //wasca_altpll_1
//VALID FILE
