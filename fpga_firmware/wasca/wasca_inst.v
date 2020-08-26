	wasca u0 (
		.abus_avalon_sdram_bridge_0_abus_address           (<connected-to-abus_avalon_sdram_bridge_0_abus_address>),           //  abus_avalon_sdram_bridge_0_abus.address
		.abus_avalon_sdram_bridge_0_abus_read              (<connected-to-abus_avalon_sdram_bridge_0_abus_read>),              //                                 .read
		.abus_avalon_sdram_bridge_0_abus_waitrequest       (<connected-to-abus_avalon_sdram_bridge_0_abus_waitrequest>),       //                                 .waitrequest
		.abus_avalon_sdram_bridge_0_abus_addressdata       (<connected-to-abus_avalon_sdram_bridge_0_abus_addressdata>),       //                                 .addressdata
		.abus_avalon_sdram_bridge_0_abus_chipselect        (<connected-to-abus_avalon_sdram_bridge_0_abus_chipselect>),        //                                 .chipselect
		.abus_avalon_sdram_bridge_0_abus_direction         (<connected-to-abus_avalon_sdram_bridge_0_abus_direction>),         //                                 .direction
		.abus_avalon_sdram_bridge_0_abus_disable_out       (<connected-to-abus_avalon_sdram_bridge_0_abus_disable_out>),       //                                 .disable_out
		.abus_avalon_sdram_bridge_0_abus_interrupt         (<connected-to-abus_avalon_sdram_bridge_0_abus_interrupt>),         //                                 .interrupt
		.abus_avalon_sdram_bridge_0_abus_muxing            (<connected-to-abus_avalon_sdram_bridge_0_abus_muxing>),            //                                 .muxing
		.abus_avalon_sdram_bridge_0_abus_writebyteenable_n (<connected-to-abus_avalon_sdram_bridge_0_abus_writebyteenable_n>), //                                 .writebyteenable_n
		.abus_avalon_sdram_bridge_0_abus_reset             (<connected-to-abus_avalon_sdram_bridge_0_abus_reset>),             //                                 .reset
		.abus_avalon_sdram_bridge_0_sdram_addr             (<connected-to-abus_avalon_sdram_bridge_0_sdram_addr>),             // abus_avalon_sdram_bridge_0_sdram.addr
		.abus_avalon_sdram_bridge_0_sdram_ba               (<connected-to-abus_avalon_sdram_bridge_0_sdram_ba>),               //                                 .ba
		.abus_avalon_sdram_bridge_0_sdram_cas_n            (<connected-to-abus_avalon_sdram_bridge_0_sdram_cas_n>),            //                                 .cas_n
		.abus_avalon_sdram_bridge_0_sdram_cke              (<connected-to-abus_avalon_sdram_bridge_0_sdram_cke>),              //                                 .cke
		.abus_avalon_sdram_bridge_0_sdram_cs_n             (<connected-to-abus_avalon_sdram_bridge_0_sdram_cs_n>),             //                                 .cs_n
		.abus_avalon_sdram_bridge_0_sdram_dq               (<connected-to-abus_avalon_sdram_bridge_0_sdram_dq>),               //                                 .dq
		.abus_avalon_sdram_bridge_0_sdram_dqm              (<connected-to-abus_avalon_sdram_bridge_0_sdram_dqm>),              //                                 .dqm
		.abus_avalon_sdram_bridge_0_sdram_ras_n            (<connected-to-abus_avalon_sdram_bridge_0_sdram_ras_n>),            //                                 .ras_n
		.abus_avalon_sdram_bridge_0_sdram_we_n             (<connected-to-abus_avalon_sdram_bridge_0_sdram_we_n>),             //                                 .we_n
		.abus_avalon_sdram_bridge_0_sdram_clk              (<connected-to-abus_avalon_sdram_bridge_0_sdram_clk>),              //                                 .clk
		.altpll_1_areset_conduit_export                    (<connected-to-altpll_1_areset_conduit_export>),                    //          altpll_1_areset_conduit.export
		.altpll_1_locked_conduit_export                    (<connected-to-altpll_1_locked_conduit_export>),                    //          altpll_1_locked_conduit.export
		.altpll_1_phasedone_conduit_export                 (<connected-to-altpll_1_phasedone_conduit_export>),                 //       altpll_1_phasedone_conduit.export
		.audio_out_BCLK                                    (<connected-to-audio_out_BCLK>),                                    //                        audio_out.BCLK
		.audio_out_DACDAT                                  (<connected-to-audio_out_DACDAT>),                                  //                                 .DACDAT
		.audio_out_DACLRCK                                 (<connected-to-audio_out_DACLRCK>),                                 //                                 .DACLRCK
		.clk_clk                                           (<connected-to-clk_clk>),                                           //                              clk.clk
		.clock_116_mhz_clk                                 (<connected-to-clock_116_mhz_clk>),                                 //                    clock_116_mhz.clk
		.reset_reset_n                                     (<connected-to-reset_reset_n>),                                     //                            reset.reset_n
		.spi_sd_card_MISO                                  (<connected-to-spi_sd_card_MISO>),                                  //                      spi_sd_card.MISO
		.spi_sd_card_MOSI                                  (<connected-to-spi_sd_card_MOSI>),                                  //                                 .MOSI
		.spi_sd_card_SCLK                                  (<connected-to-spi_sd_card_SCLK>),                                  //                                 .SCLK
		.spi_sd_card_SS_n                                  (<connected-to-spi_sd_card_SS_n>),                                  //                                 .SS_n
		.spi_stm32_MISO                                    (<connected-to-spi_stm32_MISO>),                                    //                        spi_stm32.MISO
		.spi_stm32_MOSI                                    (<connected-to-spi_stm32_MOSI>),                                    //                                 .MOSI
		.spi_stm32_SCLK                                    (<connected-to-spi_stm32_SCLK>),                                    //                                 .SCLK
		.spi_stm32_SS_n                                    (<connected-to-spi_stm32_SS_n>),                                    //                                 .SS_n
		.uart_0_external_connection_rxd                    (<connected-to-uart_0_external_connection_rxd>),                    //       uart_0_external_connection.rxd
		.uart_0_external_connection_txd                    (<connected-to-uart_0_external_connection_txd>)                     //                                 .txd
	);

