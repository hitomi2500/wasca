-- sega_saturn_abus_slave.vhd

-- This file was auto-generated as a prototype implementation of a module
-- created in component editor.  It ties off all outputs to ground and
-- ignores all inputs.  It needs to be edited to make it do something
-- useful.
-- 
-- This file will not be automatically regenerated.  You should check it in
-- to your version control system if you want to keep it.

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sega_saturn_abus_slave is
	port (
		clock                : in    std_logic                     := '0';             --         clock.clk
		abus_address         : in    std_logic_vector(25 downto 0) := (others => '0'); --          abus.address
		abus_readdata            : out std_logic_vector(15 downto 0) := (others => '0'); --              .data
		abus_writedata            : in std_logic_vector(15 downto 0) := (others => '0'); --              .data
		abus_chipselect      : in    std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
		abus_read            : in    std_logic                     := '0';             --              .read
		abus_write           : in    std_logic_vector(1 downto 0)  := (others => '0'); --              .write
		abus_functioncode    : in    std_logic_vector(1 downto 0)  := (others => '0'); --              .functioncode
		abus_timing          : in    std_logic_vector(2 downto 0)  := (others => '0'); --              .timing
		abus_waitrequest     : out   std_logic;                                        --              .waitrequest
		abus_addressstrobe   : in    std_logic                     := '0';             --              .addressstrobe
		abus_interrupt       : in    std_logic                     := '0';             --              .interrupt
		avalon_read          : out   std_logic;                                        -- avalon_master.read
		avalon_write         : out   std_logic;                                        --              .write
		avalon_waitrequest   : in    std_logic                     := '0';             --              .waitrequest
		avalon_address       : out   std_logic_vector(25 downto 0);                    --              .address
		avalon_readdata      : in    std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
		avalon_writedata     : out   std_logic_vector(15 downto 0);                    --              .writedata
		avalon_burstcount    : out   std_logic;                                        --              .burstcount
		avalon_readdatavalid : in    std_logic                     := '0';             --              .readdatavalid
		reset                : in    std_logic                     := '0'              --         reset.reset
	);
end entity sega_saturn_abus_slave;

architecture rtl of sega_saturn_abus_slave is
begin

	-- TODO: Auto-generated HDL template

	abus_waitrequest <= '0';

	abus_readdata <= "0000000000000000";

	avalon_read <= '0';

	avalon_address <= "00000000000000000000000000";

	avalon_write <= '0';

	avalon_writedata <= "0000000000000000";

	avalon_burstcount <= '0';

end architecture rtl; -- of sega_saturn_abus_slave
