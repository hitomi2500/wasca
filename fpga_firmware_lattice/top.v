`include "timescale.v"

module top(
    input clk_25,
    output [5:0] led,
    inout sd_cmd,
	inout [3:0] sd_dat,
	output sd_clk,
    output uart_tx,
    input uart_rx
);

wire clk_133;
reg clk_12_5;
wire sd_clk_internal;

initial clk_12_5 = 0;
always @(posedge clk_25) clk_12_5 <= ~clk_12_5;

pll_25_133 pll(
    .clki(clk_25),
    .clko(clk_133)
);

attosoc soc(
    .clk(clk_25),//clk_133
    .led(led),
    .sd_clk_i(clk_25),
    .sd_cmd(sd_cmd),
    .sd_dat(sd_dat),
    .sd_clk(sd_clk_internal),
    .uart_tx(uart_tx),
    .uart_rx(uart_rx)
);

assign sd_clk = ~sd_clk_internal;

endmodule
