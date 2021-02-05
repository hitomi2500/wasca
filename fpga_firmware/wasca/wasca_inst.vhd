	component wasca is
		port (
			abus_avalon_sdram_bridge_0_abus_address               : in    std_logic_vector(24 downto 0) := (others => 'X'); -- address
			abus_avalon_sdram_bridge_0_abus_read                  : in    std_logic                     := 'X';             -- read
			abus_avalon_sdram_bridge_0_abus_data                  : inout std_logic_vector(15 downto 0) := (others => 'X'); -- data
			abus_avalon_sdram_bridge_0_abus_chipselect            : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- chipselect
			abus_avalon_sdram_bridge_0_abus_direction             : out   std_logic;                                        -- direction
			abus_avalon_sdram_bridge_0_abus_interrupt_disable_out : out   std_logic;                                        -- interrupt_disable_out
			abus_avalon_sdram_bridge_0_abus_interrupt             : out   std_logic;                                        -- interrupt
			abus_avalon_sdram_bridge_0_abus_writebyteenable_n     : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- writebyteenable_n
			abus_avalon_sdram_bridge_0_abus_reset                 : in    std_logic                     := 'X';             -- reset
			abus_avalon_sdram_bridge_0_sdram_addr                 : out   std_logic_vector(12 downto 0);                    -- addr
			abus_avalon_sdram_bridge_0_sdram_ba                   : out   std_logic_vector(1 downto 0);                     -- ba
			abus_avalon_sdram_bridge_0_sdram_cas_n                : out   std_logic;                                        -- cas_n
			abus_avalon_sdram_bridge_0_sdram_cke                  : out   std_logic;                                        -- cke
			abus_avalon_sdram_bridge_0_sdram_cs_n                 : out   std_logic;                                        -- cs_n
			abus_avalon_sdram_bridge_0_sdram_dq                   : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			abus_avalon_sdram_bridge_0_sdram_dqm                  : out   std_logic_vector(1 downto 0);                     -- dqm
			abus_avalon_sdram_bridge_0_sdram_ras_n                : out   std_logic;                                        -- ras_n
			abus_avalon_sdram_bridge_0_sdram_we_n                 : out   std_logic;                                        -- we_n
			abus_avalon_sdram_bridge_0_sdram_clk                  : out   std_logic;                                        -- clk
			buffered_spi_mosi                                     : out   std_logic;                                        -- mosi
			buffered_spi_clk                                      : out   std_logic;                                        -- clk
			buffered_spi_miso                                     : in    std_logic                     := 'X';             -- miso
			buffered_spi_cs                                       : out   std_logic;                                        -- cs
			buffered_spi_sync                                     : in    std_logic                     := 'X';             -- sync
			clk_clk                                               : in    std_logic                     := 'X';             -- clk
			clock_116_mhz_clk                                     : out   std_logic;                                        -- clk
			heartbeat_heartbeat_out                               : out   std_logic;                                        -- heartbeat_out
			reset_reset_n                                         : in    std_logic                     := 'X';             -- reset_n
			reset_controller_0_reset_in1_reset                    : in    std_logic                     := 'X';             -- reset
			uart_0_external_connection_rxd                        : in    std_logic                     := 'X';             -- rxd
			uart_0_external_connection_txd                        : out   std_logic                                         -- txd
		);
	end component wasca;

	u0 : component wasca
		port map (
			abus_avalon_sdram_bridge_0_abus_address               => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_address,               --  abus_avalon_sdram_bridge_0_abus.address
			abus_avalon_sdram_bridge_0_abus_read                  => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_read,                  --                                 .read
			abus_avalon_sdram_bridge_0_abus_data                  => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_data,                  --                                 .data
			abus_avalon_sdram_bridge_0_abus_chipselect            => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_chipselect,            --                                 .chipselect
			abus_avalon_sdram_bridge_0_abus_direction             => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_direction,             --                                 .direction
			abus_avalon_sdram_bridge_0_abus_interrupt_disable_out => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_interrupt_disable_out, --                                 .interrupt_disable_out
			abus_avalon_sdram_bridge_0_abus_interrupt             => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_interrupt,             --                                 .interrupt
			abus_avalon_sdram_bridge_0_abus_writebyteenable_n     => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_writebyteenable_n,     --                                 .writebyteenable_n
			abus_avalon_sdram_bridge_0_abus_reset                 => CONNECTED_TO_abus_avalon_sdram_bridge_0_abus_reset,                 --                                 .reset
			abus_avalon_sdram_bridge_0_sdram_addr                 => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_addr,                 -- abus_avalon_sdram_bridge_0_sdram.addr
			abus_avalon_sdram_bridge_0_sdram_ba                   => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_ba,                   --                                 .ba
			abus_avalon_sdram_bridge_0_sdram_cas_n                => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_cas_n,                --                                 .cas_n
			abus_avalon_sdram_bridge_0_sdram_cke                  => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_cke,                  --                                 .cke
			abus_avalon_sdram_bridge_0_sdram_cs_n                 => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_cs_n,                 --                                 .cs_n
			abus_avalon_sdram_bridge_0_sdram_dq                   => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_dq,                   --                                 .dq
			abus_avalon_sdram_bridge_0_sdram_dqm                  => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_dqm,                  --                                 .dqm
			abus_avalon_sdram_bridge_0_sdram_ras_n                => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_ras_n,                --                                 .ras_n
			abus_avalon_sdram_bridge_0_sdram_we_n                 => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_we_n,                 --                                 .we_n
			abus_avalon_sdram_bridge_0_sdram_clk                  => CONNECTED_TO_abus_avalon_sdram_bridge_0_sdram_clk,                  --                                 .clk
			buffered_spi_mosi                                     => CONNECTED_TO_buffered_spi_mosi,                                     --                     buffered_spi.mosi
			buffered_spi_clk                                      => CONNECTED_TO_buffered_spi_clk,                                      --                                 .clk
			buffered_spi_miso                                     => CONNECTED_TO_buffered_spi_miso,                                     --                                 .miso
			buffered_spi_cs                                       => CONNECTED_TO_buffered_spi_cs,                                       --                                 .cs
			buffered_spi_sync                                     => CONNECTED_TO_buffered_spi_sync,                                     --                                 .sync
			clk_clk                                               => CONNECTED_TO_clk_clk,                                               --                              clk.clk
			clock_116_mhz_clk                                     => CONNECTED_TO_clock_116_mhz_clk,                                     --                    clock_116_mhz.clk
			heartbeat_heartbeat_out                               => CONNECTED_TO_heartbeat_heartbeat_out,                               --                        heartbeat.heartbeat_out
			reset_reset_n                                         => CONNECTED_TO_reset_reset_n,                                         --                            reset.reset_n
			reset_controller_0_reset_in1_reset                    => CONNECTED_TO_reset_controller_0_reset_in1_reset,                    --     reset_controller_0_reset_in1.reset
			uart_0_external_connection_rxd                        => CONNECTED_TO_uart_0_external_connection_rxd,                        --       uart_0_external_connection.rxd
			uart_0_external_connection_txd                        => CONNECTED_TO_uart_0_external_connection_txd                         --                                 .txd
		);

