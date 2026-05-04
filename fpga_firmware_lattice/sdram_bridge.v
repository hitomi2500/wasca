`include "timescale.v"

module pll_shifted (
    input  wire clki,      // 133 MHz input
    output wire clk_0deg,  // 133 MHz, used as feedback / internal reference
    output wire clk_shift, // 133 MHz, slightly delayed
    output wire locked
);

    // These attributes are commonly emitted by ecppll / prjtrellis-generated code.
    (* FREQUENCY_PIN_CLKI="133" *)
    (* FREQUENCY_PIN_CLKOS="133" *)
    (* FREQUENCY_PIN_CLKOP="133" *)
    (* ICP_CURRENT="12" *)
    (* LPF_RESISTOR="8" *)
    (* MFG_ENABLE_FILTEROPAMP="1" *)
    (* MFG_GMCREF_SEL="2" *)
     EHXPLLL #(
        .PLLRST_ENA("DISABLED"),
        .INTFB_WAKE("DISABLED"),
        .STDBY_ENABLE("DISABLED"),
        .DPHASE_SOURCE("DISABLED"),

        .OUTDIVIDER_MUXA("DIVA"),
        .OUTDIVIDER_MUXB("DIVB"),
        .OUTDIVIDER_MUXC("DIVC"),
        .OUTDIVIDER_MUXD("DIVD"),

        .CLKI_DIV(1),
        .CLKFB_DIV(4),

        // Shifted replica on CLKOP
        .CLKOP_ENABLE("ENABLED"),
        .CLKOP_DIV(16),
        .CLKOP_CPHASE(5),
        .CLKOP_FPHASE(0),
		// 0 0 +616ps fails
		// 1 0 +1600ps fails
		// 2 0 fails
		// 3 0 +2000ps almost works, 2-5 errors
		// 4 0 works, 0-2 errors
		// 5 0 works, 0-3 errors
		// 6 0 works, 0-3 errors
		// 7 0 +4700ps works, 0-3 errors
		// 8 0 works, 0-3 errors
		// 9 0 works, 0-4 errors
		// 10 0 works, 1-4 errors
		// 11 0 works, 0-4 errors
		// 12 0 almost works, 2-5 errors

        // Unshifted feedback clock on CLKOS
        .CLKOS_ENABLE("ENABLED"),
        .CLKOS_DIV(4),
        .CLKOS_CPHASE(3),
        .CLKOS_FPHASE(0),

        .CLKOS2_ENABLE("DISABLED"),
        .CLKOS3_ENABLE("DISABLED"),

        // Feed back the unshifted output
        .FEEDBK_PATH("CLKOS")
    ) pll_i (
        .CLKI(clki),
        .CLKFB(clk_0deg),

        .RST(1'b0),
        .STDBY(1'b0),
        .PHASESEL0(1'b0),
        .PHASESEL1(1'b0),
        .PHASEDIR(1'b0),
        .PHASESTEP(1'b1),
        .PHASELOADREG(1'b1),
        .PLLWAKESYNC(1'b0),
        .ENCLKOP(1'b0),
        .ENCLKOS(1'b0),
        .ENCLKOS2(1'b0),
        .ENCLKOS3(1'b0),

        .CLKOP(clk_shift),
        .CLKOS(clk_0deg),
        .CLKOS2(),
        .CLKOS3(),
        .LOCK(locked),

        .CLKINTFB(),
        .REFCLK(),
        .INTLOCK()
    );

endmodule

`define DIR_NONE 0
`define DIR_WRITE 1
`define DIR_READ 2

`define MODE_INIT 0
`define MODE_POWER_MEMORY_05M 1
`define MODE_POWER_MEMORY_1M 2
`define MODE_POWER_MEMORY_2M 3
`define MODE_POWER_MEMORY_4M 4
`define MODE_RAM_1M 5
`define MODE_RAM_4M 6
`define MODE_ROM_KOF95 7
`define MODE_ROM_ULTRAMAN 8
`define MODE_BOOT 9

`define SDRAM_INIT0 0
`define SDRAM_INIT1 1
`define SDRAM_INIT2 2
`define SDRAM_INIT3 3
`define SDRAM_INIT4 4
`define SDRAM_INIT5 5
`define SDRAM_IDLE 6
`define SDRAM_AUTOREFRESH 7
`define SDRAM_AUTOREFRESH2 8
`define SDRAM_ABUS_ACTIVATE 9
`define SDRAM_ABUS_READ_AND_PRECHARGE 10
`define SDRAM_ABUS_WRITE_AND_PRECHARGE 11
`define SDRAM_WISHBONE_ACTIVATE 12
`define SDRAM_WISHBONE_READ_AND_PRECHARGE 13
`define SDRAM_WISHBONE_WRITE_AND_PRECHARGE 14

`define TIMING_IDLE_TO_ACTIVATE_ABUS_READ 3  // tRCD = 21ns min ; 3 cycles @ 143mhz = 21ns
`define TIMING_IDLE_TO_ACTIVATE_ABUS_WRITE 5 // for writing we use a little longer activate delay, so that the data at the a-bus will become ready
`define TIMING_IDLE_TO_ACTIVATE_WISHBONE_RW 2 // tRCD = 21ns min ; 3 cycles @ 143mhz = 21ns
`define TIMING_IDLE_TO_PRECHARGE 2 // precharge all is fast
`define TIMING_PRECHARGE_TO_ACTIVATE 3 // tRCD = 21ns min ; 3 cycles @ 143mhz = 21ns
`define TIMING_PRECHARGE_TO_AUTOREFRESH 7 // tRC = 63ns min ; 
`define TIMING_ABUS_ACTIVATE_TO_WRITE 4 // tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
`define TIMING_ABUS_ACTIVATE_TO_READ 4 // 5 cut to 4 //tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
`define TIMING_WISHBONE_ACTIVATE_TO_WRITE 4 // tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
`define TIMING_WISHBONE_ACTIVATE_TO_READ 4 // tRP = 21ns min ; 3 cycles @ 116mhz = 25ns


module sdram_bridge (
    //common clock
    input wire clock,
    input wire sdram_clock,
    
    //A-bus slave interface
	input wire [24:1] abus_address,
	inout wire [15:0] abus_data,
	input wire [2:0] abus_chipselect,
	input wire abus_read,
	input wire [1:0] abus_write,
	output wire abus_interrupt,
	output wire abus_direction,
	output wire abus_interrupt_disable_out,
    
    //SDRAM port 1 (built into icesugar) master interface
	output reg [12:0] sdram_addr,
	output reg [1:0] sdram_ba,
	output reg sdram_cas_n,
	output reg sdram_cke,
	output reg sdram_cs_n,
	inout wire [15:0] sdram_dq,
	output reg [1:0] sdram_dqm,
	output reg sdram_ras_n,
	output reg sdram_we_n,
	output wire sdram_clk,
	
	//SDRAM port 2 (external on wasca board) master interface
	output reg [12:0] sdram2_addr,
	output reg [1:0] sdram2_ba,
	output reg sdram2_cas_n,
	output reg sdram2_cke,
	output reg sdram2_cs_n,
	inout wire [7:0] sdram2_dq,
	output wire [0:0] sdram2_dqm,
	output reg sdram2_ras_n,
	output reg sdram2_we_n,
	output wire sdram2_clk,
	
	//Wishbone SDRAM slave interface
    input wire wishbone_sdram_cyc_i,
    input wire wishbone_sdram_we_i,
    input wire [25:0] wishbone_sdram_addr_i,
    input wire [31:0] wishbone_sdram_data_i,
    input wire wishbone_sdram_stb_i,
    input wire [3:0] wishbone_sdram_sel_i,
    output wire wishbone_sdram_stall_o,
    output wire wishbone_sdram_ack_o,
    output wire [31:0] wishbone_sdram_data_o,

	//Wishbone registers slave interface
    input wire wishbone_regs_cyc_i,
    input wire wishbone_regs_we_i,
    input wire [25:0] wishbone_regs_addr_i,
    input wire [31:0] wishbone_regs_data_i,
    input wire [3:0] wishbone_regs_stb_i,
    input wire wishbone_regs_sel_i,
    output wire wishbone_regs_stall_o,
    output wire wishbone_regs_ack_o,
    output wire [31:0] wishbone_regs_data_o,

    //resets
	input wire saturn_reset,
	input wire reset,
	
	//debug 
	output wire sdram_debug_1
	);
	
	initial begin
		sdram_addr = 0;
		sdram_ba = 0;
		sdram_cas_n = 1'b1;
		sdram_cke = 1'b1;
		sdram_cs_n = 0;
		sdram_dqm = 2'b00;
		sdram_ras_n = 1'b1;
		sdram_we_n = 1'b1;
		sdram2_addr = 0;
		sdram2_ba = 0;
		sdram2_cas_n = 1'b1;
		sdram2_cke = 1'b1;
		sdram2_cs_n = 0;
		sdram2_ras_n = 1'b1;
		sdram2_we_n = 1'b1;
	end
	
    assign sdram_clk = sdram_clock;
    //assign sdram2_clk = sdram_clock;
	
	/*DELAYG #(
		.DEL_VALUE(30)  // ~ 32 quants per 1ns
	)	
	delay_line_sdram2(
    .A(sdram_clock),
    .Z(sdram2_clk)
	);*/
	
	wire sdram_clock_pll_delayed;
	//assign sdram_clk = sdram_clock_pll_delayed;
	//assign sdram2_clk = sdram_clock_pll_delayed;

	pll_shifted delay_pll_sdram2(
		.clki(sdram_clock),
    	.clk_0deg(),
    	.clk_shift(sdram2_clk),
    	.locked()
	);
	
	wire [25:0] wishbone_regs_address = wishbone_regs_addr_i;
	wire [31:0] wishbone_regs_writedata = wishbone_regs_data_i;
	reg [31:0] wishbone_regs_readdata;
	initial wishbone_regs_readdata = 0;
	assign wishbone_regs_data_o = wishbone_regs_readdata;
	wire wishbone_regs_write = wishbone_regs_we_i;
	wire wishbone_regs_read = wishbone_regs_sel_i && ~wishbone_regs_we_i;
	reg wishbone_regs_readdatavalid;
	initial wishbone_regs_readdatavalid = 0;
	reg wishbone_regs_write_ff1;
	always @(posedge clock) wishbone_regs_write_ff1 <= wishbone_regs_we_i;
	assign wishbone_regs_ack_o = wishbone_regs_readdatavalid || wishbone_regs_write_ff1;
	
	wire [25:0] wishbone_sdram_address = wishbone_sdram_addr_i;
	wire [31:0] wishbone_sdram_writedata = wishbone_sdram_data_i;
	wire [31:0] wishbone_sdram_readdata;
	assign wishbone_sdram_data_o = wishbone_sdram_readdata;
	wire wishbone_sdram_write = wishbone_sdram_we_i;
	wire wishbone_sdram_read = wishbone_sdram_sel_i && ~wishbone_sdram_we_i;
	reg wishbone_sdram_readdatavalid;
	initial wishbone_sdram_readdatavalid = 0;
	//reg wishbone_sdram_readdatavalid_toggle;
	//initial wishbone_sdram_readdatavalid_toggle = 0;
	//reg wishbone_sdram_readdatavalid_toggle_d1;
	//initial wishbone_sdram_readdatavalid_toggle_d1 = 0;
	reg wishbone_sdram_waitrequest;
	initial wishbone_sdram_waitrequest = 0;
	assign wishbone_sdram_stall_o = 0;//not supported by toplevel
	wire [1:0] wishbone_sdram_byteenable = wishbone_sdram_sel_i[1:0];
	
	reg [15:0] sdram_dq_out;
	initial sdram_dq_out = 0;
	reg [31:0] sdram2_dq_out_reg;
	initial sdram2_dq_out_reg = 0;
	reg sdram_dq_oe;
	initial sdram_dq_oe = 0;
	reg sdram2_dq_oe_pre;
	reg sdram2_dq_oe_pre2;
	reg sdram2_dq_oe_pre3;
	reg sdram2_dq_oe;
	initial sdram2_dq_oe_pre = 0;
	initial sdram2_dq_oe_pre2 = 0;
	initial sdram2_dq_oe_pre3 = 0;
	initial sdram2_dq_oe = 0;
	always @(posedge sdram_clock) sdram2_dq_oe_pre2 <= sdram2_dq_oe_pre;
	always @(posedge sdram_clock) sdram2_dq_oe_pre3 <= sdram2_dq_oe_pre2;
	always @(posedge sdram_clock) sdram2_dq_oe <= sdram2_dq_oe_pre3;
	wire [15:0] sdram_dq_in;
	wire [7:0] sdram2_dq_in;
	assign sdram_dq = (sdram_dq_oe) ? sdram_dq_out : {16{1'bZ}};
	reg [15:0] sdram_dq_in_dummy_pipeline1;
	reg [15:0] sdram_dq_in_dummy_pipeline2;
	always @(posedge sdram_clk) sdram_dq_in_dummy_pipeline1 <= sdram_dq;
	always @(posedge sdram_clk) sdram_dq_in_dummy_pipeline2 <= sdram_dq_in_dummy_pipeline1;
	assign sdram_dq_in = sdram_dq;
	//reg sdram2_dq_oe_delay1;
	//always @(posedge sdram_clock) sdram2_dq_oe_delay1 <= (sdram2_dq_oe || sdram2_dq_oe_pre);
	assign sdram2_dq = (sdram2_dq_oe || sdram2_dq_oe_pre || sdram2_dq_oe_pre2 || sdram2_dq_oe_pre3) ? sdram2_dq_out_reg[7:0] : {8{1'bZ}};
	reg [7:0] sdram2_dq_in_dummy_pipeline1;
	always @(posedge sdram2_clk) sdram2_dq_in_dummy_pipeline1 <= sdram2_dq;
	assign sdram2_dq_in = sdram2_dq;
	reg [1:0] sdram2_dqm_reg;
	initial sdram2_dqm_reg = 2'b0;
	assign sdram2_dqm[0] = sdram2_dqm_reg[0];
	
	reg [24:1] abus_address_ms;
	initial abus_address_ms = 0;
	reg [24:1] abus_address_buf;
	initial abus_address_buf = 0;
	reg [15:0] abus_data_ms;
	initial abus_data_ms = 0;
	reg [15:0] abus_data_buf;
	initial abus_data_buf = 0;
	reg [2:0] abus_chipselect_ms;
	initial abus_chipselect_ms = 0;
	reg [2:0] abus_chipselect_buf;
	initial abus_chipselect_buf = 0;
	reg abus_read_ms;
	initial abus_read_ms = 0;
	reg abus_read_buf;
	initial abus_read_buf = 0;
    reg [1:0] abus_write_ms;
	initial abus_write_ms = 0;
    reg [1:0] abus_write_buf;
	initial abus_write_buf = 0;
    reg abus_read_buf2;
	initial abus_read_buf2 = 0;
    reg abus_read_buf3;
	initial abus_read_buf3 = 0;
    reg abus_read_buf4;
	initial abus_read_buf4 = 0;
    reg abus_read_buf5;
	initial abus_read_buf5 = 0;
    reg abus_read_buf6;
	initial abus_read_buf6 = 0;
    reg abus_read_buf7;
	initial abus_read_buf7 = 0;
    reg [1:0] abus_write_buf2;
	initial abus_write_buf2 = 0;
    reg [2:0] abus_chipselect_buf2;
	initial abus_chipselect_buf2 = 0;
    wire abus_read_pulse;
    wire [1:0] abus_write_pulse;
    wire [2:0] abus_chipselect_pulse;
    wire abus_read_pulse_off;
    wire [1:0] abus_write_pulse_off;
    wire [2:0] abus_chipselect_pulse_off;
    wire abus_anypulse; 
    reg abus_anypulse2;
    initial abus_anypulse2 = 0;
    reg abus_anypulse3; 
    initial abus_anypulse3 = 0;
    wire abus_anypulse_off; 
    wire abus_cspulse; 
    reg abus_cspulse2;
    initial abus_cspulse2 = 0;
    reg abus_cspulse3; 
    initial abus_cspulse3 = 0;
    reg abus_cspulse4; 
    initial abus_cspulse4 = 0;
    reg abus_cspulse5; 
    initial abus_cspulse5 = 0;
    reg abus_cspulse6; 
    initial abus_cspulse6 = 0;
    reg abus_cspulse7; 
    initial abus_cspulse7 = 0;
    wire abus_cspulse_off;
    reg [24:1] abus_address_latched;
	initial abus_address_latched = 0;
    reg abus_cs0_regs_access;
	initial abus_cs0_regs_access = 0;
    reg abus_cs1_regs_access;
	initial abus_cs1_regs_access = 0;
    reg [1:0] abus_chipselect_latched;
    initial abus_chipselect_latched = 0;
    reg abus_direction_internal; 
    initial abus_direction_internal = 0;
    reg [15:0] abus_data_out;
    initial abus_data_out = 0;
    wire [15:0] abus_data_in;

    // SH2 regs
    reg [15:0] REG_PCNTR;
    initial REG_PCNTR = 0;
    reg [15:0] REG_STATUS;
    initial REG_STATUS = 0;
    reg [15:0] REG_MODE;
    initial REG_MODE = 0;
    reg [15:0] REG_HWVER;
    initial REG_HWVER = 0;
    reg [15:0] REG_SWVER;
    initial REG_SWVER = 0;
    reg [63:0] REG_MAPPER_READ;
    initial REG_MAPPER_READ = 0;
    reg [63:0] REG_MAPPER_WRITE;
    initial REG_MAPPER_WRITE = 0;
    
    //------------------- sdram signals ---------------
    reg sdram_abus_pending; //abus request is detected and should be parsed
    reg sdram_abus_complete; 
    reg [2:0] sdram_wait_counter; 
    //refresh interval should be no bigger than 7.8us = 906 clock cycles
    //to keep things simple, perfrorm autorefresh at 512 cycles
    reg [15:0] sdram_init_counter; 
    reg [9:0] sdram_autorefresh_counter; 
    reg [15:0] sdram_datain_latched; 
    reg [15:0] sdram2_datain_latched; 

    reg wishbone_sdram_complete;
    reg wishbone_sdram_reset_pending_sdram;
    wire wishbone_sdram_reset_pending_mcu;
    reg wishbone_sdram_read_pending_mcu;
    reg wishbone_sdram_read_pending_sdram;
    reg wishbone_sdram_write_pending_mcu;
    reg wishbone_sdram_write_pending_sdram;
    reg [25:0] wishbone_sdram_pending_address; 
    reg [31:0] wishbone_sdram_pending_data; 
    reg [31:0] wishbone_sdram_readdata_latched;
    reg wishbone_sdram_write_ff1;
    reg wishbone_sdram_write_ff2;
    reg wishbone_sdram_read_ff1;
    reg wishbone_sdram_read_ff2;

    reg wishbone_regs_readdatavalid_p1;

    //reg [7:0] counter_filter_control; 
    reg counter_reset;
    reg counter_count_read;
    reg counter_count_write;
    //reg [31:0] counter_value; 
    reg [7:0] sniffer_filter_control; 
    reg [15:0] sniffer_data_in; 
    reg [15:0] sniffer_data_in_p1; 
    wire [15:0] sniffer_data_out; 
    reg [15:0] sniffer_prefifo; 
    reg sniffer_prefifo_full; 
    reg sniffer_data_write;
    reg sniffer_data_ack;
    wire [9:0] sniffer_fifo_content_size; 
    wire sniffer_fifo_empty;
    wire sniffer_fifo_full;
    reg [15:0] sniffer_last_active_block; 
    reg sniffer_pending_set; 
    reg sniffer_pending_reset; 
    reg sniffer_pending_flag; 
    reg sniffer_pending_flag_d1; 
    wire sniffer_pending_flag_pulse;
    reg [15:0] sniffer_pending_block; 
    reg sniffer_pending_timeout; 
    reg [20:0] sniffer_pending_timeout_counter; 

    reg mapper_write_enable;
    reg mapper_read_enable;

    reg [2:0] my_little_transaction_dir;
    reg [3:0] wasca_mode;
    reg [3:0] sdram_mode;
    
    wire [2:0] sdram_wait_counter_negedge; 
    wire [3:0] sdram_mode_negedge;
	wire abus_chipselect_buf0_negedge;
	wire abus_chipselect_buf1_negedge;
	wire wishbone_sdram_pending_address24_negedge;
	
	reg sdram2_delayed_read_abus;
	reg sdram2_delayed_read_wishbone;
    
// synopsys translate_off
    time ABUS_request_time;
// synopsys translate_on

    reg sdram_debug_read_1;
    reg sdram_debug_read_1_d1;
    reg sdram_debug_read_1_d2;
    reg sdram_debug_read_2;
    reg sdram_debug_read_2_d1;
    reg sdram_debug_read_2_d2;
    
    initial begin
        sdram_abus_pending = 0;
        sdram_abus_complete = 0;
        sdram_wait_counter = 0;
		sdram_init_counter = 0;
        sdram_autorefresh_counter = 0;
        sdram_datain_latched = 0;
        sdram2_datain_latched = 0;
    
        wishbone_sdram_complete = 0;
        wishbone_sdram_reset_pending_sdram = 0;
        wishbone_sdram_read_pending_mcu = 0;
        wishbone_sdram_read_pending_sdram = 0;
        wishbone_sdram_write_pending_mcu = 0;
        wishbone_sdram_write_pending_sdram = 0;
        wishbone_sdram_pending_address = 0;
        wishbone_sdram_pending_data = 0;
        wishbone_sdram_readdata_latched = 0;
        wishbone_sdram_write_ff1 = 0;
        wishbone_sdram_write_ff2 = 0;
        wishbone_sdram_read_ff1 = 0;
        wishbone_sdram_read_ff2 = 0;
    
        wishbone_regs_readdatavalid_p1 = 0;
    
        //counter_filter_control = 0;
        counter_reset = 0;
        counter_count_read = 0;
        counter_count_write = 0;
        //counter_value = 0;
    
        sniffer_filter_control = 0;
        sniffer_data_in = 0;
        sniffer_data_in_p1 = 0;
        sniffer_prefifo = 0;
        sniffer_prefifo_full = 0;
        sniffer_data_write = 0;
        sniffer_data_ack = 0;
        sniffer_last_active_block = 0;
        sniffer_pending_set = 0;
        sniffer_pending_reset = 0;
        sniffer_pending_flag = 0;
        sniffer_pending_flag_d1 = 0;
        sniffer_pending_block = 0;
        sniffer_pending_timeout = 0;
        sniffer_pending_timeout_counter = 0;
    
        mapper_write_enable = 0;
        mapper_read_enable = 0;
    
        my_little_transaction_dir = 0;
        wasca_mode = 0;
        sdram_mode = 0;
        
        /*sdram_wait_counter_negedge = 0;
		sdram_mode_negedge = 0;
		abus_chipselect_buf0_negedge = 0;
		wishbone_sdram_pending_address24_negedge = 0;*/
		
		sdram2_delayed_read_abus = 0;
		sdram2_delayed_read_wishbone = 0;
		
		sdram_debug_read_1 = 0;
		sdram_debug_read_1_d1 = 0;
		sdram_debug_read_1_d2 = 0;
		sdram_debug_read_2 = 0;
		sdram_debug_read_2_d1 = 0;
		sdram_debug_read_2_d2 = 0;
    end

    assign abus_direction = abus_direction_internal;
	
	//we won't be aserting interrupt and waitrequest. because we can. can we?
	assign abus_interrupt = 1'b1;
	assign abus_interrupt_disable_out = 1'b1; //disabling waitrequest & int outputs, so they're tristate
	
	//ignoring functioncode, timing and addressstrobe for now
	
	//abus transactions are async, so first we must latch incoming signals to get rid of metastability
	//1st stage
	always @(posedge sdram_clock) abus_address_ms <= abus_address;
	always @(posedge sdram_clock) abus_data_ms <= abus_data;
	always @(posedge sdram_clock) abus_chipselect_ms <= abus_chipselect; //work only with CS1 for now
	always @(posedge sdram_clock) abus_read_ms <= abus_read;
	always @(posedge sdram_clock) abus_write_ms <= abus_write;
    //2nd stage
	always @(posedge sdram_clock) abus_address_buf <= abus_address_ms;
	always @(posedge sdram_clock) abus_data_buf <= abus_data_ms;
	always @(posedge sdram_clock) abus_chipselect_buf <= abus_chipselect_ms;
	always @(posedge sdram_clock) abus_read_buf <= abus_read_ms;
	always @(posedge sdram_clock) abus_write_buf <= abus_write_ms;
		
	//abus read/write latch
	always @(posedge sdram_clock) abus_write_buf2 <= abus_write_buf;
	always @(posedge sdram_clock) abus_read_buf2 <= abus_read_buf;
	always @(posedge sdram_clock) abus_read_buf3 <= abus_read_buf2;
	always @(posedge sdram_clock) abus_read_buf4 <= abus_read_buf3;
	always @(posedge sdram_clock) abus_read_buf5 <= abus_read_buf4;
	always @(posedge sdram_clock) abus_read_buf6 <= abus_read_buf5;
	always @(posedge sdram_clock) abus_read_buf7 <= abus_read_buf6;
	always @(posedge sdram_clock) abus_chipselect_buf2 <= abus_chipselect_buf;
	always @(posedge sdram_clock) abus_anypulse2 <= abus_anypulse;
	always @(posedge sdram_clock) abus_anypulse3 <= abus_anypulse2;
	always @(posedge sdram_clock) abus_cspulse2 <= abus_cspulse;
	always @(posedge sdram_clock) abus_cspulse3 <= abus_cspulse2;
	always @(posedge sdram_clock) abus_cspulse4 <= abus_cspulse3;
	always @(posedge sdram_clock) abus_cspulse5 <= abus_cspulse4;
	always @(posedge sdram_clock) abus_cspulse6 <= abus_cspulse5;
	always @(posedge sdram_clock) abus_cspulse7 <= abus_cspulse6;
	
	//abus write/read pulse is a falling edge since read and write signals are negative polarity
	assign abus_write_pulse = abus_write_buf & ~abus_write_ms;
	assign abus_read_pulse = abus_read_buf & ~abus_read_ms;
	assign abus_chipselect_pulse = abus_chipselect_buf & ~abus_chipselect_ms;
	assign abus_write_pulse_off = abus_write_ms & ~abus_write_buf;
	assign abus_read_pulse_off = abus_read_ms & ~abus_read_buf;
	assign abus_chipselect_pulse_off = abus_chipselect_ms & ~abus_chipselect_buf;
	
	assign abus_anypulse = abus_write_pulse[0] || abus_write_pulse[1] || abus_read_pulse || 
				abus_chipselect_pulse[0] || abus_chipselect_pulse[1] || abus_chipselect_pulse[2];
	assign abus_anypulse_off = abus_write_pulse_off[0] || abus_write_pulse_off[1] || abus_read_pulse_off || 
				abus_chipselect_pulse_off[0] || abus_chipselect_pulse_off[1] || abus_chipselect_pulse_off[2];
	assign abus_cspulse = abus_chipselect_pulse[0] || abus_chipselect_pulse[1] || abus_chipselect_pulse[2];
	assign abus_cspulse_off = abus_chipselect_pulse_off[0] || abus_chipselect_pulse_off[1] || abus_chipselect_pulse_off[2];
				
	//whatever pulse we've got, latch address
	//it might be latched twice per transaction, but it's not a problem
	//multiplexer was switched to address after previous transaction or after boot,
	//so we have address ready to latch
	//patching : for RAM 1M mode A19 and A20 should be set to zero
	always @(posedge sdram_clock) 
	   if (abus_cspulse)
			abus_address_latched <=  ( (wasca_mode == `MODE_RAM_1M) && (abus_address[24:21] == 4'h2) ) ? 
	   { abus_address[24:21], 2'b0,abus_address[18:1]} : abus_address;

	always @(posedge sdram_clock) abus_cs0_regs_access <= (abus_address[24:5] == {17'h1FFFF,3'b111}) ? 1'b1 : 0;
	always @(posedge sdram_clock) abus_cs1_regs_access <= (abus_address[23:2] == {20'hFFFFF,2'b11}) ? 1'b1 : 0;
									
	//mapper write enable decode
	always @(posedge sdram_clock)
	   if (~abus_chipselect_buf[0])
	       mapper_write_enable <= REG_MAPPER_WRITE[$unsigned(abus_address_latched[24:20])];
	   else if (~abus_chipselect_buf[1])
	       mapper_write_enable <= REG_MAPPER_WRITE[32+$unsigned(abus_address_latched[23:20])];
	   else if (~abus_chipselect_buf[2])
	       mapper_write_enable <= REG_MAPPER_WRITE[48];
	   
    //mapper read enable decode
	always @(posedge sdram_clock)
	   if (~abus_chipselect_buf[0])
	       mapper_read_enable <= REG_MAPPER_READ[$unsigned(abus_address_latched[24:20])];
	   else if (~abus_chipselect_buf[1])
	       mapper_read_enable <= REG_MAPPER_READ[32+$unsigned(abus_address_latched[23:20])];
	   else if (~abus_chipselect_buf[2])
	       mapper_read_enable <= REG_MAPPER_READ[48];
	
	//latch transaction direction
	always @(posedge sdram_clock)
	   if ( ( (abus_write_pulse[0]) || (abus_write_pulse[1]) ) && mapper_write_enable)
	       my_little_transaction_dir <= 2'd`DIR_WRITE;
	   else if (abus_read_pulse)
	       my_little_transaction_dir <= 2'd`DIR_READ;
	   else if (abus_anypulse_off && ~abus_cspulse_off) //ending anything but not cs
	       my_little_transaction_dir <= 2'd`DIR_NONE;

	//latch chipselect number
	always @(posedge sdram_clock)
	   if (abus_chipselect_pulse[0])
	       abus_chipselect_latched <= "00";
	   else if (abus_chipselect_pulse[1])
	       abus_chipselect_latched <= "01";
	   else if (abus_chipselect_pulse[2])
	       abus_chipselect_latched <= "10";
	   else if (abus_cspulse_off)
	       abus_chipselect_latched <= "11";
	
	//if valid transaction captured, switch to corresponding multiplex mode
	always @(posedge sdram_clock)
	   if (abus_chipselect_latched == 2'b11)
	       //chipselect deasserted
	       abus_direction_internal <= 0; //high-z
	   else
	       //chipselect asserted
	       case (my_little_transaction_dir)
	           `DIR_NONE : abus_direction_internal <= 0; //high-z
	           `DIR_READ : abus_direction_internal <= mapper_read_enable; //active
	           `DIR_WRITE : abus_direction_internal <= 0; //high-z
	           default   : abus_direction_internal <= 0; //high-z
	       endcase
		
	//sync mux for abus read requests
	always @(posedge sdram_clock)
	   if (abus_chipselect_latched == 2'b0) begin
	       //CS0 access
		   if (abus_cs0_regs_access)
		   		case (abus_address_latched[4:1])
					4'h0 : abus_data_out <= 16'hCDCD; //wasca specific SD card control register	   
					4'h8 :abus_data_out <= REG_PCNTR; //wasca prepare counter
					4'h9 :abus_data_out <= REG_STATUS; //wasca status register
					4'ha :abus_data_out <= REG_MODE; //wasca mode register
					4'hb :abus_data_out <= REG_HWVER; //wasca hwver register
					4'hc :abus_data_out <= REG_SWVER; //wasca swver register
					4'hd :abus_data_out <= 16'h7761; //wasca signature "wa"
					4'he :abus_data_out <= 16'h7363; //wasca signature "sc"
					4'hf :abus_data_out <= 16'h6120; //wasca signature "a "
				endcase
	       else //normal CS0 read access
		   	   //just output sdram data, no matter the mode
			   abus_data_out <= {sdram_datain_latched[7:0], sdram_datain_latched [15:8]};
			end
	   else if (abus_chipselect_latched == 2'b1) begin //CS1 access
	       if (abus_cs1_regs_access)//saturn cart id register
	           case (wasca_mode)
	               `MODE_INIT: abus_data_out <= {sdram2_datain_latched[7:0],sdram2_datain_latched[15:8]};
	               `MODE_POWER_MEMORY_05M : abus_data_out <= 16'hFF21;
	               `MODE_POWER_MEMORY_1M : abus_data_out <= 16'hFF22;
	               `MODE_POWER_MEMORY_2M : abus_data_out <= 16'hFF23;
	               `MODE_POWER_MEMORY_4M : abus_data_out <= 16'hFF24;
	               `MODE_RAM_1M : abus_data_out <= 16'hFF5A;
	               `MODE_RAM_4M : abus_data_out <= 16'hFF5C;
	               `MODE_ROM_KOF95 : abus_data_out <= 16'hFFFF;
	               `MODE_ROM_ULTRAMAN : abus_data_out <= 16'hFFFF;
	               `MODE_BOOT : abus_data_out <= 16'hFFFF;
				endcase
			else
				abus_data_out <= {sdram2_datain_latched[7:0],sdram2_datain_latched[15:8]};
			end
		else //CS2 or dummy access
		    ;//abus_data_out <= 16'hEEEE;
	
	//wasca mode register write
	always @(posedge sdram_clock)
	    //if (~saturn_reset) wasca_mode  <= MODE_INIT;
	    if ( (my_little_transaction_dir == `DIR_WRITE) && (abus_chipselect_latched == 2'b0) && (abus_cspulse7) &&
			(abus_cs0_regs_access) && (abus_address_latched[4:1] == {1'h1,3'h2}) ) begin
	        //wasca mode register
	        REG_MODE <= abus_data_in;
	        case (abus_data_in[3:0])
	            4'h1: wasca_mode  <= `MODE_POWER_MEMORY_05M;
	            4'h2: wasca_mode  <= `MODE_POWER_MEMORY_1M;
	            4'h3: wasca_mode  <= `MODE_POWER_MEMORY_2M;
	            4'h4: wasca_mode  <= `MODE_POWER_MEMORY_4M;
	            default:
	                case (abus_data_in[7:4])
	                    4'h1: wasca_mode  <= `MODE_RAM_1M;
	                    4'h2: wasca_mode  <= `MODE_RAM_4M;
	                    default:
	                        case (abus_data_in[11:8])
	                            4'h1: wasca_mode  <= `MODE_ROM_KOF95;
	                            4'h2: wasca_mode  <= `MODE_ROM_ULTRAMAN;
	                            endcase
	                    endcase
			    endcase
			end
		else if ( (wishbone_regs_write) && (wishbone_regs_address[7:0] == 8'hF4) ) begin
            REG_MODE <= wishbone_regs_writedata;
            case (wishbone_regs_writedata[3:0])
	            4'h1: wasca_mode  <= `MODE_POWER_MEMORY_05M;
	            4'h2: wasca_mode  <= `MODE_POWER_MEMORY_1M;
	            4'h3: wasca_mode  <= `MODE_POWER_MEMORY_2M;
	            4'h4: wasca_mode  <= `MODE_POWER_MEMORY_4M;
	            default:
	                case (wishbone_regs_writedata[7:4])
	                    4'h1: wasca_mode  <= `MODE_RAM_1M;
	                    4'h2: wasca_mode  <= `MODE_RAM_4M;
	                    default:
	                        case (wishbone_regs_writedata[11:8])
	                            4'h1: wasca_mode  <= `MODE_ROM_KOF95;
	                            4'h2: wasca_mode  <= `MODE_ROM_ULTRAMAN;
	                            endcase
	                    endcase
			    endcase
			end        
	
	assign abus_data_in = abus_data;//abus_data_buf;
	assign abus_data = abus_direction_internal ? abus_data_out : {16{1'bZ}};

	//wishbone regs read interface
	always @(posedge clock) wishbone_regs_readdatavalid_p1 <= wishbone_regs_read;

	always @(posedge clock)
	   if ( (wishbone_regs_read) && (wishbone_regs_address[3:0] == 4'h5) )
	       sniffer_data_ack <= 1'b1;
       else
           sniffer_data_ack <= 0;
	
	always @(posedge clock)
	   if (wishbone_regs_read)
	       case (wishbone_regs_address[3:0])
	           4'h0 : wishbone_regs_readdata <= {16'b0,REG_PCNTR};
	           4'h1 : wishbone_regs_readdata <= {16'b0,REG_STATUS};
	           4'h2 : wishbone_regs_readdata <= {16'b0,REG_MODE};
	           4'h3 : wishbone_regs_readdata <= {16'b0,REG_HWVER};
	           4'h4 : wishbone_regs_readdata <= {16'b0,REG_SWVER};
	           4'h5 : wishbone_regs_readdata <= sniffer_data_out;
	           //4'h6 : wishbone_regs_readdata <= {24'h0, counter_filter_control};//disabled for now
	           //4'h7 : wishbone_regs_readdata <= counter_value[31:0];//disabled for now
	           4'h8 : wishbone_regs_readdata <= {4'h0, sniffer_fifo_full, sniffer_fifo_content_size, 8'h0, sniffer_filter_control};
	           4'h9 : wishbone_regs_readdata <= REG_MAPPER_READ[31:0];
	           4'ha : wishbone_regs_readdata <= REG_MAPPER_READ[63:32];
	           4'hb : wishbone_regs_readdata <= REG_MAPPER_WRITE[31:0];
	           4'hc : wishbone_regs_readdata <= REG_MAPPER_WRITE[63:32];
	           default : wishbone_regs_readdata <= {16'b0,REG_HWVER}; //to simplify mux
	           endcase
	
	always @(posedge clock) wishbone_regs_readdatavalid <= wishbone_regs_readdatavalid_p1;
	
	//wishbone regs write interface
	always @(posedge clock)
	   if ( (wishbone_regs_write) && (wishbone_regs_address[3:0] == 4'hd) )
	       counter_reset <= 1'b1;
       else
           counter_reset <= 0;
           
    always @(posedge clock)
	   if (wishbone_regs_write)
	       case (wishbone_regs_address[3:0])
	           4'h0 : REG_PCNTR <= wishbone_regs_writedata;
	           4'h1 : REG_STATUS <= wishbone_regs_writedata;
	           //REG_MODE is readonly here
	           //REG_HWVER is readonly
	           4'h4 : REG_SWVER <= wishbone_regs_writedata;
	           //sniffer_data_out is readonly
	           //4'h6 : counter_filter_control <= wishbone_regs_writedata[7:0];//disabled for now
	           //counter_value is readonly
	           4'h8 : sniffer_filter_control <= wishbone_regs_writedata[7:0];
	           4'h9 : REG_MAPPER_READ[31:0] <= wishbone_regs_writedata;
	           4'ha : REG_MAPPER_READ[63:32] <= wishbone_regs_writedata;
	           4'hb : REG_MAPPER_WRITE[31:0] <= wishbone_regs_writedata;
	           4'hc : REG_MAPPER_WRITE[63:32] <= wishbone_regs_writedata;
	           //D is counter reset
	       endcase

	//wishbone regs interface is only regs, so always ready to write.
	assign wishbone_regs_stall_o = 0;	
	
	//---------------------- sdram wishbone interface -------------------
	
		       
	pulsesync wishbone_sdram_reset_pending_sync (
	   .src_clk(sdram_clock),
	   .src_pulse(wishbone_sdram_reset_pending_sdram),
	   .dst_clk(clock),
	   .dst_pulse(wishbone_sdram_reset_pending_mcu)
	);
	
	//to talk to sdram interface, wishbone requests are latched until sdram is ready to process them
	always @(posedge clock)
	   if (wishbone_sdram_reset_pending_mcu)
	       wishbone_sdram_read_pending_mcu <= 0;
	   else if (wishbone_sdram_read)
	       wishbone_sdram_read_pending_mcu <= 1'b1;
	       
    always @(posedge sdram_clock) wishbone_sdram_read_ff1 <= wishbone_sdram_read;
    always @(posedge sdram_clock) wishbone_sdram_read_ff2 <= wishbone_sdram_read_ff1;
	
	always @(posedge sdram_clock)
	   if (wishbone_sdram_reset_pending_sdram)
	       wishbone_sdram_read_pending_sdram <= 0;
	   else if (wishbone_sdram_read_ff1 && ~wishbone_sdram_read_ff2)
	       wishbone_sdram_read_pending_sdram <= 1'b1;	
	       
	always @(posedge clock)
	   if (wishbone_sdram_reset_pending_mcu)
	       wishbone_sdram_write_pending_mcu <= 0;
	   else if (wishbone_sdram_write)
	       wishbone_sdram_write_pending_mcu <= 1'b1;

    always @(posedge sdram_clock) wishbone_sdram_write_ff1 <= wishbone_sdram_write;
    always @(posedge sdram_clock) wishbone_sdram_write_ff2 <= wishbone_sdram_write_ff1;

	always @(posedge sdram_clock)
	   if (wishbone_sdram_reset_pending_sdram)
	       wishbone_sdram_write_pending_sdram <= 0;
	   else if (wishbone_sdram_write_ff1 && ~wishbone_sdram_write_ff2)
	       wishbone_sdram_write_pending_sdram <= 1'b1;	       	
	       
	always @(posedge sdram_clock)
	   if (wishbone_sdram_read_ff1 && ~wishbone_sdram_read_ff2)
	       wishbone_sdram_pending_address <= wishbone_sdram_address[25:0];
	   else if (wishbone_sdram_write_ff1 && ~wishbone_sdram_write_ff2)
	       wishbone_sdram_pending_address <= wishbone_sdram_address[25:0];

	always @(posedge clock)
	   if (wishbone_sdram_write)
	       wishbone_sdram_pending_data <= wishbone_sdram_writedata;
	       
	assign wishbone_sdram_readdata = wishbone_sdram_readdata_latched;
	
	//wishbone_sdram_readdata_latched should be set by sdram interface directly
	
	//clock transfer for wishbone ack
	pulsesync readdatavalid_sync (
	   .src_clk(sdram_clock),
	   .src_pulse(wishbone_sdram_readdatavalid),
	   .dst_clk(clock),
	   .dst_pulse(wishbone_sdram_ack_o)
	);
	/*always @(posedge sdram_clock)
	   if (wishbone_sdram_readdatavalid)
	       wishbone_sdram_readdatavalid_toggle = ~wishbone_sdram_readdatavalid_toggle;
	       
	always @(posedge clock) wishbone_sdram_readdatavalid_toggle_d1 <= wishbone_sdram_readdatavalid_toggle;

	always @(posedge clock)
	   if (wishbone_sdram_readdatavalid_toggle ^ wishbone_sdram_readdatavalid_toggle_d1)
	       wishbone_sdram_ack_o = 1'b1;
	   else
	       wishbone_sdram_ack_o = 0;*/	

	//------------------------------ SDRAM stuff ---------------------------------------
	
	// abus pending flag.
	//	abus_anypulse might appear up to 3-4 times at transaction start, so we shouldn't issue ack until at least 3-4 cycles from the start
	always @(posedge sdram_clock)
	   if (abus_cspulse2) begin
	       // synopsys translate_off
	   	   if (sdram_abus_pending)
	   	       $display ("ABUS ERROR at time %t: access when previous is pending", $time);
	   	   // synopsys translate_on
	       sdram_abus_pending <= 1'b1;
	       ABUS_request_time <= $time;
	       end
	    else if (sdram_abus_complete)
	       sdram_abus_pending <= 0;

    always @(posedge sdram_clock) begin
        sdram_autorefresh_counter <= sdram_autorefresh_counter + 10'b1;
        sdram2_dq_out_reg[7:0] <= sdram2_dq_out_reg[15:8];
        sdram2_dq_out_reg[15:8] <= sdram2_dq_out_reg[23:16];
        sdram2_dq_out_reg[23:16] <= sdram2_dq_out_reg[31:24];
        sdram2_dqm_reg[0] <= sdram2_dqm_reg[1];
        case (sdram_mode)
            `SDRAM_INIT0 : begin
            	//first stage init. cke off, dqm high,  others in nop command
                sdram_cas_n <= 1'b1;
                sdram_cke <= 0;
                sdram_dq_oe <= 0;
                sdram_dqm <= 2'b11;
                sdram2_cas_n <= 1'b1;
                sdram2_cke <= 0;
                sdram2_dq_oe_pre <= 0;
                sdram2_dqm_reg <= 2'b11;
                sdram_init_counter <= sdram_init_counter + 16'b1;
				wishbone_sdram_readdatavalid <= 0;
                if (sdram_init_counter[15]) begin 
                    // 282 us from the start elapsed, moving to next init                    
                    sdram_init_counter <= 0;
                    sdram_mode <= `SDRAM_INIT1;
                    end
                end
                
            `SDRAM_INIT1 : begin
            	//another stage init. cke on, dqm high, set other pin
                sdram_cas_n <= 1'b1;
                sdram_cke <= 1'b1;
                sdram2_cas_n <= 1'b1;
                sdram2_cke <= 1'b1;
                sdram_init_counter <= sdram_init_counter + 16'b1;
                if (sdram_init_counter[10]) begin 
                    // some smaller time elapsed, moving to next init - issue "precharge all"
                    sdram_mode <= `SDRAM_INIT2;
                    sdram_ras_n <= 0;
                    sdram_we_n <= 0;
                    sdram_addr[10] <= 1'b1;
                    sdram2_ras_n <= 0;
                    sdram2_we_n <= 0;
                    sdram2_addr[10] <= 1'b1;
                    sdram_init_counter <= 0;
                    end
                end
                
            `SDRAM_INIT2 : begin
            	//move on with init
                sdram_ras_n <= 1'b1;
                sdram_we_n <= 1'b1;
                sdram_addr[10] <= 0;
                sdram2_ras_n <= 1'b1;
                sdram2_we_n <= 1'b1;
                sdram2_addr[10] <= 0;
                sdram_init_counter <= sdram_init_counter + 16'b1;
                if (sdram_init_counter[2]) begin 
				    // issue "auto refresh"                    
                    sdram_mode <= `SDRAM_INIT3;
                    sdram_ras_n <= 0;
                    sdram_cas_n <= 0;
                    sdram2_ras_n <= 0;
                    sdram2_cas_n <= 0;
                    sdram_init_counter <= 0;
                    end
                end
                
            `SDRAM_INIT3 : begin
            	//move on with init
                sdram_ras_n <= 1'b1;
                sdram_cas_n <= 1'b1;
                sdram2_ras_n <= 1'b1;
                sdram2_cas_n <= 1'b1;
                sdram_init_counter <= sdram_init_counter + 16'b1;
				if (sdram_init_counter[3]) begin 
				    // issue "auto refresh"                    
                    sdram_mode <= `SDRAM_INIT4;
                    sdram_ras_n <= 0;
                    sdram_cas_n <= 0;
                    sdram2_ras_n <= 0;
                    sdram2_cas_n <= 0;
                    sdram_init_counter <= 0;
                    end
                end
                
            `SDRAM_INIT4 : begin
            	//move on with init
                sdram_ras_n <= 1'b1;
                sdram_cas_n <= 1'b1;
                sdram2_ras_n <= 1'b1;
                sdram2_cas_n <= 1'b1;
                sdram_init_counter <= sdram_init_counter + 16'b1;
				if (sdram_init_counter[3]) begin 
				    // issue "mode register set command"                   
                    sdram_mode <= `SDRAM_INIT5;
                    sdram_ras_n <= 0;
                    sdram_cas_n <= 0;
                    sdram_we_n <= 0;
                    sdram_addr <= {3'b0,1'b1,2'b0,3'd3,1'b0,3'd0}; //write single, no testmode, cas 3, burst seq, burst len 1
                    sdram2_ras_n <= 0;
                    sdram2_cas_n <= 0;
                    sdram2_we_n <= 0;
                    sdram2_addr <= {3'b0,1'b0,2'b0,3'd3,1'b0,3'd1}; //write burst, no testmode, cas 3, burst seq, burst len 2
                    sdram_init_counter <= 0;
                    end
                end
                
             `SDRAM_INIT5 : begin
            	//move on with init
                sdram_ras_n <= 1'b1;
                sdram_cas_n <= 1'b1;
                sdram_we_n <= 1'b1;
                sdram2_ras_n <= 1'b1;
                sdram2_cas_n <= 1'b1;
                sdram2_we_n <= 1'b1;
                sdram_init_counter <= sdram_init_counter + 16'b1;
				if (sdram_init_counter[4]) begin 
				    // init done, switching to working mode
                    sdram_mode <= `SDRAM_IDLE;
                    end
                end
                           
             `SDRAM_IDLE : begin
                sdram_cas_n <= 1'b1;
                sdram_cke <= 1'b1;
                sdram_dq_oe <= 0;
                sdram_ras_n <= 1'b1;
                sdram_dqm <= 2'b00;
                sdram2_cas_n <= 1'b1;
                sdram2_cke <= 1'b1;
                sdram2_dq_oe <= 0;
                sdram2_ras_n <= 1'b1;
                sdram2_dqm_reg <= 2'b00;
                wishbone_sdram_complete <= 0;
                wishbone_sdram_readdatavalid <= 0;
                wishbone_sdram_waitrequest <= 1'b1;
                wishbone_sdram_reset_pending_sdram <= 0;
                // in idle mode we should check if any of the events occured:
				// 1) abus transaction detected - priority 0
				// 2) wishbone transaction detected - priority 1
				// 3) autorefresh counter exceeded threshold - priority 2
				// if none of these events occur, we keep staying in the idle mode
				if (sdram_abus_pending) begin
				    // something on abus, address should be stable already (is it???), so we activate row now
				    sdram_mode <= `SDRAM_ABUS_ACTIVATE;
				    sdram_ras_n <= 0;
				    sdram_addr <= abus_address_latched[24:12];
				    sdram_ba <= abus_address_latched[11:10];
				    sdram2_ras_n <= 0;
				    sdram2_addr <= abus_address_latched[23:11];
				    sdram2_ba <= abus_address_latched[10:9];
				    if (abus_write_buf == 2'b11) begin
				        sdram_wait_counter <= 3'd`TIMING_IDLE_TO_ACTIVATE_ABUS_READ;
				    end
				    else begin
				        sdram_wait_counter <= 3'd`TIMING_IDLE_TO_ACTIVATE_ABUS_WRITE;
				    end
                end
                else if ( (wishbone_sdram_read_pending_sdram || wishbone_sdram_write_pending_sdram) && ~wishbone_sdram_complete ) begin
                    // something on wishbone, activating!
                    sdram_mode <= `SDRAM_WISHBONE_ACTIVATE;
                    sdram_ras_n <= 0;
                    sdram_addr <= wishbone_sdram_pending_address[23:11];
                    sdram_ba <= wishbone_sdram_pending_address[10:9];
                    sdram2_ras_n <= 0;
                    sdram2_addr <= wishbone_sdram_pending_address[22:10];
                    sdram2_ba <= wishbone_sdram_pending_address[9:8];
                    sdram_wait_counter <= 3'd`TIMING_IDLE_TO_ACTIVATE_WISHBONE_RW;
                end
                else if ( sdram_autorefresh_counter[9] ) begin
                    // 512 cycles autorefresh
                    sdram_mode <= `SDRAM_AUTOREFRESH;
                    //first stage of autorefresh issues "precharge all" command
                    sdram_ras_n <= 0;
                    sdram_we_n <= 0;
                    sdram_addr[10] <= 1'b1;
                    sdram2_ras_n <= 0;
                    sdram2_we_n <= 0;
                    sdram2_addr[10] <= 1'b1;
                    sdram_autorefresh_counter <= 0;
                    sdram_wait_counter <= 3'd`TIMING_IDLE_TO_PRECHARGE;
                end
            end

            `SDRAM_AUTOREFRESH : begin
                sdram_ras_n <= 1'b1;
                sdram_we_n <= 1'b1;
                sdram_addr[10] <= 0;					
                sdram2_ras_n <= 1'b1;
                sdram2_we_n <= 1'b1;
                sdram2_addr[10] <= 0;					
				sdram_wait_counter <= sdram_wait_counter - 3'b1;
				if (sdram_wait_counter == 0) begin
				    //switching to ABUS in case of ABUS request caught us between refresh stages
				    if (sdram_abus_pending) begin
				        //something on abus, address should be stable already (is it???), so we activate row now
				        sdram_mode <= `SDRAM_ABUS_ACTIVATE;
                        sdram_ras_n <= 0;
				        sdram_addr <= abus_address_latched[24:12];
				        sdram_ba <= abus_address_latched[11:10];
                        sdram2_ras_n <= 0;
				        sdram2_addr <= abus_address_latched[23:11];
				        sdram2_ba <= abus_address_latched[10:9];
                        sdram_wait_counter <= 3'd`TIMING_PRECHARGE_TO_ACTIVATE;
                    end
                    else begin
                        //second autorefresh stage - autorefresh command 
                        sdram_mode <= `SDRAM_AUTOREFRESH2;
                        sdram_cas_n <= 0;
                        sdram_ras_n <= 0;
                        sdram2_cas_n <= 0;
                        sdram2_ras_n <= 0;
                        sdram_wait_counter <= 3'd`TIMING_PRECHARGE_TO_AUTOREFRESH;
				    end
				end
            end

            `SDRAM_AUTOREFRESH2 : begin
                // here we wait for autorefresh to end and move on to idle state
                sdram_cas_n <= 1'b1;
                sdram_ras_n <= 1'b1;
                sdram2_cas_n <= 1'b1;
                sdram2_ras_n <= 1'b1;
                sdram_wait_counter <= sdram_wait_counter - 3'b1;
                if (sdram_wait_counter == 0)
                    sdram_mode <= `SDRAM_IDLE;
            end

            `SDRAM_ABUS_ACTIVATE : begin
                // while waiting for row to be activated, we choose where to switch to - read or write
                sdram_ras_n <= 1'b1;
                sdram2_ras_n <= 1'b1;
                sdram_wait_counter <= sdram_wait_counter - 3'b1;
                if (sdram_wait_counter == 0) begin
                    if ( my_little_transaction_dir == `DIR_WRITE) begin //&& (mapper_write_enable) ) begin
                        //if mapper write is not enabled, doing read instead
                        sdram_mode <= `SDRAM_ABUS_WRITE_AND_PRECHARGE;
                        counter_count_write <= 1'b1;
                        sdram_dqm <= {abus_write_buf[0],abus_write_buf[1]};
                        if (~abus_chipselect_buf[0])//only writing if CS0
                            sdram_we_n <= 0;                        
                        sdram_cas_n <= 0;
                        sdram_dq_out <= {abus_data_in[7:0],abus_data_in[15:8]};
                        sdram_dq_oe <= 1'b1;
                        sdram_addr <= {3'b001,1'b0,abus_address_latched[9:1]};
                        sdram_ba <= abus_address_latched[11:10];
                        sdram2_dqm_reg <= {abus_write_buf[0],abus_write_buf[1]};
                        if (~abus_chipselect_buf[1])//only writing if CS1
                            sdram2_we_n <= 0;    
                        sdram2_cas_n <= 0;
                        sdram2_dq_out_reg[15:0] <= {abus_data_in[7:0],abus_data_in[15:8]};
                        sdram2_dq_oe_pre <= 1'b1;
                        sdram2_addr <= {3'b001,1'b0,abus_address_latched[8:1],1'b0};
                        sdram2_ba <= abus_address_latched[10:9];
                        sdram_wait_counter <= 3'd`TIMING_ABUS_ACTIVATE_TO_WRITE;
                    end
                    else begin
                        sdram_mode <= `SDRAM_ABUS_READ_AND_PRECHARGE;
                        counter_count_read <= 1'b1;
                        sdram_cas_n <= 0;
                        sdram_addr <= {3'b001,1'b0,abus_address_latched[9:1]};
                        sdram_ba <= abus_address_latched[11:10];
                        sdram2_cas_n <= 0;
                        sdram2_addr <= {3'b001,1'b0,abus_address_latched[8:1],1'b0};
                        sdram2_ba <= abus_address_latched[10:9];
                        sdram_wait_counter <= 3'd`TIMING_ABUS_ACTIVATE_TO_READ;
                    end
                end
            end

            `SDRAM_ABUS_READ_AND_PRECHARGE : begin
                // move on with reading, bus is a Z after idle
                // data should be latched at 2nd or 3rd clock (cas=2 or cas=3)
                counter_count_read <= 0;
				sdram_cas_n <= 1'b1;
				sdram2_cas_n <= 1'b1;
				sdram_wait_counter <= sdram_wait_counter - 3'b1;
                if (sdram_wait_counter == 3'd1) begin
                    sdram_abus_complete <= 1'b1;
                end
                if (sdram_wait_counter == 0) begin
                    sdram_mode <= `SDRAM_IDLE;
                    sdram_abus_complete <= 0;
                end
            end

            `SDRAM_ABUS_WRITE_AND_PRECHARGE : begin
                // move on with writing
                counter_count_write <= 0;
				sdram_cas_n <= 1'b1;
				sdram_we_n <= 1'b1;
				sdram_dq_oe <= 0;
				sdram2_cas_n <= 1'b1;
				sdram2_we_n <= 1'b1;
				sdram2_dq_oe_pre <= 0;
				sdram_wait_counter <= sdram_wait_counter - 3'b1;
				if (sdram_wait_counter == 3'd1) begin
                    sdram_abus_complete <= 1'b1;
                end
                if (sdram_wait_counter == 0) begin
                    sdram_mode <= `SDRAM_IDLE;
                    sdram_abus_complete <= 0;
                    sdram_dqm <= 2'b00;
                    sdram2_dqm_reg <= 2'b00;
                end
            end

            `SDRAM_WISHBONE_ACTIVATE : begin
                // while waiting for row to be activated, we choose where to switch to - read or write
				sdram_ras_n <= 1'b1;
				sdram2_ras_n <= 1'b1;
				sdram_wait_counter <= sdram_wait_counter - 3'b1;
                if (sdram_wait_counter == 0) begin
                    if (wishbone_sdram_read_pending_sdram) begin
                        sdram_mode <= `SDRAM_WISHBONE_READ_AND_PRECHARGE;
                        sdram_ba <= wishbone_sdram_pending_address[10:9];
                        sdram_cas_n <= 0;
                        sdram_addr <= {3'b001,1'b0,wishbone_sdram_pending_address[8:0]};
                        sdram2_ba <= wishbone_sdram_pending_address[9:8];
                        sdram2_cas_n <= 0;
                        sdram2_addr <= {3'b001,1'b0,wishbone_sdram_pending_address[7:0],1'b0};
                        sdram_wait_counter <= 3'd`TIMING_WISHBONE_ACTIVATE_TO_READ;
                    end
                    else begin
                        sdram_mode <= `SDRAM_WISHBONE_WRITE_AND_PRECHARGE;
                        sdram_dqm <= {~wishbone_sdram_byteenable[0],~wishbone_sdram_byteenable[1]};
                        if (~wishbone_sdram_pending_address[24])//only writing if in SDRAM1 range
                            sdram_we_n <= 0;                                
                        sdram_cas_n <= 0;
                        sdram_ba <= wishbone_sdram_pending_address[10:9];
                        sdram_dq_out <= wishbone_sdram_pending_data[15:0];
                        sdram_dq_oe <= 1'b1;
                        sdram_addr <= {3'b001,1'b0,wishbone_sdram_pending_address[8:0]};
                        sdram2_dqm_reg <={~wishbone_sdram_byteenable[0],~wishbone_sdram_byteenable[1]};
                        if (wishbone_sdram_pending_address[24])//only writing if in SDRAM2 range
                            sdram2_we_n <= 0;    
                        sdram2_cas_n <= 0;
                        sdram2_ba <= wishbone_sdram_pending_address[9:8];
                        sdram2_dq_out_reg[15:0] <= wishbone_sdram_pending_data[15:0];
						sdram2_dq_oe_pre <= 1'b1;
                        sdram2_addr <= {3'b001,1'b0,wishbone_sdram_pending_address[7:0],1'b0};
                        sdram_wait_counter <= 3'd`TIMING_WISHBONE_ACTIVATE_TO_WRITE;
                        wishbone_sdram_readdatavalid <= 1'b1; //works as ack for write too, sending early 
                    end
                end
            end

            `SDRAM_WISHBONE_READ_AND_PRECHARGE : begin
                // move on with reading, bus is a Z after idle
                // data should be latched at 2nd/3rd or 3rd/4th clock (cas=2 or cas=3)
                sdram_cas_n <= 1'b1;
                sdram2_cas_n <= 1'b1;
				sdram_wait_counter <= sdram_wait_counter - 3'b1;
                if (sdram_wait_counter == 0) begin
                    sdram_mode <= `SDRAM_IDLE;
                    wishbone_sdram_complete <= 1'b1;
                    wishbone_sdram_waitrequest <= 0;//single active cycle
                    wishbone_sdram_reset_pending_sdram <= 1'b1;
                    wishbone_sdram_readdatavalid <= 1'b1;
                end
            end

            `SDRAM_WISHBONE_WRITE_AND_PRECHARGE : begin
                sdram_cas_n <= 1'b1;
                sdram_we_n <= 1'b1;
				//sdram_dq_oe <= 0;
				sdram2_cas_n <= 1'b1;
                sdram2_we_n <= 1'b1;
                sdram2_dq_oe_pre <= 0;
				sdram_wait_counter <= sdram_wait_counter - 3'b1;
				wishbone_sdram_readdatavalid <= 0; //works as ack for write too, resetting early 
                if (sdram_wait_counter == 3'd1) begin
                    wishbone_sdram_reset_pending_sdram <= 1'b1;					
                end
                if (sdram_wait_counter == 0) begin
                    sdram_mode <= `SDRAM_IDLE;
					sdram_dq_oe <= 0;
                    wishbone_sdram_complete <= 1'b1;
                    sdram_dqm <= 2'b00;
                    sdram2_dqm_reg <= 2'b00;
                    wishbone_sdram_waitrequest <= 0;//single active cycle
					wishbone_sdram_reset_pending_sdram <= 0;
                end
            end
        endcase
    end

	/*always @(negedge sdram_clock) sdram_wait_counter_negedge <= sdram_wait_counter;
	always @(negedge sdram_clock) sdram_mode_negedge <= sdram_mode;
	always @(negedge sdram_clock) abus_chipselect_buf0_negedge <= abus_chipselect_buf[0];
	always @(negedge sdram_clock) wishbone_sdram_pending_address24_negedge <= wishbone_sdram_pending_address[24];*/
	assign sdram_wait_counter_negedge = sdram_wait_counter;
	assign sdram_mode_negedge = sdram_mode;
	assign abus_chipselect_buf0_negedge = abus_chipselect_buf[0];
	assign abus_chipselect_buf1_negedge = abus_chipselect_buf[1];
	assign wishbone_sdram_pending_address24_negedge = wishbone_sdram_pending_address[24];
    
    //latching sdram data to ABUS on negative clock
    always @(posedge sdram_clock) begin
		sdram2_delayed_read_abus <= 0;
		if (sdram_mode_negedge == `SDRAM_ABUS_READ_AND_PRECHARGE) begin
			//SDRAM1
            if (sdram_wait_counter_negedge == (3'd`TIMING_ABUS_ACTIVATE_TO_READ-3'd4)) begin
                if (~abus_chipselect_buf0_negedge) begin
                    sdram_datain_latched <= sdram_dq_in;
	                // synopsys translate_off
	                if ($time - ABUS_request_time > 92)
    	                $display ("ABUS ERROR R1 at time %t: sdram reply too late for READ, total time", $time,$time - ABUS_request_time);
        	        // synopsys translate_on
				end
            end
			//first part for SDRAM2
            if (sdram_wait_counter_negedge == (3'd`TIMING_ABUS_ACTIVATE_TO_READ-3'd3)) begin
                if (~abus_chipselect_buf1_negedge) begin
                    sdram2_datain_latched[7:0] <= sdram2_dq_in;
					sdram2_delayed_read_abus <= 1'b1;
	                // synopsys translate_off
    	            if ($time - ABUS_request_time > 92)
        	            $display ("ABUS ERROR R2 at time %t: sdram reply too late for READ, total time", $time,$time - ABUS_request_time);
            	    // synopsys translate_on
				end
            end
		end
		//second part for SDRAM2
		if (sdram2_delayed_read_abus) begin
           	sdram2_datain_latched[15:8] <= sdram2_dq_in;
			// synopsys translate_off
			if ($time - ABUS_request_time > 92)
				$display ("ABUS ERROR R3 at time %t: sdram reply too late for READ, total time", $time,$time - ABUS_request_time);
			// synopsys translate_on
		end
	end
	
    //latching debug
    always @(posedge sdram_clock) begin
        sdram_debug_read_1 <= 0;
		if (sdram_mode_negedge == `SDRAM_ABUS_READ_AND_PRECHARGE) begin
			//SDRAM1
            if (sdram_wait_counter_negedge == (3'd`TIMING_ABUS_ACTIVATE_TO_READ-3'd4)) begin
                if (~abus_chipselect_buf0_negedge) begin
                    sdram_debug_read_1 <= 1'b1;
				end
            end
		end
	end
	
	always @(posedge sdram_clock) begin
		sdram_debug_read_2 <= 0;
		if (sdram2_delayed_read_abus) begin
           	sdram_debug_read_2 <= 1'b1;
		end
	end

    always @(posedge sdram_clock) sdram_debug_read_1_d1 <= sdram_debug_read_1;
    always @(posedge sdram_clock) sdram_debug_read_1_d2 <= sdram_debug_read_1_d1;
    always @(posedge sdram_clock) sdram_debug_read_2_d1 <= sdram_debug_read_2;
    always @(posedge sdram_clock) sdram_debug_read_2_d2 <= sdram_debug_read_2_d1;
    assign sdram_debug_1 = sdram_debug_read_1 || sdram_debug_read_1_d1 || sdram_debug_read_1_d2 ||
                           sdram_debug_read_2 || sdram_debug_read_2_d1 || sdram_debug_read_2_d2;
    
    //latching sdram data to Wishbone on negative clock
    always @(posedge sdram_clock) begin
        sdram2_delayed_read_wishbone <= 0;
        if (sdram_mode_negedge == `SDRAM_WISHBONE_READ_AND_PRECHARGE) begin
			//SDRAM1
            if (sdram_wait_counter_negedge == (3'd`TIMING_WISHBONE_ACTIVATE_TO_READ-3'd4)) //4 works!
                if (~wishbone_sdram_pending_address24_negedge)
                    wishbone_sdram_readdata_latched[15:0] <= sdram_dq_in;
			//first part for SDRAM2
            if (sdram_wait_counter_negedge == (3'd`TIMING_WISHBONE_ACTIVATE_TO_READ-3'd3)) //
                if (wishbone_sdram_pending_address24_negedge) begin
                    wishbone_sdram_readdata_latched[7:0] <= sdram2_dq_in;
                    sdram2_delayed_read_wishbone <= 1'b1;
                end
		end
		//second part for SDRAM2
        if (sdram2_delayed_read_wishbone) //should be 5?
            wishbone_sdram_readdata_latched[15:8] <= sdram2_dq_in;
	end
	
	//------------------------------ A-bus transactions counter ---------------------------------------	
	// counter filters transactions transferred over a-bus and counts them
	// for writes, 8-bit transactions are counted as 1 byte, 16-bit as 2 bytes
	// for reads, every access is counted as 2 bytes
	// filter control :
	// bit 0 - read
	// bit 1 - write
	// bit 2 - CS0
    // bit 3 - CS1
	// bit 4 - CS2
	
	/*always @(posedge sdram_clock)
	   if (counter_reset)
	       counter_value <= 0;
	    else if ( (counter_count_write) && (counter_filter_control[1]) ) begin
	       //write detected, checking state 
	       if ( (~abus_chipselect_buf[0]) && (counter_filter_control[2]) )
	           if (abus_write_buf == 2'b00)
	               counter_value <= counter_value + 32'd2;
	           else
	               counter_value <= counter_value + 32'd1;
	       else if ( (~abus_chipselect_buf[1]) && (counter_filter_control[3]) )
	           if (abus_write_buf == 2'b00)
	               counter_value <= counter_value + 32'd2;
	           else
	               counter_value <= counter_value + 32'd1;
	       else if ( (~abus_chipselect_buf[2]) && (counter_filter_control[4]) )
	           if (abus_write_buf == 2'b00)
	               counter_value <= counter_value + 32'd2;
	           else
	               counter_value <= counter_value + 32'd1;
	    end
	    else if ( (counter_count_read) && (counter_filter_control[0]) ) begin
	       //read detected, checking state 
	       if ( (~abus_chipselect_buf[0]) && (counter_filter_control[2]) )
	           counter_value <= counter_value + 32'd2;
	       else if ( (~abus_chipselect_buf[1]) && (counter_filter_control[3]) )
		       counter_value <= counter_value + 32'd2;
	       else if ( (~abus_chipselect_buf[2]) && (counter_filter_control[4]) )
		       counter_value <= counter_value + 32'd2;
	    end*/
	
	//------------------------------ A-bus sniffer ---------------------------------------
	// sniffer is necessary to implement memory syncing with SH-2 and riscv (mostly cs1 backup area)
	// every time SH-2 performs an access that passes thru sniffer filter,
	// its upper address (block address) is prepared for fifo writing
	// fifo is actually written in 2 cases:
	// 1) SH-2 access with a different block address is registered
	// 2) no SH-2 transactions within 10 ms 
	
	always @(posedge sdram_clock) begin
	   sniffer_pending_set <= 0;
	   if ( (counter_count_write) && (sniffer_filter_control[1]) ) begin
	       //write detected, checking state 
	       if ( (~abus_chipselect_buf[0]) && (sniffer_filter_control[2]) )
	           sniffer_pending_set <= 1'b1;
	       else if ( (~abus_chipselect_buf[1]) && (sniffer_filter_control[3]) )
	           sniffer_pending_set <= 1'b1;
	       else if ( (~abus_chipselect_buf[2]) && (sniffer_filter_control[4]) )
	           sniffer_pending_set <= 1'b1;
	   end
	   else if ( (counter_count_read) && (sniffer_filter_control[0]) ) begin
	       //read detected, checking state 
	       if ( (~abus_chipselect_buf[0]) && (sniffer_filter_control[2]) )
	           sniffer_pending_set <= 1'b1;
	       else if ( (~abus_chipselect_buf[1]) && (sniffer_filter_control[3]) )
		       sniffer_pending_set <= 1'b1;
	       else if ( (~abus_chipselect_buf[2]) && (sniffer_filter_control[4]) )
		       sniffer_pending_set <= 1'b1;
	   end
	end
	
	//if an access passed thru filter, set the request as pending
	always @(posedge sdram_clock)
	   if (sniffer_pending_set)
	       sniffer_pending_flag <= 1'b1;
	   else if (sniffer_pending_reset)
	       sniffer_pending_flag <= 0;
	       
	//reset after transaction is over, with 1-cycle debounce
	always @(posedge sdram_clock)
	   sniffer_pending_reset <= ( (abus_chipselect_buf == 3'b111) && (abus_chipselect_buf2 == 3'b111) ) ? 1'b1 : 0;
	       
	//to latch data only once at the start, creating rising pulse
	always @(posedge sdram_clock) sniffer_pending_flag_d1 <= sniffer_pending_flag;
	assign sniffer_pending_flag_pulse = sniffer_pending_flag && ~sniffer_pending_flag_d1;
	//always @(posedge sdram_clock) sniffer_pending_flag_pulse_d1 <= sniffer_pending_flag_pulse;
	       
	//latching new data for fifo
	always @(posedge sdram_clock)
	   if (sniffer_pending_flag_pulse)
	       sniffer_pending_block <= abus_address_latched[24:9];
    
    // fifo write: either different block or timeout 
    always @(posedge sdram_clock) begin
        sniffer_data_write <= 0;
        if ( (sniffer_pending_flag_pulse) && ( sniffer_pending_block != abus_address_latched[24:9]) )
            sniffer_data_write <= 1'b1;
        else if (sniffer_pending_timeout)
            sniffer_data_write <= 1'b1;
    end
        
    //timeout counter, 20 active bits, 7.8ms at 133mhz
    always @(posedge sdram_clock)
        if (sniffer_pending_set)
            sniffer_pending_timeout_counter <= 0;
        else if  ( (~sniffer_pending_timeout_counter[17]) || ((~sniffer_pending_timeout_counter[0])) ) //20
            sniffer_pending_timeout_counter <= sniffer_pending_timeout_counter + 21'b1;
    
    //timeout comparator
    always @(posedge sdram_clock)
        if (sniffer_pending_set) 
            sniffer_pending_timeout <= 0;
        else
            sniffer_pending_timeout <= sniffer_pending_timeout_counter[17] && ~sniffer_pending_timeout_counter[0];//20
    
    always @(posedge sdram_clock) sniffer_data_in = sniffer_pending_block;
        
    //if we have a pending request, and it's for a different block, fill prefifo
    /*always @(posedge sdram_clock) sniffer_pending_reset <= ((sniffer_pending_flag) && (sniffer_pending_block != sniffer_last_active_block)) ? 1'b0 : 0;
    always @(posedge sdram_clock) if ((sniffer_pending_flag) && (sniffer_pending_block != sniffer_last_active_block)) sniffer_last_active_block <= sniffer_pending_block;
    always @(posedge sdram_clock) if ((sniffer_pending_flag) && (sniffer_pending_block != sniffer_last_active_block)) sniffer_prefifo <= sniffer_pending_block;
        
    // if we have a pending request, and it's for a different block, and prefifo is full, flush prefifo
    // if we don't have eny requests, but the timeout fired, flush prefifo as well
    always @(posedge sdram_clock)
        if ( (sniffer_pending_flag) && (sniffer_pending_block != sniffer_last_active_block) && (sniffer_prefifo_full) )
            sniffer_data_write <= 1'b1;
        else if (sniffer_pending_timeout)
            sniffer_data_write <= 1'b1;
        else
            sniffer_data_write <= 0;
            
    always @(posedge sdram_clock)
        if ( (sniffer_pending_flag) && (sniffer_pending_block != sniffer_last_active_block) )
            sniffer_prefifo_full <= 1'b1;
        else if (sniffer_pending_timeout)
            sniffer_prefifo_full <= 0;

    always @(posedge sdram_clock)
        if ( (sniffer_pending_flag) && (sniffer_pending_block != sniffer_last_active_block) && (sniffer_prefifo_full) )
            sniffer_data_in <= sniffer_prefifo;
        else if (sniffer_pending_timeout)
            sniffer_data_in <= sniffer_prefifo;
    
    //timeout counter. resets when another pending is set
    always @(posedge sdram_clock)
        if (sniffer_pending_set)
            sniffer_pending_timeout_counter <= 0;
        else if ($unsigned(sniffer_pending_timeout_counter) < $unsigned(32'd134217728))
            sniffer_pending_timeout_counter <= sniffer_pending_timeout_counter + 32'b1;
    
    //timeout comparator @ 10ms = 1160000
    always @(posedge sdram_clock) sniffer_pending_timeout <= (sniffer_pending_timeout_counter == 32'd1160000) ? 1'b1 : 0;*/

	//sniffer_data_in_p1(15 downto 0) <= sniffer_last_active_block when rising_edge(clock);
	//sniffer_data_in <= sniffer_data_in_p1 when rising_edge(clock);
	//sniffer_data_write <= sniffer_data_write_p1 when rising_edge(clock);
	//sniffer_data_out_p1 <= sniffer_data_out when rising_edge(clock);
	
	sniff_fifo sniff_fifo_inst (
		.clock(sdram_clock),
		.data(sniffer_data_in),
		.rdreq(sniffer_data_ack),
		.wrreq(sniffer_data_write),
		.empty(sniffer_fifo_empty),
		.full(sniffer_fifo_full),
		.q(sniffer_data_out),
		.usedw(sniffer_fifo_content_size)
	);
	
	/*
--	--xilinx mode
--	sniff_fifo_inst : sniff_fifo PORT MAP (
--        clk     => clock,
--        srst => '0',
--        din     => sniffer_data_in,
--        rd_en     => sniffer_data_ack,
--        wr_en     => sniffer_data_write,
--        empty     => sniffer_fifo_empty,
--        full     => sniffer_fifo_full,
--        dout     => sniffer_data_out,
--        data_count     => sniffer_fifo_content_size
--    );*/

    //------------------------------ A-bus timing checks ---------------------------------------
    /*
    // synopsys translate_off
    always @(posedge sdram_clock)
        if (abus_cspulse2 && ~(sdram_mode ==`SDRAM_IDLE)) begin
            $display ("ABUS ERROR violation at time %t: request out of idle", $time);
        end
    // synopsys translate_on*/

endmodule
