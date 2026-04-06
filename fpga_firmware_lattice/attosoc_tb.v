//`include "timescale.v"
`timescale 10ps / 1ps

module testbench();

	reg sdram_clk_i;
	reg mcu_clk_i;
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
	
	//A-bus slave interface
	reg [24:1] abus_address;
	wire [15:0] abus_data;
	reg [15:0] abus_data_out;
	reg abus_data_oe;
	reg [2:0] abus_chipselect;
	reg abus_read;
	reg [1:0] abus_write;
	wire abus_interrupt;
	wire abus_direction;
	wire abus_interrupt_disable_out;
	//SDRAM port 1 (built into icesugar) master interface
	wire [12:0] sdram_addr;
	wire [1:0] sdram_ba;
	wire sdram_cas_n;
	wire sdram_cke;
	wire sdram_cs_n;
	wire [15:0] sdram_dq;
	wire [1:0] sdram_dqm;
	wire sdram_ras_n;
	wire sdram_we_n;
	wire sdram_clk;

	always #375 sdram_clk_i = (sdram_clk_i === 1'b0); //133 Mhz
	//always #350 sdram_clk_i = (sdram_clk_i === 1'b0); //143 Mhz
	always #1000 mcu_clk_i = (mcu_clk_i === 1'b0);//50 Mhz
	always #2000 sd_clk_i = (sd_clk_i === 1'b0);//25 Mhz

	initial begin
		$dumpfile("testbench.vcd");
		$dumpvars(0, testbench);

		repeat (400) begin
			repeat (50000) @(posedge mcu_clk_i);
			$display("+50000 cycles");
		end
		$finish;
	end

	always @(led) begin
		#100 $display("%b", led);
	end
	
	task abus_write_task;
        input [24:1] addr;
        input [15:0] data;
        input [2:0]  chipselect;
    
        begin
            // Setup phase
            abus_address     = addr;
            abus_data_out    = data;
            abus_data_oe     = 1'b1;
            #1000
            abus_read        = 1'b1;
            abus_write       = 2'b00;
            #1000
            abus_chipselect  = chipselect;
            #12000
            abus_chipselect  = 3'b111;
            #1000
            abus_read        = 1'b1;
            abus_write       = 2'b11;
            #1000
            abus_data_oe     = 1'b0;
        end
    endtask
    
    task abus_read_task;
        input [24:1] addr;
        input [2:0]  chipselect;
    
        begin
            // Setup phase
            abus_address     = addr;
            abus_data_oe     = 1'b0;
            #1000
            abus_read        = 1'b0;
            abus_write       = 2'b11;
            #1000
            abus_chipselect  = chipselect;
            #12000
            abus_chipselect  = 3'b111;
            #1000
            abus_read        = 1'b1;
            abus_write       = 2'b11;
            #1000;
        end
    endtask
	
	task abus_write_burst2_task;
        input [24:1] addr;
        input [15:0] data1;
        input [15:0] data2;
        input [2:0]  chipselect;
    
        begin
            // Setup phase
            abus_address     = addr;
            abus_data_out    = data1;
            abus_data_oe     = 1'b1;
            #1000
            abus_read        = 1'b1;
            abus_write       = 2'b00;
            #1000
            abus_chipselect  = chipselect;
            #12000
            abus_chipselect  = 3'b111;
            #1000
            abus_address     = addr + 24'b1;
            abus_data_out    = data2;
            #1000
            abus_chipselect  = chipselect;
            #12000
            abus_chipselect  = 3'b111;
            #1000
            abus_read        = 1'b1;
            abus_write       = 2'b11;
            #1000
            abus_data_oe     = 1'b0;
        end
    endtask
    
    task abus_read_burst2_task;
        input [24:1] addr;
        input [2:0]  chipselect;
    
        begin
            // Setup phase
            abus_address     = addr;
            abus_data_oe     = 0;
            #1000
            abus_read        = 1'b0;
            abus_write       = 2'b11;
            #1000
            abus_chipselect  = chipselect;
            #12000
            abus_chipselect  = 3'b111;
            #1000
            abus_address     = addr + 24'b1;
            #1000
            abus_chipselect  = chipselect;
            #12000
            abus_chipselect  = 3'b111;
            #1000
            abus_read        = 1'b1;
            abus_write       = 2'b11;
            #1000;
        end
    endtask
	
	//abus access emulation
	integer i;
	initial begin
	    abus_address <= 0;
	    abus_data_out <=  0;
	    abus_chipselect <= 3'b111;
	    abus_data_oe <= 1'b0;
	    abus_read <= 1'b1;
	    abus_write <= 2'b11;
	    #50000000 //prevent clashing
	    /*#40000000 //clash!
	    #1500
	    #5250
	    #750
	    #750*/
	    abus_write_task( .addr({21'h0FFFFF,3'b111}), .data(16'h0004), .chipselect(3'b110));//set mode register
	    for (i=0; i<1000; i=i+1) begin
		      //write CS0
		      abus_write_burst2_task( .addr(i*2), .data1((i*2)+16'h1234), .data2((i*2+1)+16'h1234), .chipselect(3'b110));
		      //read CS0
		      abus_read_burst2_task( .addr(i*2), .chipselect(3'b110));
		      //#20000;
		end
	end

	attosoc uut (
		.sdram_clk_i      (sdram_clk_i      ),
		.mcu_clk_i      (mcu_clk_i      ),
		.led      (led      ),
		.sd_clk_i     (sd_clk_i),
		.sd_cmd      (sd_cmd      ),
		.sd_dat      (sd_dat      ),
		.sd_clk      (sd_clk      ),
		.uart_rx      (uart_rx      ),	
		.uart_tx      (uart_tx      ),
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
	
	mt48lc16m16a2 sdram_model(
	   .Clk(sdram_clk),
	   .Cs_n(sdram_cs_n),
	   .Dqm(sdram_dqm),
	   .Cas_n(sdram_cas_n),
	   .Ras_n(sdram_ras_n),
	   .Ba(sdram_ba),
	   .Addr(sdram_addr),      
	   .Dq(sdram_dq),
	   .Cke(sdram_cke),
	   .We_n(sdram_we_n)
	   ); 
	   
	assign abus_data = (abus_data_oe) ? abus_data_out : {16{1'bZ}};

endmodule
