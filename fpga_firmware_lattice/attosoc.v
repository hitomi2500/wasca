/*
 *  ECP5 PicoRV32 demo
 *
 *  Copyright (C) 2017  Claire Xenia Wolf <claire@yosyshq.com>
 *  Copyright (C) 2018  gatecat <gatecat@ds0.me>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */
`include "timescale.v"

`ifdef PICORV32_V
`error "attosoc.v must be read before picorv32.v!"
`endif

`define PICORV32_REGS picosoc_regs

module attosoc (
	input wire sdram_clk_i,
	input wire mcu_clk_i,
	output reg [5:0] led,
	input wire sd_clk_i,
	inout wire sd_cmd,
	inout wire [3:0] sd_dat,
	output wire sd_clk,
	output wire uart_tx,
	input wire uart_rx,
	//A-bus slave interface
	input [24:1] abus_address,
	inout [15:0] abus_data,
	input [2:0] abus_chipselect,
	input abus_read,
	input [1:0] abus_write,
	output abus_interrupt,
	output abus_direction,
	output abus_interrupt_disable_out,
	//SDRAM port 1 (built into icesugar) master interface
	output [12:0] sdram_addr,
	output [1:0] sdram_ba,
	output sdram_cas_n,
	output sdram_cke,
	output sdram_cs_n,
	inout [15:0] sdram_dq,
	output [1:0] sdram_dqm,
	output sdram_ras_n,
	output sdram_we_n,
	output sdram_clk,
	//SDRAM port 2 (external on wasca board) master interface
	output [12:0] sdram2_addr,
	output [1:0] sdram2_ba,
	output sdram2_cas_n,
	output sdram2_cke,
	output sdram2_cs_n,
	inout [7:0] sdram2_dq,
	output [0:0] sdram2_dqm,
	output sdram2_ras_n,
	output sdram2_we_n,
	output sdram2_clk,
	//debug
	output sdram_debug_1
);

	reg [5:0] reset_cnt = 0;
	wire resetn = &reset_cnt;
	wire clk = mcu_clk_i;

	always @(posedge clk) begin
		reset_cnt <= reset_cnt + !resetn;
	end

	parameter integer MEM_WORDS = 24576; //16384;
	parameter [31:0] STACKADDR = 32'h 0001_8000;       // end of memory
	parameter [31:0] PROGADDR_RESET = 32'h 0000_0000;       // start of memory

	//(* syn_ramstyle = "block_ram" *) reg [31:0] internal_ram [0:MEM_WORDS-1];
	//initial $readmemh("D:/Saturn/Wasca/vivado/lattice_sim/hdl/bootstrap.hex", internal_ram);
	wire [31:0] workram_rdata;
	reg workram_ready;

	wire soc_valid;
	wire soc_instr;
	wire soc_ready;
	wire [31:0] soc_addr;
	wire [31:0] soc_wdata;
	wire [3:0] soc_wstrb;
	wire [31:0] soc_rdata;
	
	wire sdram_mem_ready;
	wire sdram_regs_ready;
	
	//sd signals
	wire sd_regs_sel = soc_valid && (soc_addr[28 : 24] == 5'h03);
	reg sd_regs_sel_p1;
	always @(posedge clk) sd_regs_sel_p1 = sd_regs_sel;
	wire sd_regs_sel_pulse = sd_regs_sel && (~sd_regs_sel_p1);
	wire sd_cmd_i;
	wire sd_cmd_o;
	wire sd_cmd_oe;
	assign sd_cmd = (~sd_cmd_oe) ? sd_cmd_o : 1'bz;
	assign sd_cmd_i = sd_cmd;
	wire [3:0] sd_dat_i;
	wire [3:0] sd_dat_o;
	wire [3:0] sd_dat_oe;
	assign sd_dat[0] = (~sd_dat_oe[0]) ? sd_dat_o[0] : 1'bz;
	assign sd_dat[1] = (~sd_dat_oe[1]) ? sd_dat_o[1] : 1'bz;
	assign sd_dat[2] = (~sd_dat_oe[2]) ? sd_dat_o[2] : 1'bz;
	assign sd_dat[3] = (~sd_dat_oe[3]) ? sd_dat_o[3] : 1'bz;
	assign sd_dat_i = sd_dat;
	wire sd_ready;
	wire [31:0] sd_mem_dat_o;
	wire [31:0] sd_mem_dat_i;
	wire [31:0] sd_mem_adr;
	wire [31:0] sd_rdata;
	//wire sd_mem_sel;
	//wire sd_mem_cyc;
	wire sd_mem_stb;
	reg sd_mem_ready;
    
    //memory map :
    // 00xx_xxxx  workram 96KB, writable by sd core
    // 01xx_xxxx  SDRAM core registers
    // 02xx_xxx0  led control reg
    // 02xx_xxx4  uart divider reg
    // 02xx_xxx8  uart data reg
    // 03xx_xxxx  SD registers
    // 1xxx_xxxx  SDRAM area, 256MB
	
	workram workram_inst (
		.clka(clk),
		.write_ena(((soc_addr[31:24] == 8'h00) && (soc_valid)) ? soc_wstrb : 4'b0),
		.addra(soc_addr[23:2]),
		.dina(soc_wdata),
		.douta(workram_rdata),
		.clkb(clk),
		.write_enb({4{sd_mem_stb}}),
		.addrb(sd_mem_adr[23:2]),
		.dinb(sd_mem_dat_o),
		.doutb(sd_mem_dat_i)
	);

	//port 0
	always @(posedge clk) workram_ready <= (soc_addr[28:24] == 5'h00 && soc_valid) ? 1'b1 : 0;
	//port 1    
    always @(posedge clk) sd_mem_ready <= 1'b1;

	//led control - write only
	reg led_ready;

    initial led = 0;
	always @(posedge clk) begin
		led_ready <= 1'b0;
		if (soc_valid && soc_wstrb[0] && (soc_addr[28:24] == 5'h02) && soc_addr[3:2] == 2'b0) begin
	    	led[5:0] <= soc_wdata[5:0];
			led_ready <= 1'b1;
		end
	end
	/*assign led[1:0] = 0;
	assign led[2] = ~abus_chipselect[0];
	assign led[4:3] = 0;
	assign led[5] = ~abus_chipselect[1];*/

	//wishbone ready
	assign soc_ready = (soc_valid && led_ready) ||
						(soc_valid && sd_ready) ||
	                	simpleuart_reg_div_sel || (simpleuart_reg_dat_sel && !simpleuart_reg_dat_wait) ||
	                	(soc_valid && sdram_mem_ready) ||
	                	(soc_valid && sdram_regs_ready) ||
						(soc_valid && workram_ready);

	//wishbone rdata mux
	assign soc_rdata = //simpleuart_reg_div_sel ? simpleuart_reg_div_do :
						//simpleuart_reg_dat_sel ? simpleuart_reg_dat_do :
						sd_regs_sel ? sd_rdata :
						sdram_mem_sel ? sdram_mem_data :
						sdram_regs_sel ? sdram_regs_data :
 						workram_rdata;

	picorv32 #(
		.STACKADDR(STACKADDR),
		.PROGADDR_RESET(PROGADDR_RESET),
		.PROGADDR_IRQ(32'h 0000_0000),
		.BARREL_SHIFTER(0),
		.COMPRESSED_ISA(0),
		.ENABLE_MUL(0),
		.ENABLE_DIV(0),
		.ENABLE_IRQ(0),
		.ENABLE_IRQ_QREGS(0)
	) cpu (
		.clk         (clk        ),
		.resetn      (resetn     ),
		.mem_valid   (soc_valid  ),
		.mem_instr   (soc_instr  ),
		.mem_ready   (soc_ready  ),
		.mem_addr    (soc_addr   ),
		.mem_wdata   (soc_wdata  ),
		.mem_wstrb   (soc_wstrb  ),
		.mem_rdata   (soc_rdata  ),
		.trap(),
		.mem_la_read(),
		.mem_la_write()
	);

	//uart signals
	wire        simpleuart_reg_div_sel = soc_valid && (soc_addr[28:24] == 5'h02) && (soc_addr[3:2] == 2'b01);
	wire [31:0] simpleuart_reg_div_do;

	wire        simpleuart_reg_dat_sel = soc_valid && (soc_addr[28:24] == 5'h02) && (soc_addr[3:2] == 2'b10);
	wire [31:0] simpleuart_reg_dat_do;
	wire simpleuart_reg_dat_wait;

	//uart
	simpleuart simpleuart (
		.clk         (clk         ),
		.resetn      (resetn      ),

		.ser_tx      (uart_tx     ),
		.ser_rx      (uart_rx     ),

		.reg_div_we  (simpleuart_reg_div_sel ? soc_wstrb : 4'b 0000),
		.reg_div_di  (soc_wdata),
		.reg_div_do  (simpleuart_reg_div_do),

		.reg_dat_we  (simpleuart_reg_dat_sel ? soc_wstrb[0] : 1'b 0),
		.reg_dat_re  (simpleuart_reg_dat_sel && !soc_wstrb),
		.reg_dat_di  (soc_wdata),
		.reg_dat_do  (simpleuart_reg_dat_do),
		.reg_dat_wait(simpleuart_reg_dat_wait)
	);

	sdio_top #(
		.LGFIFO(12),
		.NUMIO(4),
		//.MW(32),
		.ADDRESS_WIDTH(32),//48
		.DW(32),
		.SW(32),
		.OPT_DMA(0),
		.OPT_LITTLE_ENDIAN(1),
		//.AW(32),//ADDRESS_WIDTH-$clog2(DMA_DW/8)),
		.HWDELAY(0),
		.OPT_ISTREAM(0),
		.OPT_OSTREAM(0),
		.OPT_EMMC(0),
		.OPT_SERDES(0),
		.OPT_DDR(0),
		.OPT_DS(0),
		.OPT_CARD_DETECT(0),
		.OPT_CRCTOKEN(1'b1),
		.OPT_HWRESET(0),
		.OPT_1P8V(0),
		.OPT_COLLISION(0),
		.LGTIMEOUT(23)
	) 
	sd_card_controller
	(
		.i_clk(clk),
		.i_reset(~resetn),
		.i_hsclk(clk),

		// Control (Wishbone) interface
		.i_wb_cyc(sd_regs_sel),
		.i_wb_stb(sd_regs_sel_pulse),
		.i_wb_we(soc_wstrb[0]),
		.i_wb_addr(soc_addr[4:2]),
		.i_wb_data(soc_wdata),
		.i_wb_sel(4'b1111),
		//.o_wb_stall(?), unconnected?
		.o_wb_ack(sd_ready),
		.o_wb_data(sd_rdata),

		// DMA (Wishbone) interface
		//o_dma_cyc unconnected,
		.o_dma_stb(sd_mem_stb),
		//o_dma_we unconnected
		.o_dma_addr(sd_mem_adr[29:0]),
		.o_dma_data(sd_mem_dat_o),
		//o_dma_sel unconnected
		.i_dma_stall(1'b0),
		.i_dma_ack(sd_mem_ready),
		.i_dma_data(sd_mem_dat_i),
		.i_dma_err(1'b0),
		
		// External stream interface
		.s_valid(1'b0),
		//s_ready unconnected,
		.s_data(32'b0),
		//m_valid unconnected,
		.m_ready(1'b0),
		//m_data unconnected,
		//m_last unconnected,

		// IO interface
		.o_ck(sd_clk),
		.i_ds(sd_clk_i),
		.io_cmd_tristate(sd_cmd_oe),
		.o_cmd(sd_cmd_o),
		.i_cmd(sd_cmd_i),
		.io_dat_tristate(sd_dat_oe),
		.o_dat(sd_dat_o),
		.i_dat(sd_dat_i),
		
		//
		.i_card_detect(1'b0)
		//o_hwreset_n unconnected
		//o_1p8v unconnected
		//o_int unconnected
		//o_debug unconnected
	);
	
	//sdram signals
	wire [31:0] sdram_mem_data;
    wire [31:0] sdram_regs_data;
    wire sdram_mem_sel = soc_valid && (soc_addr[28] == 1'h1);
    wire sdram_regs_sel = soc_valid && (soc_addr[28:24] == 5'h01);
    reg sdram_mem_sel_p1;
    reg sdram_regs_sel_p1;
	always @(posedge clk) sdram_mem_sel_p1 = sdram_mem_sel;
	always @(posedge clk) sdram_regs_sel_p1 = sdram_regs_sel;
	wire sdram_mem_sel_pulse = sdram_mem_sel && (~sdram_mem_sel_p1);
	wire sdram_regs_sel_pulse = sdram_regs_sel && (~sdram_regs_sel_p1);
	
	sdram_bridge the_sdram_bridge (
	   .clock(clk),
	   .sdram_clock(sdram_clk_i),
	   //A-bus slave interface
	   .abus_address(abus_address),
	   .abus_data(abus_data),
	   .abus_chipselect(abus_chipselect),
	   .abus_read(abus_read),
	   .abus_write(abus_write),
	   .abus_interrupt(abus_interrupt),
	   .abus_direction(abus_direction),
	   .abus_interrupt_disable_out(abus_interrupt_disable_out),
	   //SDRAM port 1 (built into icesugar) master interface
	   .sdram_addr(sdram_addr),
	   .sdram_ba(sdram_ba),
	   .sdram_cas_n(sdram_cas_n),
	   .sdram_cke(sdram_cke),
	   .sdram_cs_n(sdram_cs_n),
	   .sdram_dq(sdram_dq),
	   .sdram_dqm(sdram_dqm),
	   .sdram_ras_n(sdram_ras_n),
	   .sdram_we_n(sdram_we_n),
	   .sdram_clk(sdram_clk),
	   //SDRAM port 2 (external on wasca board) master interface
	   .sdram2_addr(sdram2_addr),
	   .sdram2_ba(sdram2_ba),
	   .sdram2_cas_n(sdram2_cas_n),
	   .sdram2_cke(sdram2_cke),
	   .sdram2_cs_n(sdram2_cs_n),
	   .sdram2_dq(sdram2_dq),
	   .sdram2_dqm(sdram2_dqm),
	   .sdram2_ras_n(sdram2_ras_n),
	   .sdram2_we_n(sdram2_we_n),
	   .sdram2_clk(sdram2_clk),
	   	//Wishbone SDRAM slave interface
	   .wishbone_sdram_cyc_i(sdram_mem_sel),
	   .wishbone_sdram_we_i(sdram_mem_sel ? soc_wstrb[0] : 1'b 0),
	   .wishbone_sdram_addr_i(soc_addr[27:2]),
	   .wishbone_sdram_data_i(soc_wdata),
	   .wishbone_sdram_stb_i(sdram_mem_sel_pulse),
	   .wishbone_sdram_sel_i({4{sdram_mem_sel}}),
	   .wishbone_sdram_stall_o(),//unconnected?
	   .wishbone_sdram_ack_o(sdram_mem_ready),
	   .wishbone_sdram_data_o(sdram_mem_data),
	   	//Wishbone registers slave interface
	   .wishbone_regs_cyc_i(sdram_regs_sel),
	   .wishbone_regs_we_i(sdram_regs_sel ? soc_wstrb[0] : 1'b 0),
	   .wishbone_regs_addr_i(soc_addr[27:2]),
	   .wishbone_regs_data_i(soc_wdata),
	   .wishbone_regs_stb_i({4{sdram_regs_sel_pulse}}),
	   .wishbone_regs_sel_i(sdram_regs_sel),
	   .wishbone_regs_stall_o(),
	   .wishbone_regs_ack_o(sdram_regs_ready),
	   .wishbone_regs_data_o(sdram_regs_data),
	   //resets
	   .saturn_reset(saturn_reset),
	   .reset(~resetn),
	   //debug
	   .sdram_debug_1(sdram_debug_1)
	);
	
	
endmodule

// Implementation note:
// Replace the following two modules with wrappers for your SRAM cells.

module picosoc_regs (
	input clk, wen,
	input [5:0] waddr,
	input [5:0] raddr1,
	input [5:0] raddr2,
	input [31:0] wdata,
	output [31:0] rdata1,
	output [31:0] rdata2
);
	reg [31:0] regs [0:31];

	always @(posedge clk)
		if (wen) regs[waddr[4:0]] <= wdata;

	assign rdata1 = regs[raddr1[4:0]];
	assign rdata2 = regs[raddr2[4:0]];
endmodule
