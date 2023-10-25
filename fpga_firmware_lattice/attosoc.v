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
	input clk,
	output reg [2:0] led,
	input sd_clk_i,
	inout sd_cmd,
	inout [3:0] sd_dat,
	output sd_clk,
	output uart_tx,
	input uart_rx
);

	reg [5:0] reset_cnt = 0;
	wire resetn = &reset_cnt;

	always @(posedge clk) begin
		reset_cnt <= reset_cnt + !resetn;
	end

	parameter integer MEM_WORDS = 16384;
	parameter [31:0] STACKADDR = 32'h 0001_0000;       // end of memory
	parameter [31:0] PROGADDR_RESET = 32'h 0000_0000;       // start of memory

	(* no_rw_check *) reg [31:0] ram [0:MEM_WORDS-1];
	initial $readmemh("bootstrap.hex", ram);
	reg [31:0] ram_rdata;
	reg ram_ready;

	wire mem_valid;
	wire mem_instr;
	wire mem_ready;
	wire [31:0] mem_addr;
	wire [31:0] mem_wdata;
	wire [3:0] mem_wstrb;
	wire [31:0] mem_rdata;

	always @(posedge clk)
        begin
		//port 0
		ram_ready <= 1'b0;
		if (mem_addr[31:24] == 8'h00 && mem_valid) begin
			if (mem_wstrb[0]) ram[mem_addr[23:2]][7:0] <= mem_wdata[7:0];
			if (mem_wstrb[1]) ram[mem_addr[23:2]][15:8] <= mem_wdata[15:8];
			if (mem_wstrb[2]) ram[mem_addr[23:2]][23:16] <= mem_wdata[23:16];
			if (mem_wstrb[3]) ram[mem_addr[23:2]][31:24] <= mem_wdata[31:24];

			ram_rdata <= ram[mem_addr[23:2]];
			ram_ready <= 1'b1;
		end
		//port 1
		sd_mem_ready <= 0;
		if (sd_mem_adr[31:24] == 8'h00 && mem_valid) begin
			if (sd_mem_stb) ram[sd_mem_adr[23:2]] <= sd_mem_dat_o[31:0];
			sd_mem_dat_i <= ram[sd_mem_adr[23:2]];
			sd_mem_ready <= 1'b1;
		end
    end

	//led control - write only
	reg led_ready;

	always @(posedge clk) begin
		led_ready <= 1'b0;
		if (mem_valid && mem_wstrb[0] && mem_addr == 32'h 0200_0000) begin
	    	led <= mem_wdata[2:0];
			led_ready <= 1'b1;
		end
	end

	//wishbone ready
	assign mem_ready = (mem_valid && led_ready) ||
						(mem_valid && sd_ready) ||
	                	simpleuart_reg_div_sel || (simpleuart_reg_dat_sel && !simpleuart_reg_dat_wait) ||
						ram_ready;

	//wishbone rdata mux
	assign mem_rdata = simpleuart_reg_div_sel ? simpleuart_reg_div_do :
						simpleuart_reg_dat_sel ? simpleuart_reg_dat_do :
						sd_regs_sel ? sd_rdata :
 						ram_rdata;

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
		.mem_valid   (mem_valid  ),
		.mem_instr   (mem_instr  ),
		.mem_ready   (mem_ready  ),
		.mem_addr    (mem_addr   ),
		.mem_wdata   (mem_wdata  ),
		.mem_wstrb   (mem_wstrb  ),
		.mem_rdata   (mem_rdata  )
	);

	//uart signals
	wire        simpleuart_reg_div_sel = mem_valid && (mem_addr == 32'h 0200_0004);
	wire [31:0] simpleuart_reg_div_do;

	wire        simpleuart_reg_dat_sel = mem_valid && (mem_addr == 32'h 0200_0008);
	wire [31:0] simpleuart_reg_dat_do;
	wire simpleuart_reg_dat_wait;

	//uart
	simpleuart simpleuart (
		.clk         (clk         ),
		.resetn      (resetn      ),

		.ser_tx      (uart_tx     ),
		.ser_rx      (uart_rx     ),

		.reg_div_we  (simpleuart_reg_div_sel ? mem_wstrb : 4'b 0000),
		.reg_div_di  (mem_wdata),
		.reg_div_do  (simpleuart_reg_div_do),

		.reg_dat_we  (simpleuart_reg_dat_sel ? mem_wstrb[0] : 1'b 0),
		.reg_dat_re  (simpleuart_reg_dat_sel && !mem_wstrb),
		.reg_dat_di  (mem_wdata),
		.reg_dat_do  (simpleuart_reg_dat_do),
		.reg_dat_wait(simpleuart_reg_dat_wait)
	);

	//sd signals
	wire sd_regs_sel = mem_valid && (mem_addr[31 : 8] == 24'h 0300_00);
	wire sd_cmd_i;
	wire sd_cmd_o;
	wire sd_cmd_oe;
	assign sd_cmd = sd_cmd_oe ? sd_cmd_o : 1'bz;
	assign sd_cmd_i = sd_cmd;
	wire [3:0] sd_dat_i;
	wire [3:0] sd_dat_o;
	wire sd_dat_oe;
	assign sd_dat = sd_dat_oe ? sd_dat_o : 4'bzzzz;
	assign sd_dat_i = sd_dat;
	wire sd_ready;
	wire [31:0] sd_mem_dat_o;
	reg [31:0] sd_mem_dat_i;
	wire [31:0] sd_mem_adr;
	wire [31:0] sd_rdata;
	//wire sd_mem_sel;
	//wire sd_mem_cyc;
	wire sd_mem_stb;
	reg sd_mem_ready;

	//sd
	sdc_controller sd_card_controller (
		// WISHBONE common
		.wb_clk_i    (clk         ),
		.wb_rst_i    (~resetn      ),
		// WISHBONE slave
		.wb_dat_i    (mem_wdata   ),
		.wb_dat_o    (sd_rdata    ),
		.wb_adr_i    (mem_addr[7:0]),
		.wb_sel_i    (~4'b0	      ),
		.wb_we_i     (mem_wstrb[0]),//using only 1 bit out of 4
		.wb_cyc_i    (~1'b0		  ),
		.wb_stb_i    (sd_regs_sel ),
		.wb_ack_o    (sd_ready    ),
		// WISHBONE master
		.m_wb_dat_o  (sd_mem_dat_o),
		.m_wb_dat_i  (sd_mem_dat_i),
		.m_wb_adr_o  (sd_mem_adr  ),
		//.m_wb_sel_o  (sd_mem_sel  ),
		//.m_wb_cyc_o  (sd_mem_cyc  ),
		.m_wb_stb_o  (sd_mem_stb  ),
		.m_wb_ack_i  (sd_mem_ready),
		//.m_wb_bte_o  ( ),
		//SD BUS
		.sd_cmd_dat_i  (sd_cmd_i   ),
		.sd_cmd_out_o  (sd_cmd_o   ),
		.sd_cmd_oe_o   (sd_cmd_oe  ),
		.sd_dat_dat_i  (sd_dat_i   ),
		.sd_dat_out_o  (sd_dat_o   ),
		.sd_dat_oe_o   (sd_dat_oe  ),
		.sd_clk_o_pad  (sd_clk     ),
		.sd_clk_i_pad  (sd_clk_i   )
		//.int_cmd  ( ),
		//.int_data  ( )
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
