`include "timescale.v"

module testbench();

	reg clk;
	reg sd_clk_i;
	reg uart_rx = 0;

    wire [2:0] led;
    wire sd_cmd;
	wire [3:0] sd_dat;
	wire sd_clk;
    wire uart_tx;

	wire [39:0] sd_rom_addr;
	wire [15:0] sd_rom_data;
	wire [7:0] sd_emu_status;
	wire sd_emu_cmd_en;
	wire [5:0] sd_emu_cmd_cmd;
	wire [31:0] sd_emu_cmd_arg;

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

	sd_fake sd_emu (
		.rstn_async      (1'b1      ),
		.sdclk      (sd_clk      ),
		.sdcmd      (sd_cmd      ),
		.sddat      (sd_dat      ),
		//.rdreq      (      ),
		.rdaddr     (sd_rom_addr ),
		.rddata     (sd_rom_data ),
		.show_status_bits      (sd_emu_status      ),
		.show_sdcmd_en      (sd_emu_cmd_en      ),
		.show_sdcmd_cmd      (sd_emu_cmd_cmd      ),
		.show_sdcmd_arg      (sd_emu_cmd_arg      )
	);

	sd_fake_rom sd_card_emu_rom (
		.clk      (sd_clk      ),
		.addr      (sd_rom_addr      ),
		.dout      (sd_rom_data      )
	);

	//pullups for sd lines
	assign (weak1,weak0) sd_cmd = ~0;
	assign (weak1,weak0) sd_dat = ~0;

endmodule
