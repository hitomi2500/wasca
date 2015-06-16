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

signal abus_address_buf         : std_logic_vector(25 downto 0) := (others => '0'); --          abus.address
signal abus_writedata_buf       : std_logic_vector(15 downto 0) := (others => '0'); --              .data
signal abus_chipselect_buf      : std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
signal abus_read_buf            : std_logic                     := '0';             --              .read
signal abus_write_buf           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write
signal abus_functioncode_buf    : std_logic_vector(1 downto 0)  := (others => '0'); --              .functioncode
signal abus_timing_buf          : std_logic_vector(2 downto 0)  := (others => '0'); --              .timing
signal abus_addressstrobe_buf   : std_logic                     := '0';             --              .addressstrobe
signal abus_interrupt_buf       : std_logic                     := '0';             --              .interrupt

signal abus_read_buf2            : std_logic                     := '0';             --              .read
signal abus_write_buf2           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write


signal avalon_readdata_latch    : std_logic_vector(15 downto 0) := (others => '0');

begin

	-- TODO: Auto-generated HDL template
	
	--abus transactions are async, so first we must latch incoming signals
	--to get rid of metastability
	process (clock)
	begin
		if rising_edge(clock) then
			abus_address_buf <= abus_address;
			abus_writedata_buf <= abus_address;
			abus_chipselect_buf <= abus_address;
			abus_read_buf <= abus_address;
			abus_write_buf <= abus_address;
			abus_functioncode_buf <= abus_address;
			abus_timing_buf <= abus_address;
			abus_addressstrobe_buf <= abus_address;
			abus_interrupt_buf <= abus_address;
		end if;
	end process;
	
	--abus read/write latch
	process (clock)
	begin
		if rising_edge(clock) then
			abus_write_buf2 <= abus_write_buf;
			abus_read_buf2 <= abus_read_buf;
		end if;
	end process;
	
	--abus write pulse is a rising??? edge if a write signal
	abus_write_pulse <= abus_write_buf and not abus_write_buf2;
	abus_read_pulse <= abus_read_buf and not abus_read_buf2;
	
	--avalon write logic
	process (clock)
	begin
		if rising_edge(clock) then
			if abus_write_pulse = '1' then
				avalon_write <= '1';
			elsif avalon_waitrequest='0' then
				avalon_write <= '0';
			end if;
		end if;
	end process;
	
	--avalon read logic
	
	
	--avalon-to-abus mapping
	avalon_address <= abus_address_buf;
	avalon_writedata <= abus_writedata_buf;
	abus_readdata_buf <= avalon_readdata;
	

	abus_waitrequest <= '0';

	abus_readdata <= "0000000000000000";

	avalon_read <= '0';

	

	avalon_write <= '0';

	avalon_writedata <= "0000000000000000";

	avalon_burstcount <= '0';

end architecture rtl; -- of sega_saturn_abus_slave
