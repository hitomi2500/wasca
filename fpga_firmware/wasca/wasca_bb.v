
module wasca (
	audio_out_BCLK,
	audio_out_DACDAT,
	audio_out_DACLRCK,
	clk_clk,
	clock_116_mhz_clk,
	spi_sd_card_MISO,
	spi_sd_card_MOSI,
	spi_sd_card_SCLK,
	spi_sd_card_SS_n,
	spi_stm32_MISO,
	spi_stm32_MOSI,
	spi_stm32_SCLK,
	spi_stm32_SS_n,
	uart_0_external_connection_rxd,
	uart_0_external_connection_txd,
	abus_avalon_sdram_bridge_0_sdram_addr,
	abus_avalon_sdram_bridge_0_sdram_ba,
	abus_avalon_sdram_bridge_0_sdram_cas_n,
	abus_avalon_sdram_bridge_0_sdram_cke,
	abus_avalon_sdram_bridge_0_sdram_cs_n,
	abus_avalon_sdram_bridge_0_sdram_dq,
	abus_avalon_sdram_bridge_0_sdram_dqm,
	abus_avalon_sdram_bridge_0_sdram_ras_n,
	abus_avalon_sdram_bridge_0_sdram_we_n,
	abus_avalon_sdram_bridge_0_sdram_clk,
	abus_avalon_sdram_bridge_0_abus_address,
	abus_avalon_sdram_bridge_0_abus_read,
	abus_avalon_sdram_bridge_0_abus_waitrequest,
	abus_avalon_sdram_bridge_0_abus_addressdata,
	abus_avalon_sdram_bridge_0_abus_chipselect,
	abus_avalon_sdram_bridge_0_abus_direction,
	abus_avalon_sdram_bridge_0_abus_disable_out,
	abus_avalon_sdram_bridge_0_abus_interrupt,
	abus_avalon_sdram_bridge_0_abus_muxing,
	abus_avalon_sdram_bridge_0_abus_writebyteenable_n,
	abus_avalon_sdram_bridge_0_abus_reset,
	altpll_0_locked_conduit_export,
	altpll_0_phasedone_conduit_export,
	altpll_0_areset_conduit_export,
	altpll_0_c1_conduit_export);	

	input		audio_out_BCLK;
	output		audio_out_DACDAT;
	input		audio_out_DACLRCK;
	input		clk_clk;
	output		clock_116_mhz_clk;
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
	output	[12:0]	abus_avalon_sdram_bridge_0_sdram_addr;
	output	[1:0]	abus_avalon_sdram_bridge_0_sdram_ba;
	output		abus_avalon_sdram_bridge_0_sdram_cas_n;
	output		abus_avalon_sdram_bridge_0_sdram_cke;
	output		abus_avalon_sdram_bridge_0_sdram_cs_n;
	inout	[15:0]	abus_avalon_sdram_bridge_0_sdram_dq;
	output	[1:0]	abus_avalon_sdram_bridge_0_sdram_dqm;
	output		abus_avalon_sdram_bridge_0_sdram_ras_n;
	output		abus_avalon_sdram_bridge_0_sdram_we_n;
	output		abus_avalon_sdram_bridge_0_sdram_clk;
	input	[9:0]	abus_avalon_sdram_bridge_0_abus_address;
	input		abus_avalon_sdram_bridge_0_abus_read;
	output		abus_avalon_sdram_bridge_0_abus_waitrequest;
	inout	[15:0]	abus_avalon_sdram_bridge_0_abus_addressdata;
	input	[2:0]	abus_avalon_sdram_bridge_0_abus_chipselect;
	output		abus_avalon_sdram_bridge_0_abus_direction;
	output		abus_avalon_sdram_bridge_0_abus_disable_out;
	output		abus_avalon_sdram_bridge_0_abus_interrupt;
	output	[1:0]	abus_avalon_sdram_bridge_0_abus_muxing;
	input	[1:0]	abus_avalon_sdram_bridge_0_abus_writebyteenable_n;
	input		abus_avalon_sdram_bridge_0_abus_reset;
	output		altpll_0_locked_conduit_export;
	output		altpll_0_phasedone_conduit_export;
	input		altpll_0_areset_conduit_export;
	output		altpll_0_c1_conduit_export;
endmodule
