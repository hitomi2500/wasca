
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
	sd_mmc_controller_0_sd_card_io_sd_clk_o_pad,
	sd_mmc_controller_0_sd_card_io_sd_cmd_dat_i,
	sd_mmc_controller_0_sd_card_io_sd_cmd_oe_o,
	sd_mmc_controller_0_sd_card_io_sd_cmd_out_o,
	sd_mmc_controller_0_sd_card_io_sd_dat_dat_i,
	sd_mmc_controller_0_sd_card_io_sd_dat_oe_o,
	sd_mmc_controller_0_sd_card_io_sd_dat_out_o,
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
	sega_saturn_abus_slave_0_conduit_saturn_reset_saturn_reset,
	uart_0_external_connection_rxd,
	uart_0_external_connection_txd);	

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
	output		sd_mmc_controller_0_sd_card_io_sd_clk_o_pad;
	input		sd_mmc_controller_0_sd_card_io_sd_cmd_dat_i;
	output		sd_mmc_controller_0_sd_card_io_sd_cmd_oe_o;
	output		sd_mmc_controller_0_sd_card_io_sd_cmd_out_o;
	input	[3:0]	sd_mmc_controller_0_sd_card_io_sd_dat_dat_i;
	output		sd_mmc_controller_0_sd_card_io_sd_dat_oe_o;
	output	[3:0]	sd_mmc_controller_0_sd_card_io_sd_dat_out_o;
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
	input		sega_saturn_abus_slave_0_conduit_saturn_reset_saturn_reset;
	input		uart_0_external_connection_rxd;
	output		uart_0_external_connection_txd;
endmodule
