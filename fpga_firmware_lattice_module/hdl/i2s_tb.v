`timescale 1ns / 1ns

//`include "timescale.v"
`timescale 1ns / 1ns

module i2s_tb();

	//i2s
	reg scsp_clk;
    wire ssel;
    wire i2s_bclk;
    wire i2s_lrclk;
    wire i2s_dout;

    initial scsp_clk = 0;
	always #22 scsp_clk = (scsp_clk === 1'b0);//22.5 Mhz

i2s_test_core test_gen(
    .clk(scsp_clk),
    .bck(i2s_bclk),
    .ws(i2s_lrclk),
    .data(i2s_dout)
);

endmodule
