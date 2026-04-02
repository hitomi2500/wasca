`include "timescale.v"

module top(
    input wire clk_25,
    output wire [5:0] led,
    inout wire sd_cmd,
	inout wire [3:0] sd_dat,
	output wire sd_clk,
    output wire uart_tx,
    input wire uart_rx,
	//A-bus slave interface
	input wire [24:1] abus_address,
	inout wire [15:0] abus_data,
	input wire [2:0] abus_chipselect,
	input wire abus_read,
	input wire abus_write,
	output wire abus_interrupt,
	output wire abus_direction,
	output wire abus_interrupt_disable_out,
	output wire abus_buffers_enable,
	//SDRAM port 1 (built into icesugar) master interface
	output wire [12:0] sdram_addr,
	output wire [1:0] sdram_ba,
	output wire sdram_cas_n,
	output wire sdram_cke,
	output wire sdram_cs_n,
	inout wire [15:0] sdram_dq,
	output wire [1:0] sdram_dqm,
	output wire sdram_ras_n,
	output wire sdram_we_n,
	output wire sdram_clk
);

wire clk_50;
wire clk_133;
wire sd_clk_internal;

pll_25_133 pll(
    .clk_in_25(clk_25),
    .clk_out_50(clk_50),
    .clk_out_133(clk_133)
);

attosoc soc(
    .mcu_clk_i(clk_50),
    .sdram_clk_i(clk_133),
    .led(led),
    .sd_clk_i(clk_25),
    .sd_cmd(sd_cmd),
    .sd_dat(sd_dat),
    .sd_clk(sd_clk_internal),
    .uart_tx(uart_tx),
    .uart_rx(uart_rx),
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
    .sdram_clk(sdram_clk)
);

assign sd_clk = sd_clk_internal;
assign abus_buffers_enable = 1'b1;

endmodule
