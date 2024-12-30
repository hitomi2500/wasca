`include "timescale.v"

module top(
    input wire clk_25,
    output wire [5:0] led,
    inout wire sd_cmd,
	inout wire [3:0] sd_dat,
	output wire sd_clk,
    output wire uart_tx,
    input wire uart_rx
);

wire clk_133;
reg clk_12_5;
wire sd_clk_internal;

initial clk_12_5 = 0;
always @(posedge clk_25) clk_12_5 <= ~clk_12_5;

/*pll_25_133 pll(
    .clki(clk_25),
    .clko(clk_133)
);*/

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

assign sd_clk = sd_clk_internal;

endmodule
