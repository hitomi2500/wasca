-- sega_saturn_abus_slave.vhd

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sega_saturn_abus_slave is
	port (
		clock                : in    std_logic                     := '0';             --         clock.clk
		abus_address         : in    std_logic_vector(9 downto 0) := (others => '0'); --          abus.address
		abus_addressdata     : inout std_logic_vector(15 downto 0) := (others => '0'); --          abus.addressdata
		abus_chipselect      : in    std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
		abus_read            : in    std_logic                     := '0';             --              .read
		abus_write           : in    std_logic_vector(1 downto 0)  := (others => '0'); --              .write
		--abus_functioncode    : in    std_logic_vector(1 downto 0)  := (others => '0'); --              .functioncode
		--abus_timing          : in    std_logic_vector(2 downto 0)  := (others => '0'); --              .timing
		abus_waitrequest     : out   std_logic							  := '1';                                        --              .waitrequest
		--abus_addressstrobe   : in    std_logic                     := '0';             --              .addressstrobe
		abus_interrupt       : out   std_logic                     := '0';             --              .interrupt
		abus_direction       : out   std_logic                     := '0';             --              .direction
		abus_muxing	         : out   std_logic_vector(1 downto 0)  := "01";            --             .muxing
		abus_disable_out  	: out   std_logic                     := '0';              --             .disableout
		avalon_read          : out   std_logic;                                        -- avalon_master.read
		avalon_write         : out   std_logic;                                        --              .write
		avalon_waitrequest   : in    std_logic                     := '0';             --              .waitrequest
		avalon_address       : out   std_logic_vector(27 downto 0);                    --              .address
		avalon_readdata      : in    std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
		avalon_writedata     : out   std_logic_vector(15 downto 0);                    --              .writedata
		avalon_burstcount    : out   std_logic;                                        --              .burstcount
		avalon_readdatavalid : in    std_logic                     := '0';             --              .readdatavalid
		avalon_nios_read          : in   std_logic := '0';                                        -- avalon_master.read
		avalon_nios_write         : in   std_logic := '0';                                        --              .write
		avalon_nios_waitrequest   : out    std_logic                     := '0';             --              .waitrequest
		avalon_nios_address       : in   std_logic_vector(7 downto 0) := (others => '0');                    --              .address
		avalon_nios_writedata     : in   std_logic_vector(15 downto 0) := (others => '0');                    --              .writedata
		avalon_nios_burstcount    : in   std_logic;                                        --              .burstcount
		avalon_nios_readdata      : out    std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
		avalon_nios_readdatavalid : out    std_logic                     := '0';             --              .readdatavalid
		saturn_reset         : in    std_logic                     := '0';             --         	  .saturn_reset
		reset                : in    std_logic                     := '0'              --         reset.reset
	);
end entity sega_saturn_abus_slave;

architecture rtl of sega_saturn_abus_slave is

signal abus_address_ms         : std_logic_vector(9 downto 0) := (others => '0'); --          abus.address
signal abus_address_buf         : std_logic_vector(9 downto 0) := (others => '0'); --          abus.address
signal abus_addressdata_ms       : std_logic_vector(15 downto 0) := (others => '0'); --              .data
signal abus_addressdata_buf       : std_logic_vector(15 downto 0) := (others => '0'); --              .data
signal abus_chipselect_ms      : std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
signal abus_chipselect_buf      : std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
signal abus_read_ms            : std_logic                     := '0';             --              .read
signal abus_read_buf            : std_logic                     := '0';             --              .read
signal abus_write_ms           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write
signal abus_write_buf           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write
--signal abus_functioncode_ms    : std_logic_vector(1 downto 0)  := (others => '0'); --              .functioncode
--signal abus_functioncode_buf    : std_logic_vector(1 downto 0)  := (others => '0'); --              .functioncode
--signal abus_timing_ms          : std_logic_vector(2 downto 0)  := (others => '0'); --              .timing
--signal abus_timing_buf          : std_logic_vector(2 downto 0)  := (others => '0'); --              .timing
--signal abus_addressstrobe_ms   : std_logic                     := '0';             --              .addressstrobe
--signal abus_addressstrobe_buf   : std_logic                     := '0';             --              .addressstrobe

signal abus_read_buf2            : std_logic                     := '0';             --              .read
signal abus_read_buf3            : std_logic                     := '0';             --              .read
signal abus_read_buf4            : std_logic                     := '0';             --              .read
signal abus_read_buf5            : std_logic                     := '0';             --              .read
signal abus_read_buf6            : std_logic                     := '0';             --              .read
signal abus_read_buf7            : std_logic                     := '0';             --              .read
signal abus_write_buf2           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write
signal abus_chipselect_buf2          : std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect

signal abus_read_pulse           : std_logic                     := '0';             --              .read
signal abus_write_pulse           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write
signal abus_chipselect_pulse          : std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
signal abus_read_pulse_off           : std_logic                     := '0';             --              .read
signal abus_write_pulse_off           : std_logic_vector(1 downto 0)  := (others => '0'); --              .write
signal abus_chipselect_pulse_off          : std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect

signal abus_anypulse            : std_logic                     := '0'; 
signal abus_anypulse2           : std_logic                     := '0'; 
signal abus_anypulse3           : std_logic                     := '0'; 
signal abus_anypulse_off            : std_logic                     := '0'; 
signal abus_cspulse            : std_logic                     := '0'; 
signal abus_cspulse2            : std_logic                     := '0'; 
signal abus_cspulse3            : std_logic                     := '0'; 
signal abus_cspulse4            : std_logic                     := '0'; 
signal abus_cspulse5            : std_logic                     := '0'; 
signal abus_cspulse6            : std_logic                     := '0'; 
signal abus_cspulse7            : std_logic                     := '0'; 
signal abus_cspulse_off            : std_logic                     := '0'; 

signal abus_address_latched         : std_logic_vector(25 downto 0) := (others => '0'); --          abus.address
signal abus_chipselect_latched         : std_logic_vector(1 downto 0) := (others => '1'); --          abus.address
signal abus_direction_internal            : std_logic                     := '0'; 
signal abus_muxing_internal         : std_logic_vector(1 downto 0) := (others => '0'); --          abus.address
signal abus_data_out         : std_logic_vector(15 downto 0) := (others => '0');
signal abus_data_in         : std_logic_vector(15 downto 0) := (others => '0');
signal abus_waitrequest_read            : std_logic                     := '0'; 
signal abus_waitrequest_write            : std_logic                     := '0'; 
signal abus_waitrequest_read2            : std_logic                     := '0'; 
signal abus_waitrequest_write2            : std_logic                     := '0'; 
--signal abus_waitrequest_read3            : std_logic                     := '0'; 
--signal abus_waitrequest_write3            : std_logic                     := '0'; 
--signal abus_waitrequest_read4            : std_logic                     := '0'; 
--signal abus_waitrequest_write4            : std_logic                     := '0'; 
signal abus_waitrequest_read_off            : std_logic                     := '0'; 
signal abus_waitrequest_write_off            : std_logic                     := '0'; 

signal REG_PCNTR            : std_logic_vector(15 downto 0) := (others => '0');  
signal REG_STATUS            : std_logic_vector(15 downto 0) := (others => '0'); 
signal REG_MODE            : std_logic_vector(15 downto 0) := (others => '0'); 
signal REG_HWVER            : std_logic_vector(15 downto 0) := X"0002";
signal REG_SWVER            : std_logic_vector(15 downto 0) := (others => '0'); 


TYPE transaction_dir IS (DIR_NONE,DIR_WRITE,DIR_READ);
SIGNAL my_little_transaction_dir : transaction_dir := DIR_NONE;

TYPE wasca_mode_type IS (MODE_INIT,
						  MODE_POWER_MEMORY_05M, MODE_POWER_MEMORY_1M, MODE_POWER_MEMORY_2M, MODE_POWER_MEMORY_4M,
						  MODE_RAM_1M, MODE_RAM_4M,
						  MODE_ROM_KOF95,
						  MODE_ROM_ULTRAMAN,
						  MODE_BOOT);
SIGNAL wasca_mode : wasca_mode_type := MODE_INIT;
 

begin
	abus_direction <= abus_direction_internal;
	abus_muxing <= not abus_muxing_internal;
	
	--ignoring functioncode, timing and addressstrobe for now
	
	--abus transactions are async, so first we must latch incoming signals
	--to get rid of metastability
	process (clock)
	begin
		if rising_edge(clock) then
			--1st stage
			abus_address_ms <= abus_address;
			abus_addressdata_ms <= abus_addressdata;
			abus_chipselect_ms <= abus_chipselect; --work only with CS1 for now
			abus_read_ms <= abus_read;
			abus_write_ms <= abus_write;
			--abus_functioncode_ms <= abus_functioncode;
			--abus_timing_ms <= abus_timing;
			--abus_addressstrobe_ms <= abus_addressstrobe;
			--2nd stage
			abus_address_buf <= abus_address_ms;
			abus_addressdata_buf <= abus_addressdata_ms;
			abus_chipselect_buf <= abus_chipselect_ms;
			abus_read_buf <= abus_read_ms;
			abus_write_buf <= abus_write_ms;
			--abus_functioncode_buf <= abus_functioncode_ms;
			--abus_timing_buf <= abus_timing_ms;
			--abus_addressstrobe_buf <= abus_addressstrobe_ms;
		end if;
	end process;
	
	--excluding metastability protection is a bad behavior
	--but it lloks like we're out of more options to optimize read pipeline
	--abus_read_ms <= abus_read;
	--abus_read_buf <= abus_read_ms;		
	
	--abus read/write latch
	process (clock)
	begin
		if rising_edge(clock) then
			abus_write_buf2 <= abus_write_buf;
			abus_read_buf2 <= abus_read_buf;
			abus_read_buf3 <= abus_read_buf2;
			abus_read_buf4 <= abus_read_buf3;
			abus_read_buf5 <= abus_read_buf4;
			abus_read_buf6 <= abus_read_buf5;
			abus_read_buf7 <= abus_read_buf6;
			abus_chipselect_buf2 <= abus_chipselect_buf;
			abus_anypulse2 <= abus_anypulse;
			abus_anypulse3 <= abus_anypulse2;
			abus_cspulse2 <= abus_cspulse;
			abus_cspulse3 <= abus_cspulse2;
			abus_cspulse4 <= abus_cspulse3;
			abus_cspulse5 <= abus_cspulse4;
			abus_cspulse6 <= abus_cspulse5;
			abus_cspulse7 <= abus_cspulse6;
		end if;
	end process;
	
	--abus write/read pulse is a falling edge since read and write signals are negative polarity
	abus_write_pulse <= abus_write_buf2 and not abus_write_buf;
	abus_read_pulse <= abus_read_buf2 and not abus_read_buf;
	--abus_chipselect_pulse <= abus_chipselect_buf2 and not abus_chipselect_buf;
	abus_chipselect_pulse <= abus_chipselect_buf and not abus_chipselect_ms;
	abus_write_pulse_off <= abus_write_buf and not abus_write_buf2;
	abus_read_pulse_off <= abus_read_buf and not abus_read_buf2;
	abus_chipselect_pulse_off <= abus_chipselect_buf and not abus_chipselect_buf2;
	
	abus_anypulse <= abus_write_pulse(0) or abus_write_pulse(1) or abus_read_pulse or 
				abus_chipselect_pulse(0) or abus_chipselect_pulse(1) or abus_chipselect_pulse(2);
	abus_anypulse_off <= abus_write_pulse_off(0) or abus_write_pulse_off(1) or abus_read_pulse_off or 
				abus_chipselect_pulse_off(0) or abus_chipselect_pulse_off(1) or abus_chipselect_pulse_off(2);
	abus_cspulse <= abus_chipselect_pulse(0) or abus_chipselect_pulse(1) or abus_chipselect_pulse(2);
	abus_cspulse_off <= abus_chipselect_pulse_off(0) or abus_chipselect_pulse_off(1) or abus_chipselect_pulse_off(2);
				
	--whatever pulse we've got, latch address
	--it might be latched twice per transaction, but it's not a problem
	--multiplexer was switched to address after previous transaction or after boot,
	--so we have address ready to latch
	process (clock)
	begin
		if rising_edge(clock) then
			if abus_anypulse = '1' then
			--if abus_read_pulse = '1' or abus_write_pulse(0) = '1' or abus_write_pulse(1)='1' then
				abus_address_latched <= abus_address & abus_addressdata_buf(0) & abus_addressdata_buf(12) & abus_addressdata_buf(2) & abus_addressdata_buf(1)
																 & abus_addressdata_buf(9) & abus_addressdata_buf(10) & abus_addressdata_buf(8) & abus_addressdata_buf(3)
																 & abus_addressdata_buf(13) & abus_addressdata_buf(14) & abus_addressdata_buf(15) & abus_addressdata_buf(4)
																 & abus_addressdata_buf(5) & abus_addressdata_buf(6) & abus_addressdata_buf(11) & abus_addressdata_buf(7);
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
			elsif abus_anypulse_off = '1' and abus_cspulse_off = '0' then --ending anything but not cs
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
			elsif abus_cspulse_off = '1' then
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
				abus_direction_internal <= '0'; --high-z
				abus_muxing_internal <= "01"; --address
			else
				--chipselect asserted
				case (my_little_transaction_dir) is
					when DIR_NONE => 
						abus_direction_internal <= '0'; --high-z
						abus_muxing_internal <= "10"; --data
					when DIR_READ =>
						abus_direction_internal <= '1'; --active
						abus_muxing_internal <= "10"; --data
					when DIR_WRITE =>
						abus_direction_internal <= '0'; --high-z
						abus_muxing_internal <= "10"; --data
				end case;
			end if;
		end if;
	end process;
	
	abus_disable_out <= '1' when abus_chipselect_latched(1) = '1' else 
							  '0';
	
	--if abus read access is detected, issue avalon read transaction
	--wait until readdatavalid, then disable read and abus wait
	process (clock)
	begin
		if rising_edge(clock) then
			--if my_little_transaction_dir = DIR_READ and abus_chipselect_latched(1) = '0' and abus_anypulse2 = '1' then
			--starting read transaction at either RD pulse or (CS pulse while RD is on)
			--but if CS arrives less than 7 clocks after RD, then we ignore this CS
			--this will get us 2 additional clocks at read pipeline
			if abus_read_pulse = '1' or (abus_cspulse='1' and abus_read_buf = '0' and abus_read_buf7 = '0') then
				avalon_read <= '1';
				abus_waitrequest_read <= '1';
			elsif avalon_readdatavalid = '1' then
				avalon_read <= '0';
				abus_waitrequest_read <= '0';
				if abus_chipselect_latched = "00" then
					--CS0 access
					if abus_address_latched(24 downto 0) = "1"&X"FF0FFE" then
						--wasca specific SD card control register
						abus_data_out <= X"CDCD";
					elsif abus_address_latched(24 downto 0) = "1"&X"FFFFF0" then
						--wasca prepare counter
						abus_data_out <= REG_PCNTR;
					elsif abus_address_latched(24 downto 0) = "1"&X"FFFFF2" then
						--wasca status register
						abus_data_out <= REG_STATUS;
					elsif abus_address_latched(24 downto 0) = "1"&X"FFFFF4" then
						--wasca mode register
						abus_data_out <= REG_MODE;
					elsif abus_address_latched(24 downto 0) = "1"&X"FFFFF6" then
						--wasca hwver register
						abus_data_out <= REG_HWVER;
					elsif abus_address_latched(24 downto 0) = "1"&X"FFFFF8" then
						--wasca swver register
						abus_data_out <= REG_SWVER;
					elsif abus_address_latched(24 downto 0) = "1"&X"FFFFFA" then
						--wasca signature "wa"
						abus_data_out <= X"7761";
					elsif abus_address_latched(24 downto 0) = "1"&X"FFFFFC" then
						--wasca signature "sc"
						abus_data_out <= X"7363";
					elsif abus_address_latched(24 downto 0) = "1"&X"FFFFFE" then
						--wasca signature "a "
						abus_data_out <= X"6120";
					else
						--normal CS0 read access
						case wasca_mode is
							when MODE_INIT => abus_data_out <= avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
							when MODE_POWER_MEMORY_05M => abus_data_out <= X"FFFF";
							when MODE_POWER_MEMORY_1M => abus_data_out <= X"FFFF";
							when MODE_POWER_MEMORY_2M => abus_data_out <= X"FFFF";
							when MODE_POWER_MEMORY_4M => abus_data_out <= X"FFFF";
							when MODE_RAM_1M => abus_data_out <= avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
							when MODE_RAM_4M => abus_data_out <= avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
							when MODE_ROM_KOF95 => abus_data_out <= avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
							when MODE_ROM_ULTRAMAN => abus_data_out <= avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
							when MODE_BOOT => abus_data_out <= avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
						end case;	
					end if;
				elsif abus_chipselect_latched = "01" then
					--CS1 access
					if ( abus_address_latched(23 downto 0) = X"FFFFFE" or  abus_address_latched(23 downto 0) = X"FFFFFC" ) then
						--saturn cart id register
						case wasca_mode is
							when MODE_INIT => abus_data_out <= avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
							when MODE_POWER_MEMORY_05M => abus_data_out <= X"FF21";
							when MODE_POWER_MEMORY_1M => abus_data_out <= X"FF22";
							when MODE_POWER_MEMORY_2M => abus_data_out <= X"FF23";
							when MODE_POWER_MEMORY_4M => abus_data_out <= X"FF24";
							when MODE_RAM_1M => abus_data_out <= X"FF5A"; 
							when MODE_RAM_4M => abus_data_out <= X"FF5C"; 
							when MODE_ROM_KOF95 => abus_data_out <= X"FFFF";
							when MODE_ROM_ULTRAMAN => abus_data_out <= X"FFFF";
							when MODE_BOOT => abus_data_out <= X"FFFF";
						end case;
					else
						--normal CS1 access
						case wasca_mode is
							when MODE_INIT => abus_data_out <= avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
							when MODE_POWER_MEMORY_05M => abus_data_out <=  avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
							when MODE_POWER_MEMORY_1M => abus_data_out <=  avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
							when MODE_POWER_MEMORY_2M => abus_data_out <=  avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
							when MODE_POWER_MEMORY_4M => abus_data_out <=  avalon_readdata(7 downto 0) & avalon_readdata (15 downto 8) ;
							when MODE_RAM_1M => abus_data_out <= X"FFFF";
							when MODE_RAM_4M => abus_data_out <= X"FFFF";
							when MODE_ROM_KOF95 => abus_data_out <= X"FFFF";
							when MODE_ROM_ULTRAMAN => abus_data_out <= X"FFFF";
							when MODE_BOOT => abus_data_out <= X"FFFF";
						end case;					
					end if;
				else
					--CS2 access
					abus_data_out <= X"EEEE";
				end if;
			end if;
		end if;
	end process;

	--if abus write access is detected, issue avalon write transaction
	--disable abus wait immediately
	--TODO: check if avalon_writedata is already valid at this moment
	process (clock)
	begin
		if rising_edge(clock) then
			if my_little_transaction_dir = DIR_WRITE and abus_chipselect_latched /= "11" and abus_cspulse7 = '1'  then
				--pass write to avalon
				avalon_write <= '1';
				abus_waitrequest_write <= '1';
			elsif avalon_waitrequest = '0' then
				avalon_write <= '0';
				abus_waitrequest_write <= '0';
			end if;
		end if;
	end process;
	
	--wasca mode register write
	--reset
	process (clock)
	begin
		if rising_edge(clock) then
			--if saturn_reset='0' then wasca_mode  <= MODE_INIT;
			--els
			if my_little_transaction_dir = DIR_WRITE and abus_chipselect_latched = "00" and abus_cspulse7 = '1'  and
									abus_address_latched(23 downto 0) = X"FFFFF4" then
				--wasca mode register
				REG_MODE <= abus_data_in;
				case (abus_data_in (3 downto 0)) is 
					when X"1" => wasca_mode  <= MODE_POWER_MEMORY_05M;
					when X"2" => wasca_mode  <= MODE_POWER_MEMORY_1M;
					when X"3" => wasca_mode  <= MODE_POWER_MEMORY_2M;
					when X"4" => wasca_mode  <= MODE_POWER_MEMORY_4M;
					when others =>
						case (abus_data_in (7 downto 4)) is 
							when X"1" => wasca_mode  <= MODE_RAM_1M;
							when X"2" => wasca_mode  <= MODE_RAM_4M;
							when others => 
								case (abus_data_in (11 downto 8)) is 
									when X"1" => wasca_mode  <= MODE_ROM_KOF95;
									when X"2" => wasca_mode  <= MODE_ROM_ULTRAMAN;
									when others => null;-- wasca_mode  <= MODE_INIT;
								end case;
						end case;
				end case;
			end if;
		end if;
	end process;
	
	abus_data_in <= abus_addressdata_buf;
	
	--working only if direction is 1
	abus_addressdata <= (others => 'Z') when abus_direction_internal='0' else
								abus_data_out;

	process (clock)
	begin
		if rising_edge(clock) then
			abus_waitrequest_read2 <= abus_waitrequest_read;
			--abus_waitrequest_read3 <= abus_waitrequest_read2;
			--abus_waitrequest_read4 <= abus_waitrequest_read3;
			abus_waitrequest_write2 <= abus_waitrequest_write;
			--abus_waitrequest_write3 <= abus_waitrequest_write3;
			--abus_waitrequest_write4 <= abus_waitrequest_write4;
		end if;
	end process;					
						
	process (clock)
	begin
		if rising_edge(clock) then
			abus_waitrequest_read_off <= '0';
			abus_waitrequest_write_off <= '0';
			if abus_waitrequest_read = '0' and abus_waitrequest_read2 = '1' then
				abus_waitrequest_read_off <= '1';
			end if;
			if abus_waitrequest_write = '0' and abus_waitrequest_write2 = '1' then
				abus_waitrequest_write_off <= '1';
			end if;
		end if;
	end process;					

	--process (clock)
	--begin
	--	if rising_edge(clock) then
	--		--if abus_read_pulse='1' or abus_write_pulse(0)='1' or abus_write_pulse(1)='1' then
	--		--if abus_anypulse = '1' then
	--		if abus_chipselect_pulse(0) = '1' or abus_chipselect_pulse(1) = '1' then
	--			abus_waitrequest <= '0';
	--		elsif abus_waitrequest_read_off='1' or abus_waitrequest_write_off='1' then
	--			abus_waitrequest <= '1';
	--		end if;
	--	end if;
	--end process;

	
	--avalon-to-abus mapping
	--SDRAM is mapped to both CS0 and CS1
	avalon_address <= "010" & abus_address_latched(24 downto 0);
	
	avalon_writedata <= abus_data_in(7 downto 0) & abus_data_in (15 downto 8) ;
	avalon_burstcount <= '0';
	abus_waitrequest <= not (abus_waitrequest_read or abus_waitrequest_write);
	
	--Nios II read interface
	process (clock)
	begin
		if rising_edge(clock) then
			avalon_nios_readdatavalid <= '0';
			if avalon_nios_read = '1' then
				avalon_nios_readdatavalid <= '1';
				case avalon_nios_address is 
					when X"F0" => 
						avalon_nios_readdata <= REG_PCNTR;
					when X"F2" =>
						avalon_nios_readdata <= REG_STATUS;
					when X"F4" =>
						avalon_nios_readdata <= REG_MODE;
					when X"F6" =>
						avalon_nios_readdata <= REG_HWVER;
					when X"F8" =>
						avalon_nios_readdata <= REG_SWVER;
					when X"FA" =>
						avalon_nios_readdata <= X"ABCD"; --for debug, remove later
					when others =>
						avalon_nios_readdata <= REG_HWVER; --to simplify mux
				end case;
			end if;
		end if;
	end process;
	
--Nios II write interface
	process (clock)
	begin
		if rising_edge(clock) then
			if avalon_nios_write= '1' then
				case avalon_nios_address is 
					when X"F0" => 
						REG_PCNTR <= avalon_nios_writedata;
					when X"F2" =>
						REG_STATUS <= avalon_nios_writedata;
					when X"F4" =>
						null;
					when X"F6" =>
						null;
					when X"F8" =>
						REG_SWVER <= avalon_nios_writedata;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process;

--Nios system interface is only regs, so always ready to write.
avalon_nios_waitrequest <= '0';	

end architecture rtl; -- of sega_saturn_abus_slave
