module testbench();

	reg clk;
	reg sd_clk_i;
	reg uart_rx = 0;

    wire [2:0] led;
    wire sd_cmd;
	wire [3:0] sd_dat;
	wire sd_clk;
    wire uart_tx;

	always #4 clk = (clk === 1'b0);
	always #20 sd_clk_i = (sd_clk_i === 1'b0);

	initial begin
		$dumpfile("testbench.vcd");
		$dumpvars(0, testbench);

		repeat (4) begin
			repeat (50000) @(posedge clk);
			$display("+50000 cycles");
		end
		$finish;
	end

	always @(led) begin
		#1 $display("%b", led);
	end

	attosoc uut (
		.clk      (clk      ),
		.led      (led      ),
		.sd_clk_i     (sd_clk_i),
		.sd_cmd      (sd_cmd      ),
		.sd_dat      (sd_dat      ),
		.sd_clk      (sd_clk      ),
		.uart_rx      (uart_rx      ),	
		.uart_tx      (uart_tx      )
	);
endmodule
