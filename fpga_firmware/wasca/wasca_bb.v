
module wasca (
	abus_avalon_sdram_bridge_0_abus_address,
	abus_avalon_sdram_bridge_0_abus_read,
	abus_avalon_sdram_bridge_0_abus_data,
	abus_avalon_sdram_bridge_0_abus_chipselect,
	abus_avalon_sdram_bridge_0_abus_direction,
	abus_avalon_sdram_bridge_0_abus_interrupt_disable_out,
	abus_avalon_sdram_bridge_0_abus_interrupt,
	abus_avalon_sdram_bridge_0_abus_writebyteenable_n,
	abus_avalon_sdram_bridge_0_abus_reset,
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
	buffered_spi_mosi,
	buffered_spi_clk,
	buffered_spi_miso,
	buffered_spi_cs,
	buffered_spi_sync,
	clk_clk,
	clock_116_mhz_clk,
	heartbeat_heartbeat_out,
	reset_reset_n,
	reset_controller_0_reset_in1_reset,
	uart_0_external_connection_rxd,
	uart_0_external_connection_txd);	

	input	[24:0]	abus_avalon_sdram_bridge_0_abus_address;
	input		abus_avalon_sdram_bridge_0_abus_read;
	inout	[15:0]	abus_avalon_sdram_bridge_0_abus_data;
	input	[2:0]	abus_avalon_sdram_bridge_0_abus_chipselect;
	output		abus_avalon_sdram_bridge_0_abus_direction;
	output		abus_avalon_sdram_bridge_0_abus_interrupt_disable_out;
	output		abus_avalon_sdram_bridge_0_abus_interrupt;
	input	[1:0]	abus_avalon_sdram_bridge_0_abus_writebyteenable_n;
	input		abus_avalon_sdram_bridge_0_abus_reset;
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
	output		buffered_spi_mosi;
	output		buffered_spi_clk;
	input		buffered_spi_miso;
	output		buffered_spi_cs;
	output		buffered_spi_sync;
	input		clk_clk;
	output		clock_116_mhz_clk;
	output		heartbeat_heartbeat_out;
	input		reset_reset_n;
	input		reset_controller_0_reset_in1_reset;
	input		uart_0_external_connection_rxd;
	output		uart_0_external_connection_txd;
endmodule
