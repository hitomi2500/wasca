-- sega_saturn_abus_slave.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sega_saturn_abus_slave is
	port (
		clock                : in    std_logic                     := '0';             --         clock.clk
		abus_address         : in    std_logic_vector(25 downto 16) := (others => '0'); --          abus.address
		abus_addressdata     : inout std_logic_vector(15 downto 0) := (others => '0'); --          abus.addressdata
		abus_chipselect      : in    std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
		abus_read            : in    std_logic                     := '0';             --              .read
		abus_write           : in    std_logic_vector(1 downto 0)  := (others => '0'); --              .write
		abus_functioncode    : in    std_logic_vector(1 downto 0)  := (others => '0'); --              .functioncode
		abus_timing          : in    std_logic_vector(2 downto 0)  := (others => '0'); --              .timing
		abus_waitrequest     : out   std_logic;                                        --              .waitrequest
		abus_addressstrobe   : in    std_logic                     := '0';             --              .addressstrobe
		abus_interrupt       : out    std_logic                     := '0';             --              .interrupt
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

signal abus_address_ms         : std_logic_vector(25 downto 16) := (others => '0'); --          abus.address
signal abus_address_buf         : std_logic_vector(25 downto 16) := (others => '0'); --          abus.address
signal abus_addressdata_ms       : std_logic_vector(15 downto 0) := (others => '0'); --              .data
signal abus_addressdata_buf       : std_logic_vector(15 downto 0) := (others => '0'); --              .data
signal abus_chipselect_ms      : std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
signal abus_chipselect_buf      : std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
signal abus_read_ms            : std_logic                     := '0';             --              .read
signal abus_read_buf            : std_logic                     := '0';             --              .read
signal abus_write_ms           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write
signal abus_write_buf           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write
signal abus_functioncode_ms    : std_logic_vector(1 downto 0)  := (others => '0'); --              .functioncode
signal abus_functioncode_buf    : std_logic_vector(1 downto 0)  := (others => '0'); --              .functioncode
signal abus_timing_ms          : std_logic_vector(2 downto 0)  := (others => '0'); --              .timing
signal abus_timing_buf          : std_logic_vector(2 downto 0)  := (others => '0'); --              .timing
signal abus_addressstrobe_ms   : std_logic                     := '0';             --              .addressstrobe
signal abus_addressstrobe_buf   : std_logic                     := '0';             --              .addressstrobe

signal abus_read_buf2            : std_logic                     := '0';             --              .read
signal abus_write_buf2           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write
signal abus_chipselect2          : std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect

signal abus_read_pulse           : std_logic                     := '0';             --              .read
signal abus_write_pulse           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write
signal abus_chipselect_pulse          : std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
signal abus_read_pulse_off           : std_logic                     := '0';             --              .read
signal abus_write_pulse_off           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write
signal abus_chipselect_pulse_off          : std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect

signal abus_anypulse            : std_logic                     := '0'; 
signal abus_anypulse2           : std_logic                     := '0'; 
signal abus_anypulse_off            : std_logic                     := '0'; 

signal abus_address_latched         : std_logic_vector(25 downto 0) := (others => '0'); --          abus.address
signal abus_chipselect_latched         : std_logic_vector(1 downto 0) := (others => '0'); --          abus.address
signal abus_direction            : std_logic                     := '0'; 
signal abus_muxing         : std_logic_vector(1 downto 0) := (others => '0'); --          abus.address
signal abus_data_out         : std_logic_vector(15 downto 0) := (others => '0');
signal abus_data_in         : std_logic_vector(15 downto 0) := (others => '0');
signal abus_waitrequest_read            : std_logic                     := '0'; 
signal abus_waitrequest_write            : std_logic                     := '0'; 


TYPE transaction_dir IS (DIR_NONE,DIR_WRITE,DIR_READ);
SIGNAL my_little_transaction_dir : transaction_dir := DIR_NONE; 

signal avalon_readdata_latch    : std_logic_vector(15 downto 0) := (others => '0');

begin
	
	--ignoring functioncode, timing and addressstrobe for now
	
	--abus transactions are async, so first we must latch incoming signals
	--to get rid of metastability
	process (clock)
	begin
		if rising_edge(clock) then
			--1st stage
			abus_address_ms <= abus_address;
			abus_addressdata_ms <= abus_addressdata;
			abus_chipselect_ms <= abus_chipselect;
			abus_read_ms <= abus_read;
			abus_write_ms <= abus_write;
			abus_functioncode_ms <= abus_functioncode;
			abus_timing_ms <= abus_timing;
			abus_addressstrobe_ms <= abus_addressstrobe;
			--2nd stage
			abus_address_buf <= abus_address_ms;
			abus_addressdata_buf <= abus_addressdata_ms;
			abus_chipselect_buf <= abus_chipselect_ms;
			abus_read_buf <= abus_read_ms;
			abus_write_buf <= abus_write_ms;
			abus_functioncode_buf <= abus_functioncode_ms;
			abus_timing_buf <= abus_timing_ms;
			abus_addressstrobe_buf <= abus_addressstrobe_ms;
		end if;
	end process;
	
	--abus read/write latch
	process (clock)
	begin
		if rising_edge(clock) then
			abus_write_buf2 <= abus_write_buf;
			abus_read_buf2 <= abus_read_buf;
			abus_chipselect2 <= abus_chipselect;
			abus_anypulse2 <= abus_anypulse;
		end if;
	end process;
	
	--abus write/read pulse is a falling edge since read and write signals are negative polarity
	abus_write_pulse <= abus_write_buf2 and not abus_write_buf;
	abus_read_pulse <= abus_read_buf2 and not abus_read_buf;
	abus_chipselect_pulse <= abus_chipselect2 and not abus_chipselect;
	abus_write_pulse_off <= abus_write_buf and not abus_write_buf2;
	abus_read_pulse_off <= abus_read_buf and not abus_read_buf2;
	abus_chipselect_pulse_off <= abus_chipselect and not abus_chipselect2;
	
	abus_anypulse <= abus_write_pulse(0) or abus_write_pulse(1) or abus_read_pulse or 
				abus_chipselect_pulse(0) or abus_chipselect_pulse(1) or abus_chipselect_pulse(2);
	abus_anypulse_off <= abus_write_pulse_off(0) or abus_write_pulse_off(1) or abus_read_pulse_off or 
				abus_chipselect_pulse_off(0) or abus_chipselect_pulse_off(1) or abus_chipselect_pulse_off(2);
	
	--whatever pulse we've got, latch address
	--it might be latched twice per transaction, but it's not a problem
	--multiplexer was switched to address after previous transaction or after boot,
	--so we have address ready to latch
	process (clock)
	begin
		if rising_edge(clock) then
			if abus_anypulse = '1' then
				abus_address_latched <= abus_address & abus_addressdata;
			end if;
		end if;
	end process;
	
	--latch transaction direction
	process (clock)
	begin
		if rising_edge(clock) then
			if abus_write_pulse(0) = '1' or abus_write_pulse(1) = '1' then
				my_little_transaction_dir <= DIR_WRITE;
			elsif abus_read_pulse = '1' then
				my_little_transaction_dir <= DIR_READ;
			elsif abus_anypulse_off = '1' then
				my_little_transaction_dir <= DIR_NONE;
			end if;
		end if;
	end process;

	--latch chipselect number
	process (clock)
	begin
		if rising_edge(clock) then
			if abus_chipselect_pulse(0) = '1' then
				abus_chipselect_latched <= "00";
			elsif abus_chipselect_pulse(1) = '1' then
				abus_chipselect_latched <= "01";
			elsif abus_chipselect_pulse(2) = '1' then
				abus_chipselect_latched <= "10";
			elsif abus_anypulse_off = '1' then
				abus_chipselect_latched <= "11";
			end if;
		end if;
	end process;
	
	--if valid transaction captured, switch to corresponding multiplex mode
	process (clock)
	begin
		if rising_edge(clock) then
			if abus_chipselect_latched = "11" then
				--chipselect deasserted
				abus_direction <= '0'; --high-z
				abus_muxing <= "00"; --address
			else
				--chipselect asserted
				case (my_little_transaction_dir) is
					when DIR_NONE => 
						abus_direction <= '0'; --high-z
						abus_muxing <= "11"; --data
					when DIR_READ =>
						abus_direction <= '1'; --active
						abus_muxing <= "11"; --data
					when DIR_WRITE =>
						abus_direction <= '0'; --high-z
						abus_muxing <= "11"; --data
				end case;
			end if;
		end if;
	end process;
	
	--if abus read access is detected, issue avalon read transaction
	--wait until readdatavalid, then disable read and abus wait
	process (clock)
	begin
		if rising_edge(clock) then
			if my_little_transaction_dir = DIR_READ and abus_chipselect_latched != "11" then
				avalon_read <= '1';
				abus_waitrequest_read <= '1';
			elsif avalon_readdatavalid = '1' then
				avalon_read <= '0';
				abus_waitrequest_read <= '0';
				abus_data_out <= avalon_readdata;
			end if;
		end if;
	end process;

	--if abus write access is detected, issue avalon write transaction
	--disable abus wait immediately
	--TODO: check if avalon_writedata is already valid at this moment
	process (clock)
	begin
		if rising_edge(clock) then
			if my_little_transaction_dir = DIR_WRITE and abus_chipselect_latched != "11" then
				avalon_write <= '1';
				abus_waitrequest_write <= '1';
			else
				avalon_write <= '0';
				abus_waitrequest_read <= '0';
			end if;
		end if;
	end process;
	
	
	--avalon-to-abus mapping
	avalon_address <= abus_address_latched;
	avalon_writedata <= abus_addressdata_buf;
	avalon_burstcount <= '0';
	abus_waitrequest <= abus_waitrequest_read or abus_waitrequest_write;

end architecture rtl; -- of sega_saturn_abus_slave
