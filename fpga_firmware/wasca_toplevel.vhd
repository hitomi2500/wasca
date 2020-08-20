-- wasca.vhd

-- Generated using ACDS version 14.1 186 at 2015.05.28.08:37:08

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity wasca_toplevel is
	port (
		clk_clk                                     : in    std_logic                     := '0';             --                            clk.clk
		external_sdram_controller_wire_addr         : out   std_logic_vector(12 downto 0);                    -- external_sdram_controller_wire.addr
		external_sdram_controller_wire_ba           : out   std_logic_vector(1 downto 0);                                        --                               .ba
		external_sdram_controller_wire_cas_n        : out   std_logic;                                        --                               .cas_n
		external_sdram_controller_wire_cke          : out   std_logic;                                        --                               .cke
		external_sdram_controller_wire_cs_n         : out   std_logic;                                        --                               .cs_n
		external_sdram_controller_wire_dq           : inout std_logic_vector(15 downto 0) := (others => '0'); --                               .dq
		external_sdram_controller_wire_dqm          : out   std_logic_vector(1 downto 0);                     --                               .dqm
		external_sdram_controller_wire_ras_n        : out   std_logic;                                        --                               .ras_n
		external_sdram_controller_wire_we_n         : out   std_logic;                                        --                               .we_n
		external_sdram_controller_wire_clk          : out   std_logic;                                        --                               .clk
		reset_reset_n                               : in    std_logic                     := '0';             --                          reset.reset_n
		sega_saturn_abus_slave_0_abus_address       : in    std_logic_vector(25 downto 16) := (others => '0'); --  sega_saturn_abus_slave_0_abus.address
		sega_saturn_abus_slave_0_abus_addressdata   : inout std_logic_vector(15 downto 0) := (others => '0'); --                               .data
		sega_saturn_abus_slave_0_abus_chipselect    : in    std_logic_vector(2 downto 0)  := (others => '0'); --                               .chipselect
		sega_saturn_abus_slave_0_abus_read          : in    std_logic                     := '0';             --                               .read
		sega_saturn_abus_slave_0_abus_write         : in    std_logic_vector(1 downto 0)  := (others => '0'); --                               .write
		sega_saturn_abus_slave_0_abus_waitrequest   : out   std_logic;                                        --                               .waitrequest
		sega_saturn_abus_slave_0_abus_interrupt     : out    std_logic                     := '0';              --                               .interrupt
		sega_saturn_abus_slave_0_abus_disableout   : out   std_logic                     := '0';              --                               .muxing
		sega_saturn_abus_slave_0_abus_muxing	     : out   std_logic_vector(1	 downto 0)  := (others => '0'); --                               .muxing
		sega_saturn_abus_slave_0_abus_direction	  : out   std_logic                     := '0';              --                               .direction
		spi_sd_card_MISO                                           : in    std_logic                     := '0';             -- MISO
		spi_sd_card_MOSI                                           : out   std_logic;                                        -- MOSI
		spi_sd_card_SCLK                                           : out   std_logic;                                        -- SCLK
		spi_sd_card_SS_n                                           : out   std_logic;                                        -- SS_n
		uart_0_external_connection_txd : out   std_logic                     := '0'   ;
		spi_stm32_MISO                              : out   std_logic;                                        -- MISO
		spi_stm32_MOSI                              : in    std_logic                     := '0';             -- MOSI
		spi_stm32_SCLK                              : in    std_logic                     := '0';             -- SCLK
		spi_stm32_SS_n                              : in    std_logic                     := '0';             -- SS_n
		audio_out_BCLK                              : in    std_logic                     := '0';             -- BCLK
		audio_out_DACDAT                            : out   std_logic;                                        -- DACDAT
		audio_out_DACLRCK                           : in    std_logic                     := '0';              -- DACLRCK
		audio_SSEL                           		  : out    std_logic                     := '0'
	);
end entity wasca_toplevel;

architecture rtl of wasca_toplevel is


	component wasca is
		port (
			abus_avalon_sdram_bridge_0_abus_address           : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- address
			abus_avalon_sdram_bridge_0_abus_read              : in    std_logic                     := 'X';             -- read
			abus_avalon_sdram_bridge_0_abus_waitrequest       : out   std_logic;                                        -- waitrequest
			abus_avalon_sdram_bridge_0_abus_addressdata       : inout std_logic_vector(15 downto 0) := (others => 'X'); -- addressdata
			abus_avalon_sdram_bridge_0_abus_chipselect        : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- chipselect
			abus_avalon_sdram_bridge_0_abus_direction         : out   std_logic;                                        -- direction
			abus_avalon_sdram_bridge_0_abus_disable_out       : out   std_logic;                                        -- disable_out
			abus_avalon_sdram_bridge_0_abus_interrupt         : out   std_logic;                                        -- interrupt
			abus_avalon_sdram_bridge_0_abus_muxing            : out   std_logic_vector(1 downto 0);                     -- muxing
			abus_avalon_sdram_bridge_0_abus_writebyteenable_n : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- writebyteenable_n
			abus_avalon_sdram_bridge_0_abus_reset             : in    std_logic                     := 'X';             -- reset
			abus_avalon_sdram_bridge_0_sdram_addr             : out   std_logic_vector(12 downto 0);                    -- addr
			abus_avalon_sdram_bridge_0_sdram_ba               : out   std_logic_vector(1 downto 0);                     -- ba
			abus_avalon_sdram_bridge_0_sdram_cas_n            : out   std_logic;                                        -- cas_n
			abus_avalon_sdram_bridge_0_sdram_cke              : out   std_logic;                                        -- cke
			abus_avalon_sdram_bridge_0_sdram_cs_n             : out   std_logic;                                        -- cs_n
			abus_avalon_sdram_bridge_0_sdram_dq               : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			abus_avalon_sdram_bridge_0_sdram_dqm              : out   std_logic_vector(1 downto 0);                     -- dqm
			abus_avalon_sdram_bridge_0_sdram_ras_n            : out   std_logic;                                        -- ras_n
			abus_avalon_sdram_bridge_0_sdram_we_n             : out   std_logic;                                        -- we_n
			abus_avalon_sdram_bridge_0_sdram_clk              : out   std_logic;                                        -- clk
			audio_out_BCLK                                    : in    std_logic                     := 'X';             -- BCLK
			audio_out_DACDAT                                  : out   std_logic;                                        -- DACDAT
			audio_out_DACLRCK                                 : in    std_logic                     := 'X';             -- DACLRCK
			clk_clk                                           : in    std_logic                     := 'X';             -- clk
			clock_116_mhz_clk                                 : out   std_logic;                                        -- clk
			spi_sd_card_MISO                                  : in    std_logic                     := 'X';             -- MISO
			spi_sd_card_MOSI                                  : out   std_logic;                                        -- MOSI
			spi_sd_card_SCLK                                  : out   std_logic;                                        -- SCLK
			spi_sd_card_SS_n                                  : out   std_logic;                                        -- SS_n
			spi_stm32_MISO                                    : out   std_logic;                                        -- MISO
			spi_stm32_MOSI                                    : in    std_logic                     := 'X';             -- MOSI
			spi_stm32_SCLK                                    : in    std_logic                     := 'X';             -- SCLK
			spi_stm32_SS_n                                    : in    std_logic                     := 'X';             -- SS_n
			uart_0_external_connection_rxd                    : in    std_logic                     := 'X';             -- rxd
			uart_0_external_connection_txd                    : out   std_logic;                                        -- txd
			reset_reset_n                                     : in    std_logic                     := 'X';             -- reset_n
			altpll_1_areset_conduit_export                    : in    std_logic                     := 'X';             -- export
			altpll_1_locked_conduit_export                    : out   std_logic;                                        -- export
			altpll_1_phasedone_conduit_export                 : out   std_logic                                         -- export
		);
	end component;


	signal altpll_1_areset_conduit_export : std_logic := '0';
	signal altpll_1_locked_conduit_export : std_logic := '0';
	signal altpll_1_phasedone_conduit_export : std_logic := '0';
	
	--signal sega_saturn_abus_slave_0_abus_address_demuxed : std_logic_vector(25 downto 0) := (others => '0');
	--signal sega_saturn_abus_slave_0_abus_data_demuxed : std_logic_vector(15 downto 0) := (others => '0');
		
	signal clock_116_mhz : std_logic := '0';
	
	begin
	
	--sega_saturn_abus_slave_0_abus_muxing (0) <= not sega_saturn_abus_slave_0_abus_muxing(1);
	
	external_sdram_controller_wire_clk <= not clock_116_mhz;
	
	my_little_wasca : component wasca
		port map (
			clk_clk => clk_clk,
			clock_116_mhz_clk => clock_116_mhz,
			abus_avalon_sdram_bridge_0_sdram_addr => external_sdram_controller_wire_addr,
			abus_avalon_sdram_bridge_0_sdram_ba => external_sdram_controller_wire_ba,
			abus_avalon_sdram_bridge_0_sdram_cas_n => external_sdram_controller_wire_cas_n,
			abus_avalon_sdram_bridge_0_sdram_cke => external_sdram_controller_wire_cke,
			abus_avalon_sdram_bridge_0_sdram_cs_n => external_sdram_controller_wire_cs_n,
			abus_avalon_sdram_bridge_0_sdram_dq => external_sdram_controller_wire_dq,
			abus_avalon_sdram_bridge_0_sdram_dqm => external_sdram_controller_wire_dqm,
			abus_avalon_sdram_bridge_0_sdram_ras_n => external_sdram_controller_wire_ras_n,
			abus_avalon_sdram_bridge_0_sdram_we_n => external_sdram_controller_wire_we_n,
			abus_avalon_sdram_bridge_0_abus_address => sega_saturn_abus_slave_0_abus_address,
			abus_avalon_sdram_bridge_0_abus_chipselect => "1"&sega_saturn_abus_slave_0_abus_chipselect(1 downto 0),--work only with CS1 and CS0 for now
			abus_avalon_sdram_bridge_0_abus_read => sega_saturn_abus_slave_0_abus_read,
			abus_avalon_sdram_bridge_0_abus_writebyteenable_n => sega_saturn_abus_slave_0_abus_write,
			abus_avalon_sdram_bridge_0_abus_waitrequest => sega_saturn_abus_slave_0_abus_waitrequest,
			abus_avalon_sdram_bridge_0_abus_interrupt => sega_saturn_abus_slave_0_abus_interrupt,
			abus_avalon_sdram_bridge_0_abus_addressdata => sega_saturn_abus_slave_0_abus_addressdata,
			abus_avalon_sdram_bridge_0_abus_direction => sega_saturn_abus_slave_0_abus_direction,
			abus_avalon_sdram_bridge_0_abus_muxing => sega_saturn_abus_slave_0_abus_muxing,
			abus_avalon_sdram_bridge_0_abus_disable_out => sega_saturn_abus_slave_0_abus_disableout,
			abus_avalon_sdram_bridge_0_abus_reset => reset_reset_n,
			spi_sd_card_MISO => spi_sd_card_MISO,
			spi_sd_card_MOSI => spi_sd_card_MOSI,
			spi_sd_card_SCLK => spi_sd_card_SCLK,
			spi_sd_card_SS_n => spi_sd_card_SS_n,
			altpll_1_areset_conduit_export => altpll_1_areset_conduit_export,
			altpll_1_locked_conduit_export => altpll_1_locked_conduit_export,
			altpll_1_phasedone_conduit_export => altpll_1_phasedone_conduit_export,
			uart_0_external_connection_rxd => '0',
			uart_0_external_connection_txd => uart_0_external_connection_txd,
			spi_stm32_MISO => spi_stm32_MISO,
			spi_stm32_MOSI => spi_stm32_MOSI,
			spi_stm32_SCLK => spi_stm32_SCLK,
			spi_stm32_SS_n => spi_stm32_SS_n,
			audio_out_BCLK => audio_out_BCLK,
			audio_out_DACDAT => audio_out_DACDAT,
			audio_out_DACLRCK => audio_out_DACLRCK,
			reset_reset_n => '1'
		);

		--empty subsystem
--		external_sdram_controller_wire_addr <= (others => 'Z');
--		external_sdram_controller_wire_ba <= (others => 'Z');
--		external_sdram_controller_wire_cas_n <= (others => 'Z');
--		external_sdram_controller_wire_cke <= (others => 'Z');
--		external_sdram_controller_wire_cs_n <= (others => 'Z');
--		external_sdram_controller_wire_dq <= (others => 'Z');
--		external_sdram_controller_wire_dqm <= (others => 'Z');
--		external_sdram_controller_wire_ras_n <= (others => 'Z');
--		external_sdram_controller_wire_we_n  <= (others => 'Z');
--		external_sdram_controller_wire_clk <= (others => 'Z');
--		sega_saturn_abus_slave_0_abus_addressdata <= (others => 'Z');
--		sega_saturn_abus_slave_0_abus_waitrequest <= (others => 'Z');
--		sega_saturn_abus_slave_0_abus_interrupt <= (others => 'Z');
--		sega_saturn_abus_slave_0_abus_disableout <= '1';
--		sega_saturn_abus_slave_0_abus_muxing <= "00";
--		sega_saturn_abus_slave_0_abus_direction <= '0';
--		spi_sd_card_MOSI <= 'Z';
--		spi_sd_card_SCLK <= 'Z';
--		spi_sd_card_SS_n <= 'Z';
--		uart_0_external_connection_txd <= 'Z';
--		spi_stm32_MISO <= 'Z';
--		audio_out_DACDAT <= 'Z';

		
		audio_SSEL <= '0';
		--sega_saturn_abus_slave_0_abus_waitrequest <= '1';
		--sega_saturn_abus_slave_0_abus_direction <= '0';
		--sega_saturn_abus_slave_0_abus_muxing <= "01";

end architecture rtl; -- of wasca_toplevel
