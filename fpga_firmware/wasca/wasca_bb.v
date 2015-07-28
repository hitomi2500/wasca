
module wasca (
	altpll_0_areset_conduit_export,
	altpll_0_locked_conduit_export,
	altpll_0_phasedone_conduit_export,
	clk_clk,
	clock_116_mhz_clk,
	external_sdram_controller_wire_addr,
	external_sdram_controller_wire_ba,
	external_sdram_controller_wire_cas_n,
	external_sdram_controller_wire_cke,
	external_sdram_controller_wire_cs_n,
	external_sdram_controller_wire_dq,
	external_sdram_controller_wire_dqm,
	external_sdram_controller_wire_ras_n,
	external_sdram_controller_wire_we_n,
	pio_0_external_connection_export,
	reset_reset_n,
	reset_0_reset_n,
	sega_saturn_abus_slave_0_abus_address,
	sega_saturn_abus_slave_0_abus_chipselect,
	sega_saturn_abus_slave_0_abus_read,
	sega_saturn_abus_slave_0_abus_write,
	sega_saturn_abus_slave_0_abus_functioncode,
	sega_saturn_abus_slave_0_abus_timing,
	sega_saturn_abus_slave_0_abus_waitrequest,
	sega_saturn_abus_slave_0_abus_addressstrobe,
	sega_saturn_abus_slave_0_abus_interrupt,
	sega_saturn_abus_slave_0_abus_addressdata,
	sega_saturn_abus_slave_0_abus_direction,
	sega_saturn_abus_slave_0_abus_muxing,
	sega_saturn_abus_slave_0_abus_disableout,
	altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_cmd,
	altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat,
	altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat3,
	altera_up_sd_card_avalon_interface_0_conduit_end_o_SD_clock);	

	input		altpll_0_areset_conduit_export;
	output		altpll_0_locked_conduit_export;
	output		altpll_0_phasedone_conduit_export;
	input		clk_clk;
	output		clock_116_mhz_clk;
	output	[12:0]	external_sdram_controller_wire_addr;
	output	[1:0]	external_sdram_controller_wire_ba;
	output		external_sdram_controller_wire_cas_n;
	output		external_sdram_controller_wire_cke;
	output		external_sdram_controller_wire_cs_n;
	inout	[15:0]	external_sdram_controller_wire_dq;
	output	[1:0]	external_sdram_controller_wire_dqm;
	output		external_sdram_controller_wire_ras_n;
	output		external_sdram_controller_wire_we_n;
	inout	[3:0]	pio_0_external_connection_export;
	input		reset_reset_n;
	input		reset_0_reset_n;
	input	[9:0]	sega_saturn_abus_slave_0_abus_address;
	input	[2:0]	sega_saturn_abus_slave_0_abus_chipselect;
	input		sega_saturn_abus_slave_0_abus_read;
	input	[1:0]	sega_saturn_abus_slave_0_abus_write;
	input	[1:0]	sega_saturn_abus_slave_0_abus_functioncode;
	input	[2:0]	sega_saturn_abus_slave_0_abus_timing;
	output		sega_saturn_abus_slave_0_abus_waitrequest;
	input		sega_saturn_abus_slave_0_abus_addressstrobe;
	output		sega_saturn_abus_slave_0_abus_interrupt;
	inout	[15:0]	sega_saturn_abus_slave_0_abus_addressdata;
	output		sega_saturn_abus_slave_0_abus_direction;
	output	[1:0]	sega_saturn_abus_slave_0_abus_muxing;
	output		sega_saturn_abus_slave_0_abus_disableout;
	inout		altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_cmd;
	inout		altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat;
	inout		altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat3;
	output		altera_up_sd_card_avalon_interface_0_conduit_end_o_SD_clock;
endmodule
