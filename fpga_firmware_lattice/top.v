module top(
    input clk_25,
    output [2:0] led,
    inout sd_cmd,
	inout [3:0] sd_dat,
	output sd_clk,
    output uart_tx,
    input uart_rx
);

wire clk_133;
wire [2:0] int_led;

pll_25_133 pll(
    .clki(clk_25),
    .clko(clk_133)
);

attosoc soc(
    .clk(clk_133),
    .led(int_led),
    .sd_clk_i(clk_25),
    .sd_cmd(sd_cmd),
    .sd_dat(sd_dat),
    .sd_clk(sd_clk),
    .uart_tx(uart_tx),
    .uart_rx(uart_rx)
);

assign led = ~int_led;
endmodule
