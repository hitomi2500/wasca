
module wasca (
	altpll_0_areset_conduit_export,
	altpll_0_locked_conduit_export,
	altpll_0_phasedone_conduit_export,
	audio_out_BCLK,
	audio_out_DACDAT,
	audio_out_DACLRCK,
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
	sega_saturn_abus_slave_0_abus_address,
	sega_saturn_abus_slave_0_abus_chipselect,
	sega_saturn_abus_slave_0_abus_read,
	sega_saturn_abus_slave_0_abus_write,
	sega_saturn_abus_slave_0_abus_waitrequest,
	sega_saturn_abus_slave_0_abus_interrupt,
	sega_saturn_abus_slave_0_abus_addressdata,
	sega_saturn_abus_slave_0_abus_direction,
	sega_saturn_abus_slave_0_abus_muxing,
	sega_saturn_abus_slave_0_abus_disableout,
	sega_saturn_abus_slave_0_conduit_saturn_reset_saturn_reset,
	spi_sd_card_MISO,
	spi_sd_card_MOSI,
	spi_sd_card_SCLK,
	spi_sd_card_SS_n,
	spi_stm32_MISO,
	spi_stm32_MOSI,
	spi_stm32_SCLK,
	spi_stm32_SS_n,
	uart_0_external_connection_rxd,
	uart_0_external_connection_txd);	

	input		altpll_0_areset_conduit_export;
	output		altpll_0_locked_conduit_export;
	output		altpll_0_phasedone_conduit_export;
	input		audio_out_BCLK;
	output		audio_out_DACDAT;
	input		audio_out_DACLRCK;
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
	input	[9:0]	sega_saturn_abus_slave_0_abus_address;
	input	[2:0]	sega_saturn_abus_slave_0_abus_chipselect;
	input		sega_saturn_abus_slave_0_abus_read;
	input	[1:0]	sega_saturn_abus_slave_0_abus_write;
	output		sega_saturn_abus_slave_0_abus_waitrequest;
	output		sega_saturn_abus_slave_0_abus_interrupt;
	inout	[15:0]	sega_saturn_abus_slave_0_abus_addressdata;
	output		sega_saturn_abus_slave_0_abus_direction;
	output	[1:0]	sega_saturn_abus_slave_0_abus_muxing;
	output		sega_saturn_abus_slave_0_abus_disableout;
	input		sega_saturn_abus_slave_0_conduit_saturn_reset_saturn_reset;
	input		spi_sd_card_MISO;
	output		spi_sd_card_MOSI;
	output		spi_sd_card_SCLK;
	output		spi_sd_card_SS_n;
	output		spi_stm32_MISO;
	input		spi_stm32_MOSI;
	input		spi_stm32_SCLK;
	input		spi_stm32_SS_n;
	input		uart_0_external_connection_rxd;
	output		uart_0_external_connection_txd;
endmodule
