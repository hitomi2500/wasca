	component wasca is
		port (
			altpll_0_areset_conduit_export                             : in    std_logic                     := 'X';             -- export
			altpll_0_locked_conduit_export                             : out   std_logic;                                        -- export
			altpll_0_phasedone_conduit_export                          : out   std_logic;                                        -- export
			audio_out_BCLK                                             : in    std_logic                     := 'X';             -- BCLK
			audio_out_DACDAT                                           : out   std_logic;                                        -- DACDAT
			audio_out_DACLRCK                                          : in    std_logic                     := 'X';             -- DACLRCK
			clk_clk                                                    : in    std_logic                     := 'X';             -- clk
			clock_116_mhz_clk                                          : out   std_logic;                                        -- clk
			external_sdram_controller_wire_addr                        : out   std_logic_vector(12 downto 0);                    -- addr
			external_sdram_controller_wire_ba                          : out   std_logic_vector(1 downto 0);                     -- ba
			external_sdram_controller_wire_cas_n                       : out   std_logic;                                        -- cas_n
			external_sdram_controller_wire_cke                         : out   std_logic;                                        -- cke
			external_sdram_controller_wire_cs_n                        : out   std_logic;                                        -- cs_n
			external_sdram_controller_wire_dq                          : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			external_sdram_controller_wire_dqm                         : out   std_logic_vector(1 downto 0);                     -- dqm
			external_sdram_controller_wire_ras_n                       : out   std_logic;                                        -- ras_n
			external_sdram_controller_wire_we_n                        : out   std_logic;                                        -- we_n
			sega_saturn_abus_slave_0_abus_address                      : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- address
			sega_saturn_abus_slave_0_abus_chipselect                   : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- chipselect
			sega_saturn_abus_slave_0_abus_read                         : in    std_logic                     := 'X';             -- read
			sega_saturn_abus_slave_0_abus_write                        : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- write
			sega_saturn_abus_slave_0_abus_waitrequest                  : out   std_logic;                                        -- waitrequest
			sega_saturn_abus_slave_0_abus_interrupt                    : out   std_logic;                                        -- interrupt
			sega_saturn_abus_slave_0_abus_addressdata                  : inout std_logic_vector(15 downto 0) := (others => 'X'); -- addressdata
			sega_saturn_abus_slave_0_abus_direction                    : out   std_logic;                                        -- direction
			sega_saturn_abus_slave_0_abus_muxing                       : out   std_logic_vector(1 downto 0);                     -- muxing
			sega_saturn_abus_slave_0_abus_disableout                   : out   std_logic;                                        -- disableout
			sega_saturn_abus_slave_0_conduit_saturn_reset_saturn_reset : in    std_logic                     := 'X';             -- saturn_reset
			spi_sd_card_MISO                                           : in    std_logic                     := 'X';             -- MISO
			spi_sd_card_MOSI                                           : out   std_logic;                                        -- MOSI
			spi_sd_card_SCLK                                           : out   std_logic;                                        -- SCLK
			spi_sd_card_SS_n                                           : out   std_logic;                                        -- SS_n
			spi_stm32_MISO                                             : out   std_logic;                                        -- MISO
			spi_stm32_MOSI                                             : in    std_logic                     := 'X';             -- MOSI
			spi_stm32_SCLK                                             : in    std_logic                     := 'X';             -- SCLK
			spi_stm32_SS_n                                             : in    std_logic                     := 'X';             -- SS_n
			uart_0_external_connection_rxd                             : in    std_logic                     := 'X';             -- rxd
			uart_0_external_connection_txd                             : out   std_logic                                         -- txd
		);
	end component wasca;

	u0 : component wasca
		port map (
			altpll_0_areset_conduit_export                             => CONNECTED_TO_altpll_0_areset_conduit_export,                             --                       altpll_0_areset_conduit.export
			altpll_0_locked_conduit_export                             => CONNECTED_TO_altpll_0_locked_conduit_export,                             --                       altpll_0_locked_conduit.export
			altpll_0_phasedone_conduit_export                          => CONNECTED_TO_altpll_0_phasedone_conduit_export,                          --                    altpll_0_phasedone_conduit.export
			audio_out_BCLK                                             => CONNECTED_TO_audio_out_BCLK,                                             --                                     audio_out.BCLK
			audio_out_DACDAT                                           => CONNECTED_TO_audio_out_DACDAT,                                           --                                              .DACDAT
			audio_out_DACLRCK                                          => CONNECTED_TO_audio_out_DACLRCK,                                          --                                              .DACLRCK
			clk_clk                                                    => CONNECTED_TO_clk_clk,                                                    --                                           clk.clk
			clock_116_mhz_clk                                          => CONNECTED_TO_clock_116_mhz_clk,                                          --                                 clock_116_mhz.clk
			external_sdram_controller_wire_addr                        => CONNECTED_TO_external_sdram_controller_wire_addr,                        --                external_sdram_controller_wire.addr
			external_sdram_controller_wire_ba                          => CONNECTED_TO_external_sdram_controller_wire_ba,                          --                                              .ba
			external_sdram_controller_wire_cas_n                       => CONNECTED_TO_external_sdram_controller_wire_cas_n,                       --                                              .cas_n
			external_sdram_controller_wire_cke                         => CONNECTED_TO_external_sdram_controller_wire_cke,                         --                                              .cke
			external_sdram_controller_wire_cs_n                        => CONNECTED_TO_external_sdram_controller_wire_cs_n,                        --                                              .cs_n
			external_sdram_controller_wire_dq                          => CONNECTED_TO_external_sdram_controller_wire_dq,                          --                                              .dq
			external_sdram_controller_wire_dqm                         => CONNECTED_TO_external_sdram_controller_wire_dqm,                         --                                              .dqm
			external_sdram_controller_wire_ras_n                       => CONNECTED_TO_external_sdram_controller_wire_ras_n,                       --                                              .ras_n
			external_sdram_controller_wire_we_n                        => CONNECTED_TO_external_sdram_controller_wire_we_n,                        --                                              .we_n
			sega_saturn_abus_slave_0_abus_address                      => CONNECTED_TO_sega_saturn_abus_slave_0_abus_address,                      --                 sega_saturn_abus_slave_0_abus.address
			sega_saturn_abus_slave_0_abus_chipselect                   => CONNECTED_TO_sega_saturn_abus_slave_0_abus_chipselect,                   --                                              .chipselect
			sega_saturn_abus_slave_0_abus_read                         => CONNECTED_TO_sega_saturn_abus_slave_0_abus_read,                         --                                              .read
			sega_saturn_abus_slave_0_abus_write                        => CONNECTED_TO_sega_saturn_abus_slave_0_abus_write,                        --                                              .write
			sega_saturn_abus_slave_0_abus_waitrequest                  => CONNECTED_TO_sega_saturn_abus_slave_0_abus_waitrequest,                  --                                              .waitrequest
			sega_saturn_abus_slave_0_abus_interrupt                    => CONNECTED_TO_sega_saturn_abus_slave_0_abus_interrupt,                    --                                              .interrupt
			sega_saturn_abus_slave_0_abus_addressdata                  => CONNECTED_TO_sega_saturn_abus_slave_0_abus_addressdata,                  --                                              .addressdata
			sega_saturn_abus_slave_0_abus_direction                    => CONNECTED_TO_sega_saturn_abus_slave_0_abus_direction,                    --                                              .direction
			sega_saturn_abus_slave_0_abus_muxing                       => CONNECTED_TO_sega_saturn_abus_slave_0_abus_muxing,                       --                                              .muxing
			sega_saturn_abus_slave_0_abus_disableout                   => CONNECTED_TO_sega_saturn_abus_slave_0_abus_disableout,                   --                                              .disableout
			sega_saturn_abus_slave_0_conduit_saturn_reset_saturn_reset => CONNECTED_TO_sega_saturn_abus_slave_0_conduit_saturn_reset_saturn_reset, -- sega_saturn_abus_slave_0_conduit_saturn_reset.saturn_reset
			spi_sd_card_MISO                                           => CONNECTED_TO_spi_sd_card_MISO,                                           --                                   spi_sd_card.MISO
			spi_sd_card_MOSI                                           => CONNECTED_TO_spi_sd_card_MOSI,                                           --                                              .MOSI
			spi_sd_card_SCLK                                           => CONNECTED_TO_spi_sd_card_SCLK,                                           --                                              .SCLK
			spi_sd_card_SS_n                                           => CONNECTED_TO_spi_sd_card_SS_n,                                           --                                              .SS_n
			spi_stm32_MISO                                             => CONNECTED_TO_spi_stm32_MISO,                                             --                                     spi_stm32.MISO
			spi_stm32_MOSI                                             => CONNECTED_TO_spi_stm32_MOSI,                                             --                                              .MOSI
			spi_stm32_SCLK                                             => CONNECTED_TO_spi_stm32_SCLK,                                             --                                              .SCLK
			spi_stm32_SS_n                                             => CONNECTED_TO_spi_stm32_SS_n,                                             --                                              .SS_n
			uart_0_external_connection_rxd                             => CONNECTED_TO_uart_0_external_connection_rxd,                             --                    uart_0_external_connection.rxd
			uart_0_external_connection_txd                             => CONNECTED_TO_uart_0_external_connection_txd                              --                                              .txd
		);

