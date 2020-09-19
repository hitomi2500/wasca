	component wasca is
		port (
			abus_avalon_sdram_bridge_0_abus_address                     : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- address
			abus_avalon_sdram_bridge_0_abus_read                        : in    std_logic                     := 'X';             -- read
			abus_avalon_sdram_bridge_0_abus_waitrequest                 : out   std_logic;                                        -- waitrequest
			abus_avalon_sdram_bridge_0_abus_addressdata                 : inout std_logic_vector(15 downto 0) := (others => 'X'); -- addressdata
			abus_avalon_sdram_bridge_0_abus_chipselect                  : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- chipselect
			abus_avalon_sdram_bridge_0_abus_direction                   : out   std_logic;                                        -- direction
			abus_avalon_sdram_bridge_0_abus_disable_out                 : out   std_logic;                                        -- disable_out
			abus_avalon_sdram_bridge_0_abus_interrupt                   : out   std_logic;                                        -- interrupt
			abus_avalon_sdram_bridge_0_abus_muxing                      : out   std_logic_vector(1 downto 0);                     -- muxing
			abus_avalon_sdram_bridge_0_abus_writebyteenable_n           : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- writebyteenable_n
			abus_avalon_sdram_bridge_0_abus_reset                       : in    std_logic                     := 'X';             -- reset
			abus_avalon_sdram_bridge_0_sdram_addr                       : out   std_logic_vector(12 downto 0);                    -- addr
			abus_avalon_sdram_bridge_0_sdram_ba                         : out   std_logic_vector(1 downto 0);                     -- ba
			abus_avalon_sdram_bridge_0_sdram_cas_n                      : out   std_logic;                                        -- cas_n
			abus_avalon_sdram_bridge_0_sdram_cke                        : out   std_logic;                                        -- cke
			abus_avalon_sdram_bridge_0_sdram_cs_n                       : out   std_logic;                                        -- cs_n
			abus_avalon_sdram_bridge_0_sdram_dq                         : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			abus_avalon_sdram_bridge_0_sdram_dqm                        : out   std_logic_vector(1 downto 0);                     -- dqm
			abus_avalon_sdram_bridge_0_sdram_ras_n                      : out   std_logic;                                        -- ras_n
			abus_avalon_sdram_bridge_0_sdram_we_n                       : out   std_logic;                                        -- we_n
			abus_avalon_sdram_bridge_0_sdram_clk                        : out   std_logic;                                        -- clk
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_cmd   : inout std_logic                     := 'X';             -- b_SD_cmd
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat   : inout std_logic                     := 'X';             -- b_SD_dat
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat3  : inout std_logic                     := 'X';             -- b_SD_dat3
			altera_up_sd_card_avalon_interface_0_conduit_end_o_SD_clock : out   std_logic;                                        -- o_SD_clock
			altpll_1_areset_conduit_export                              : in    std_logic                     := 'X';             -- export
			altpll_1_locked_conduit_export                              : out   std_logic;                                        -- export
			altpll_1_phasedone_conduit_export                           : out   std_logic;                                        -- export
			audio_out_BCLK                                              : in    std_logic                     := 'X';             -- BCLK
			audio_out_DACDAT                                            : out   std_logic;                                        -- DACDAT
			audio_out_DACLRCK                                           : in    std_logic                     := 'X';             -- DACLRCK
			clk_clk                                                     : in    std_logic                     := 'X';             -- clk
			clock_116_mhz_clk                                           : out   std_logic;                                        -- clk
			reset_reset_n                                               : in    std_logic                     := 'X';             -- reset_n
			reset_controller_0_reset_in1_reset                          : in    std_logic                     := 'X';             -- reset
			spi_stm32_MISO                                              : out   std_logic;                                        -- MISO
			spi_stm32_MOSI                                              : in    std_logic                     := 'X';             -- MOSI
			spi_stm32_SCLK                                              : in    std_logic                     := 'X';             -- SCLK
			spi_stm32_SS_n                                              : in    std_logic                     := 'X';             -- SS_n
			uart_0_external_connection_rxd                              : in    std_logic                     := 'X';             -- rxd
			uart_0_external_connection_txd                              : out   std_logic                                         -- txd
		);
	end component wasca;

	u0 : component wasca
		port map (
			abus_avalon_sdram_bridge_0_abus_address                     => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_address,                     --                  abus_avalon_sdram_bridge_0_abus.address
			abus_avalon_sdram_bridge_0_abus_read                        => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_read,                        --                                                 .read
			abus_avalon_sdram_bridge_0_abus_waitrequest                 => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_waitrequest,                 --                                                 .waitrequest
			abus_avalon_sdram_bridge_0_abus_addressdata                 => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_addressdata,                 --                                                 .addressdata
			abus_avalon_sdram_bridge_0_abus_chipselect                  => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_chipselect,                  --                                                 .chipselect
			abus_avalon_sdram_bridge_0_abus_direction                   => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_direction,                   --                                                 .direction
			abus_avalon_sdram_bridge_0_abus_disable_out                 => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_disable_out,                 --                                                 .disable_out
			abus_avalon_sdram_bridge_0_abus_interrupt                   => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_interrupt,                   --                                                 .interrupt
			abus_avalon_sdram_bridge_0_abus_muxing                      => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_muxing,                      --                                                 .muxing
			abus_avalon_sdram_bridge_0_abus_writebyteenable_n           => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_writebyteenable_n,           --                                                 .writebyteenable_n
			abus_avalon_sdram_bridge_0_abus_reset                       => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_reset,                       --                                                 .reset
			abus_avalon_sdram_bridge_0_sdram_addr                       => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_addr,                       --                 abus_avalon_sdram_bridge_0_sdram.addr
			abus_avalon_sdram_bridge_0_sdram_ba                         => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_ba,                         --                                                 .ba
			abus_avalon_sdram_bridge_0_sdram_cas_n                      => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_cas_n,                      --                                                 .cas_n
			abus_avalon_sdram_bridge_0_sdram_cke                        => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_cke,                        --                                                 .cke
			abus_avalon_sdram_bridge_0_sdram_cs_n                       => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_cs_n,                       --                                                 .cs_n
			abus_avalon_sdram_bridge_0_sdram_dq                         => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_dq,                         --                                                 .dq
			abus_avalon_sdram_bridge_0_sdram_dqm                        => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_dqm,                        --                                                 .dqm
			abus_avalon_sdram_bridge_0_sdram_ras_n                      => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_ras_n,                      --                                                 .ras_n
			abus_avalon_sdram_bridge_0_sdram_we_n                       => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_we_n,                       --                                                 .we_n
			abus_avalon_sdram_bridge_0_sdram_clk                        => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_clk,                        --                                                 .clk
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_cmd   => CONNECTED_TO_altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_cmd,   -- altera_up_sd_card_avalon_interface_0_conduit_end.b_SD_cmd
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat   => CONNECTED_TO_altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat,   --                                                 .b_SD_dat
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat3  => CONNECTED_TO_altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat3,  --                                                 .b_SD_dat3
			altera_up_sd_card_avalon_interface_0_conduit_end_o_SD_clock => CONNECTED_TO_altera_up_sd_card_avalon_interface_0_conduit_end_o_SD_clock, --                                                 .o_SD_clock
			altpll_1_areset_conduit_export                              => CONNECTED_TO_altpll_1_areset_conduit_export,                              --                          altpll_1_areset_conduit.export
			altpll_1_locked_conduit_export                              => CONNECTED_TO_altpll_1_locked_conduit_export,                              --                          altpll_1_locked_conduit.export
			altpll_1_phasedone_conduit_export                           => CONNECTED_TO_altpll_1_phasedone_conduit_export,                           --                       altpll_1_phasedone_conduit.export
			audio_out_BCLK                                              => CONNECTED_TO_audio_out_BCLK,                                              --                                        audio_out.BCLK
			audio_out_DACDAT                                            => CONNECTED_TO_audio_out_DACDAT,                                            --                                                 .DACDAT
			audio_out_DACLRCK                                           => CONNECTED_TO_audio_out_DACLRCK,                                           --                                                 .DACLRCK
			clk_clk                                                     => CONNECTED_TO_clk_clk,                                                     --                                              clk.clk
			clock_116_mhz_clk                                           => CONNECTED_TO_clock_116_mhz_clk,                                           --                                    clock_116_mhz.clk
			reset_reset_n                                               => CONNECTED_TO_reset_reset_n,                                               --                                            reset.reset_n
			reset_controller_0_reset_in1_reset                          => CONNECTED_TO_reset_controller_0_reset_in1_reset,                          --                     reset_controller_0_reset_in1.reset
			spi_stm32_MISO                                              => CONNECTED_TO_spi_stm32_MISO,                                              --                                        spi_stm32.MISO
			spi_stm32_MOSI                                              => CONNECTED_TO_spi_stm32_MOSI,                                              --                                                 .MOSI
			spi_stm32_SCLK                                              => CONNECTED_TO_spi_stm32_SCLK,                                              --                                                 .SCLK
			spi_stm32_SS_n                                              => CONNECTED_TO_spi_stm32_SS_n,                                              --                                                 .SS_n
			uart_0_external_connection_rxd                              => CONNECTED_TO_uart_0_external_connection_rxd,                              --                       uart_0_external_connection.rxd
			uart_0_external_connection_txd                              => CONNECTED_TO_uart_0_external_connection_txd                               --                                                 .txd
		);

