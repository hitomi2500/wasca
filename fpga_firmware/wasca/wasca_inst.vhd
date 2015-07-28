	component wasca is
		port (
			altpll_0_areset_conduit_export                              : in    std_logic                     := 'X';             -- export
			altpll_0_locked_conduit_export                              : out   std_logic;                                        -- export
			altpll_0_phasedone_conduit_export                           : out   std_logic;                                        -- export
			clk_clk                                                     : in    std_logic                     := 'X';             -- clk
			clock_116_mhz_clk                                           : out   std_logic;                                        -- clk
			external_sdram_controller_wire_addr                         : out   std_logic_vector(12 downto 0);                    -- addr
			external_sdram_controller_wire_ba                           : out   std_logic_vector(1 downto 0);                     -- ba
			external_sdram_controller_wire_cas_n                        : out   std_logic;                                        -- cas_n
			external_sdram_controller_wire_cke                          : out   std_logic;                                        -- cke
			external_sdram_controller_wire_cs_n                         : out   std_logic;                                        -- cs_n
			external_sdram_controller_wire_dq                           : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			external_sdram_controller_wire_dqm                          : out   std_logic_vector(1 downto 0);                     -- dqm
			external_sdram_controller_wire_ras_n                        : out   std_logic;                                        -- ras_n
			external_sdram_controller_wire_we_n                         : out   std_logic;                                        -- we_n
			pio_0_external_connection_export                            : inout std_logic_vector(3 downto 0)  := (others => 'X'); -- export
			reset_reset_n                                               : in    std_logic                     := 'X';             -- reset_n
			reset_0_reset_n                                             : in    std_logic                     := 'X';             -- reset_n
			sega_saturn_abus_slave_0_abus_address                       : in    std_logic_vector(9 downto 0)  := (others => 'X'); -- address
			sega_saturn_abus_slave_0_abus_chipselect                    : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- chipselect
			sega_saturn_abus_slave_0_abus_read                          : in    std_logic                     := 'X';             -- read
			sega_saturn_abus_slave_0_abus_write                         : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- write
			sega_saturn_abus_slave_0_abus_functioncode                  : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- functioncode
			sega_saturn_abus_slave_0_abus_timing                        : in    std_logic_vector(2 downto 0)  := (others => 'X'); -- timing
			sega_saturn_abus_slave_0_abus_waitrequest                   : out   std_logic;                                        -- waitrequest
			sega_saturn_abus_slave_0_abus_addressstrobe                 : in    std_logic                     := 'X';             -- addressstrobe
			sega_saturn_abus_slave_0_abus_interrupt                     : out   std_logic;                                        -- interrupt
			sega_saturn_abus_slave_0_abus_addressdata                   : inout std_logic_vector(15 downto 0) := (others => 'X'); -- addressdata
			sega_saturn_abus_slave_0_abus_direction                     : out   std_logic;                                        -- direction
			sega_saturn_abus_slave_0_abus_muxing                        : out   std_logic_vector(1 downto 0);                     -- muxing
			sega_saturn_abus_slave_0_abus_disableout                    : out   std_logic;                                        -- disableout
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_cmd   : inout std_logic                     := 'X';             -- b_SD_cmd
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat   : inout std_logic                     := 'X';             -- b_SD_dat
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat3  : inout std_logic                     := 'X';             -- b_SD_dat3
			altera_up_sd_card_avalon_interface_0_conduit_end_o_SD_clock : out   std_logic                                         -- o_SD_clock
		);
	end component wasca;

	u0 : component wasca
		port map (
			altpll_0_areset_conduit_export                              => CONNECTED_TO_altpll_0_areset_conduit_export,                              --                          altpll_0_areset_conduit.export
			altpll_0_locked_conduit_export                              => CONNECTED_TO_altpll_0_locked_conduit_export,                              --                          altpll_0_locked_conduit.export
			altpll_0_phasedone_conduit_export                           => CONNECTED_TO_altpll_0_phasedone_conduit_export,                           --                       altpll_0_phasedone_conduit.export
			clk_clk                                                     => CONNECTED_TO_clk_clk,                                                     --                                              clk.clk
			clock_116_mhz_clk                                           => CONNECTED_TO_clock_116_mhz_clk,                                           --                                    clock_116_mhz.clk
			external_sdram_controller_wire_addr                         => CONNECTED_TO_external_sdram_controller_wire_addr,                         --                   external_sdram_controller_wire.addr
			external_sdram_controller_wire_ba                           => CONNECTED_TO_external_sdram_controller_wire_ba,                           --                                                 .ba
			external_sdram_controller_wire_cas_n                        => CONNECTED_TO_external_sdram_controller_wire_cas_n,                        --                                                 .cas_n
			external_sdram_controller_wire_cke                          => CONNECTED_TO_external_sdram_controller_wire_cke,                          --                                                 .cke
			external_sdram_controller_wire_cs_n                         => CONNECTED_TO_external_sdram_controller_wire_cs_n,                         --                                                 .cs_n
			external_sdram_controller_wire_dq                           => CONNECTED_TO_external_sdram_controller_wire_dq,                           --                                                 .dq
			external_sdram_controller_wire_dqm                          => CONNECTED_TO_external_sdram_controller_wire_dqm,                          --                                                 .dqm
			external_sdram_controller_wire_ras_n                        => CONNECTED_TO_external_sdram_controller_wire_ras_n,                        --                                                 .ras_n
			external_sdram_controller_wire_we_n                         => CONNECTED_TO_external_sdram_controller_wire_we_n,                         --                                                 .we_n
			pio_0_external_connection_export                            => CONNECTED_TO_pio_0_external_connection_export,                            --                        pio_0_external_connection.export
			reset_reset_n                                               => CONNECTED_TO_reset_reset_n,                                               --                                            reset.reset_n
			reset_0_reset_n                                             => CONNECTED_TO_reset_0_reset_n,                                             --                                          reset_0.reset_n
			sega_saturn_abus_slave_0_abus_address                       => CONNECTED_TO_sega_saturn_abus_slave_0_abus_address,                       --                    sega_saturn_abus_slave_0_abus.address
			sega_saturn_abus_slave_0_abus_chipselect                    => CONNECTED_TO_sega_saturn_abus_slave_0_abus_chipselect,                    --                                                 .chipselect
			sega_saturn_abus_slave_0_abus_read                          => CONNECTED_TO_sega_saturn_abus_slave_0_abus_read,                          --                                                 .read
			sega_saturn_abus_slave_0_abus_write                         => CONNECTED_TO_sega_saturn_abus_slave_0_abus_write,                         --                                                 .write
			sega_saturn_abus_slave_0_abus_functioncode                  => CONNECTED_TO_sega_saturn_abus_slave_0_abus_functioncode,                  --                                                 .functioncode
			sega_saturn_abus_slave_0_abus_timing                        => CONNECTED_TO_sega_saturn_abus_slave_0_abus_timing,                        --                                                 .timing
			sega_saturn_abus_slave_0_abus_waitrequest                   => CONNECTED_TO_sega_saturn_abus_slave_0_abus_waitrequest,                   --                                                 .waitrequest
			sega_saturn_abus_slave_0_abus_addressstrobe                 => CONNECTED_TO_sega_saturn_abus_slave_0_abus_addressstrobe,                 --                                                 .addressstrobe
			sega_saturn_abus_slave_0_abus_interrupt                     => CONNECTED_TO_sega_saturn_abus_slave_0_abus_interrupt,                     --                                                 .interrupt
			sega_saturn_abus_slave_0_abus_addressdata                   => CONNECTED_TO_sega_saturn_abus_slave_0_abus_addressdata,                   --                                                 .addressdata
			sega_saturn_abus_slave_0_abus_direction                     => CONNECTED_TO_sega_saturn_abus_slave_0_abus_direction,                     --                                                 .direction
			sega_saturn_abus_slave_0_abus_muxing                        => CONNECTED_TO_sega_saturn_abus_slave_0_abus_muxing,                        --                                                 .muxing
			sega_saturn_abus_slave_0_abus_disableout                    => CONNECTED_TO_sega_saturn_abus_slave_0_abus_disableout,                    --                                                 .disableout
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_cmd   => CONNECTED_TO_altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_cmd,   -- altera_up_sd_card_avalon_interface_0_conduit_end.b_SD_cmd
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat   => CONNECTED_TO_altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat,   --                                                 .b_SD_dat
			altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat3  => CONNECTED_TO_altera_up_sd_card_avalon_interface_0_conduit_end_b_SD_dat3,  --                                                 .b_SD_dat3
			altera_up_sd_card_avalon_interface_0_conduit_end_o_SD_clock => CONNECTED_TO_altera_up_sd_card_avalon_interface_0_conduit_end_o_SD_clock  --                                                 .o_SD_clock
		);

