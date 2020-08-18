library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity abus_avalon_sdram_bridge is
	port (
		clock                : in    std_logic                     := '0';             --         clock.clk
		abus_address         : in    std_logic_vector(9 downto 0) := (others => '0'); --          abus.address
		abus_addressdata     : inout std_logic_vector(15 downto 0) := (others => '0'); --          abus.addressdata
		abus_chipselect      : in    std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
		abus_read            : in    std_logic                     := '0';             --              .read
		abus_write           : in    std_logic_vector(1 downto 0)  := (others => '0'); --              .write
		abus_waitrequest     : out   std_logic							  := '1';                                        --              .waitrequest
		abus_interrupt       : out   std_logic                     := '0';             --              .interrupt
		abus_direction       : out   std_logic                     := '0';             --              .direction
		abus_muxing	         : out   std_logic_vector(1 downto 0)  := "01";            --             .muxing
		abus_disable_out  	: out   std_logic                     := '0';              --             .disableout

		sdram_addr         : out   std_logic_vector(12 downto 0);                    -- external_sdram_controller_wire.addr
		sdram_ba           : out   std_logic_vector(1 downto 0);                                        --                               .ba
		sdram_cas_n        : out   std_logic;                                        --                               .cas_n
		sdram_cke          : out   std_logic;                                        --                               .cke
		sdram_cs_n         : out   std_logic;                                        --                               .cs_n
		sdram_dq           : inout std_logic_vector(15 downto 0) := (others => '0'); --                               .dq
		sdram_dqm          : out   std_logic_vector(1 downto 0) :=  (others => '1');                     --                               .dqm
		sdram_ras_n        : out   std_logic;                                        --                               .ras_n
		sdram_we_n         : out   std_logic;                                        --                               .we_n
		sdram_clk          : out   std_logic;

		avalon_sdram_read          : in   std_logic := '0';                                        -- avalon_master.read
		avalon_sdram_write         : in   std_logic := '0';                                        --              .write
		avalon_sdram_waitrequest   : out    std_logic                     := '0';             --              .waitrequest
		avalon_sdram_address       : in   std_logic_vector(24 downto 0) := (others => '0');                    --              .address
		avalon_sdram_writedata     : in   std_logic_vector(15 downto 0) := (others => '0');                    --              .writedata
		avalon_sdram_readdata      : out    std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
		avalon_sdram_readdatavalid : out    std_logic                     := '0';             --              .readdatavalid

		avalon_regs_read          : in   std_logic := '0';                                        -- avalon_master.read
		avalon_regs_write         : in   std_logic := '0';                                        --              .write
		avalon_regs_waitrequest   : out    std_logic                     := '0';             --              .waitrequest
		avalon_regs_address       : in   std_logic_vector(7 downto 0) := (others => '0');                    --              .address
		avalon_regs_writedata     : in   std_logic_vector(15 downto 0) := (others => '0');                    --              .writedata
		avalon_regs_readdata      : out    std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
		avalon_regs_readdatavalid : out    std_logic                     := '0';             --              .readdatavalid

		saturn_reset         : in    std_logic                     := '0';             --         	  .saturn_reset
		reset                : in    std_logic                     := '0'              --         reset.reset
	);
end entity abus_avalon_sdram_bridge;

architecture rtl of abus_avalon_sdram_bridge is

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

--signal sdram_read          : std_logic;
--signal sdram_write         : std_logic;
--		avalon_waitrequest   : in    std_logic                     := '0';             --              .waitrequest
--		avalon_address       : out   std_logic_vector(27 downto 0);                    --              .address
--		avalon_readdata      : in    std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
--		avalon_writedata     : out   std_logic_vector(15 downto 0);                    --              .writedata
--		avalon_readdatavalid : in    std_logic    

------------------- sdram signals ---------------
signal sdram_abus_pending      : std_logic := '0'; --abus request is detected and should be parsed
signal sdram_abus_complete          : std_logic := '0'; 
signal sdram_wait_counter          : unsigned(3 downto 0) := (others => '0'); 
--refresh interval should be no bigger than 7.8us = 906 clock cycles
--to keep things simple, perfrorm autorefresh at 512 cycles
signal sdram_autorefresh_counter : unsigned(9 downto 0) := (others => '0'); 
signal sdram_datain_latched          : std_logic_vector(15 downto 0) := (others => '0'); 

signal avalon_sdram_complete      : std_logic := '0';
signal avalon_sdram_read_pending      : std_logic := '0';
signal avalon_sdram_write_pending      : std_logic := '0';
signal avalon_sdram_pending_address          : std_logic_vector(24 downto 0) := (others => '0'); 
signal avalon_sdram_pending_data          : std_logic_vector(15 downto 0) := (others => '0'); 
signal avalon_sdram_readdata_latched          : std_logic_vector(15 downto 0) := (others => '0'); 


TYPE transaction_dir IS (DIR_NONE,DIR_WRITE,DIR_READ);
SIGNAL my_little_transaction_dir : transaction_dir := DIR_NONE;

TYPE wasca_mode_type IS (MODE_INIT,
						  MODE_POWER_MEMORY_05M, MODE_POWER_MEMORY_1M, MODE_POWER_MEMORY_2M, MODE_POWER_MEMORY_4M,
						  MODE_RAM_1M, MODE_RAM_4M,
						  MODE_ROM_KOF95,
						  MODE_ROM_ULTRAMAN,
						  MODE_BOOT);
SIGNAL wasca_mode : wasca_mode_type := MODE_INIT;

TYPE sdram_mode_type IS (
						  SDRAM_INIT,
						  SDRAM_IDLE,
						  SDRAM_AUTOREFRESH,
						  SDRAM_ABUS_ACTIVATE,
						  SDRAM_ABUS_READ_AND_PRECHARGE,
						  --SDRAM_ABUS_READ_AND_PRECHARGE_WAIT,
						  SDRAM_ABUS_WRITE_AND_PRECHARGE,
						  --SDRAM_ABUS_WRITE_AND_PRECHARGE_WAIT,
						  SDRAM_AVALON_ACTIVATE,
						  SDRAM_AVALON_READ_AND_PRECHARGE,
						  SDRAM_AVALON_READ_AND_PRECHARGE_WAIT,
						  SDRAM_AVALON_WRITE_AND_PRECHARGE,
						  SDRAM_AVALON_WRITE_AND_PRECHARGE_WAIT
						);
SIGNAL sdram_mode : sdram_mode_type := SDRAM_INIT;
 

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
			--2nd stage
			abus_address_buf <= abus_address_ms;
			abus_addressdata_buf <= abus_addressdata_ms;
			abus_chipselect_buf <= abus_chipselect_ms;
			abus_read_buf <= abus_read_ms;
			abus_write_buf <= abus_write_ms;
		end if;
	end process;
	
	--excluding metastability protection is a bad behavior
	--but it looks like we're out of more options to optimize read pipeline
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
				abus_address_latched <= abus_address & abus_addressdata_buf(11) & abus_addressdata_buf(12) & abus_addressdata_buf(9) & abus_addressdata_buf(10)
																 & abus_addressdata_buf(2) & abus_addressdata_buf(1) & abus_addressdata_buf(3) & abus_addressdata_buf(8)
																 & abus_addressdata_buf(13) & abus_addressdata_buf(14) & abus_addressdata_buf(15) & abus_addressdata_buf(4)
																 & abus_addressdata_buf(5) & abus_addressdata_buf(6) & abus_addressdata_buf(0) & abus_addressdata_buf(7);
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
	
	--sync mux for abus read requests
	process (clock)
	begin
		if rising_edge(clock) then
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
						when MODE_INIT => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_POWER_MEMORY_05M => abus_data_out <= X"FFFF";
						when MODE_POWER_MEMORY_1M => abus_data_out <= X"FFFF";
						when MODE_POWER_MEMORY_2M => abus_data_out <= X"FFFF";
						when MODE_POWER_MEMORY_4M => abus_data_out <= X"FFFF";
						when MODE_RAM_1M => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_RAM_4M => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_ROM_KOF95 => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_ROM_ULTRAMAN => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_BOOT => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
					end case;	
				end if;
			elsif abus_chipselect_latched = "01" then
				--CS1 access
				if ( abus_address_latched(23 downto 0) = X"FFFFFE" or  abus_address_latched(23 downto 0) = X"FFFFFC" ) then
					--saturn cart id register
					case wasca_mode is
						when MODE_INIT => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
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
						when MODE_INIT => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_POWER_MEMORY_05M => abus_data_out <=  sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_POWER_MEMORY_1M => abus_data_out <=  sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_POWER_MEMORY_2M => abus_data_out <=  sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_POWER_MEMORY_4M => abus_data_out <=  sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
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
	end process;

	--if abus write access is detected, disable abus wait immediately
	process (clock)
	begin
		if rising_edge(clock) then
			if my_little_transaction_dir = DIR_WRITE and abus_chipselect_latched /= "11" and abus_cspulse7 = '1'  then
				abus_waitrequest_write <= '1';
			else
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

	
	abus_waitrequest <= not (abus_waitrequest_read or abus_waitrequest_write);
	
	--Avalon regs read interface
	process (clock)
	begin
		if rising_edge(clock) then
			avalon_regs_readdatavalid <= '0';
			if avalon_regs_read = '1' then
				avalon_regs_readdatavalid <= '1';
				case avalon_regs_address is 
					when X"F0" => 
						avalon_regs_readdata <= REG_PCNTR;
					when X"F2" =>
						avalon_regs_readdata <= REG_STATUS;
					when X"F4" =>
						avalon_regs_readdata <= REG_MODE;
					when X"F6" =>
						avalon_regs_readdata <= REG_HWVER;
					when X"F8" =>
						avalon_regs_readdata <= REG_SWVER;
					when X"FA" =>
						avalon_regs_readdata <= X"ABCD"; --for debug, remove later
					when others =>
						avalon_regs_readdata <= REG_HWVER; --to simplify mux
				end case;
			end if;
		end if;
	end process;
	
	--Avalon regs write interface
	process (clock)
	begin
		if rising_edge(clock) then
			if avalon_regs_write= '1' then
				case avalon_regs_address is 
					when X"F0" => 
						REG_PCNTR <= avalon_regs_writedata;
					when X"F2" =>
						REG_STATUS <= avalon_regs_writedata;
					when X"F4" =>
						null;
					when X"F6" =>
						null;
					when X"F8" =>
						REG_SWVER <= avalon_regs_writedata;
					when others =>
						null;
				end case;
			end if;
		end if;
	end process;

	--Avalon regs interface is only regs, so always ready to write.
	avalon_regs_waitrequest <= '0';	

	
	---------------------- sdram avalon interface -------------------
	
	--waitrequest should be issued as long as we received some command from avalon
	--keep it until the command is processed
	process (clock)
	begin
		if rising_edge(clock) then
			if avalon_sdram_read = '1' then
				avalon_sdram_waitrequest <= '1';
			elsif avalon_sdram_complete = '1' then
				avalon_sdram_waitrequest <= '0';
			end if;
		end if;
	end process;	
	
	--to talk to sdram interface, avalon requests are latched until sdram is ready to process them
	process (clock)
	begin
		if rising_edge(clock) then
			if avalon_sdram_read = '1' then
				avalon_sdram_read_pending <= '1';
				avalon_sdram_pending_address <= avalon_sdram_address;
			elsif avalon_sdram_complete = '1' then
				avalon_sdram_read_pending <= '0';
			end if;
		end if;
	end process;

	process (clock)
	begin
		if rising_edge(clock) then
			if avalon_sdram_write = '1' then
				avalon_sdram_write_pending <= '1';
				avalon_sdram_pending_address <= avalon_sdram_address;
				avalon_sdram_pending_data<= avalon_sdram_writedata;
			elsif avalon_sdram_complete = '1' then
				avalon_sdram_write_pending <= '0';
			end if;
		end if;
	end process;
	
	avalon_sdram_readdatavalid <= avalon_sdram_complete and avalon_sdram_read_pending;
	
	avalon_sdram_readdata <= avalon_sdram_readdata_latched;
	
	--avalon_sdram_readdata_latched should be set by sdram interface directly
	

	------------------------------ SDRAM stuff ---------------------------------------
	
	-- abus pending flag.
	--	abus_anypulse might appear up to 3-4 times at transaction start, so we shouldn't issue ack until at least 3-4 cycles from the start
	process (clock)
	begin
		if rising_edge(clock) then
			if abus_anypulse = '1' then
				sdram_abus_pending <= '1';
			elsif sdram_abus_complete = '1' then
				sdram_abus_pending <= '0';
			end if;
		end if;
	end process;

	process (clock)
	begin
		if rising_edge(clock) then
			sdram_autorefresh_counter <= sdram_autorefresh_counter + 1;
			case sdram_mode is 
				when SDRAM_INIT => 
					--will do some magic later
					sdram_mode <= SDRAM_IDLE;

				when SDRAM_IDLE => 
					sdram_addr <= (others => '0');
					sdram_ba <= "00";
					sdram_cas_n <= '1';
					sdram_cke <= '1';
					sdram_cs_n <= '0';
					sdram_dq <= (others => 'Z');
					sdram_ras_n <= '1';
					sdram_we_n <= '1';
					sdram_dqm <= "11";
					sdram_autorefresh_counter <= sdram_autorefresh_counter + 1;
					sdram_abus_complete <= '0';
					-- in idle mode we should check if any of the events occured:
					-- 1) abus transaction detected - priority 0
					-- 2) avalon transaction detected - priority 1
					-- 3) autorefresh counter exceeded threshold - priority 2
					-- if none of these events occur, we keep staying in the idle mode
					if sdram_abus_pending = '1' and sdram_abus_complete = '0' then
						sdram_mode <= SDRAM_ABUS_ACTIVATE;
						--something on abus, address should be stable already (is it???), so we activate row now
                        sdram_ras_n <= '0';
                        sdram_addr <= abus_address_latched(22 downto 10);
                        sdram_ba <= abus_address_latched(24 downto 23);
                        sdram_wait_counter <= to_unsigned(2,4); -- tRCD = 21ns min ; 3 cycles @ 116mhz = 25ns
                    elsif avalon_sdram_read_pending = '1' or avalon_sdram_write_pending = '1' then
						sdram_mode <= SDRAM_AVALON_ACTIVATE;
						--something on avalon, activating!
                        sdram_ras_n <= '0';
                        sdram_addr <= avalon_sdram_pending_address(22 downto 10);
                        sdram_ba <= avalon_sdram_pending_address(24 downto 23);
                        sdram_wait_counter <= to_unsigned(2,4); -- tRCD = 21ns min ; 3 cycles @ 116mhz = 25ns
					elsif sdram_autorefresh_counter(9) = '1' then --512 cycles
						sdram_mode <= SDRAM_AUTOREFRESH;
					    -- for autorefresh we issue corresponding command and reset autorefresh counter 
						sdram_cas_n <= '0';
					    sdram_ras_n <= '0';
					    sdram_autorefresh_counter <= (others => '0');
					    sdram_wait_counter <= to_unsigned(7,4); -- tRC = 63ns min ;  8 cycles @ 116mhz = 67ns
					end if;
				
				when SDRAM_AUTOREFRESH => 
					--here we wait for autorefresh to end and move on to idle state
					sdram_cas_n <= '1';
					sdram_ras_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 0 then
						sdram_mode <= SDRAM_IDLE;
					end if;
				
				when SDRAM_ABUS_ACTIVATE => 
					--while waiting for row to be activated, we choose where to switch to - read or write
					sdram_addr <= (others => '0');
					sdram_ba <= "00";
					sdram_ras_n <= '1';
					sdram_dqm <= abus_write_buf;
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 0 then
						if my_little_transaction_dir = DIR_WRITE then
							sdram_mode <= SDRAM_ABUS_WRITE_AND_PRECHARGE;
							sdram_cas_n <= '0';
                            sdram_we_n <= '0';
                            sdram_dq <= abus_data_in;
                            sdram_addr <= "0010"&abus_address_latched(9 downto 1);
                            sdram_ba <= abus_address_latched(24 downto 23);
                            sdram_wait_counter <= to_unsigned(2,4); -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
						else --if my_little_transaction_dir = DIR_READ then
							sdram_mode <= SDRAM_ABUS_READ_AND_PRECHARGE;
							sdram_cas_n <= '0';
							sdram_addr <= "0010"&abus_address_latched(9 downto 1);
							sdram_ba <= abus_address_latched(24 downto 23);
							sdram_wait_counter <= to_unsigned(2,4); -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
						--else 
							-- this is an invalid transaction - either it's for CS2 or from an unmapped range
							-- but the bank is already prepared, and we need to precharge it
							-- we can issue a precharge command, but read&precharge command will have the same effect, so we use that one
						end if;
					end if;					
					
				when SDRAM_ABUS_READ_AND_PRECHARGE => 
					--move on with reading, bus is a Z after idle
					--data should be latched at 2nd or 3rd clock (cas=2 or cas=3)
					sdram_addr <= (others => '0');
					sdram_ba <= "00";
					sdram_cas_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 1 then
						sdram_datain_latched <= sdram_dq;
					end if;	
					if sdram_wait_counter = 0 then
						sdram_mode <= SDRAM_IDLE;
						sdram_abus_complete <= '1';
						sdram_dqm <= "11";
					end if;	
					
				when SDRAM_ABUS_WRITE_AND_PRECHARGE => 
					--move on with writing
					sdram_addr <= (others => '0');
					sdram_ba <= "00";
					sdram_cas_n <= '1';
					sdram_we_n <= '1';
					sdram_dq <= (others => 'Z');
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 0 then
						sdram_mode <= SDRAM_IDLE;
						sdram_abus_complete <= '1';
						sdram_dqm <= "11";
					end if;
					
				when SDRAM_AVALON_ACTIVATE => 
					--while waiting for row to be activated, we choose where to switch to - read or write
					sdram_ras_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 0 then
						if avalon_sdram_read_pending = '1' then
							sdram_mode <= SDRAM_AVALON_READ_AND_PRECHARGE;
						else
							sdram_mode <= SDRAM_AVALON_WRITE_AND_PRECHARGE;
						end if;
					end if;	
					
				when SDRAM_AVALON_READ_AND_PRECHARGE => 
					--move on with reading, bus is a Z after idle
 					sdram_cas_n <= '0';
					sdram_addr <= "0010"&avalon_sdram_pending_address(9 downto 1);
					sdram_wait_counter <= to_unsigned(2,4); -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
					sdram_mode <= SDRAM_AVALON_READ_AND_PRECHARGE_WAIT;
					
				when SDRAM_AVALON_READ_AND_PRECHARGE_WAIT => 
					--data should be latched at 2nd or 3rd clock (cas=2 or cas=3)
					sdram_cas_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 1 then
						avalon_sdram_readdata_latched <= sdram_dq;
					end if;	
					if sdram_wait_counter = 0 then
						sdram_mode <= SDRAM_IDLE;
					end if;	
					
				when SDRAM_AVALON_WRITE_AND_PRECHARGE => 
					--move on with writing
 					sdram_cas_n <= '0';
					sdram_we_n <= '0';
					sdram_dq <= avalon_sdram_pending_data;
					sdram_dqm <= "11"; --only 16 bit writing for avalon?
					sdram_addr <= "0010"&avalon_sdram_pending_address(9 downto 1);
					sdram_wait_counter <= to_unsigned(2,4); -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
					sdram_mode <= SDRAM_AVALON_WRITE_AND_PRECHARGE_WAIT;
					
				when SDRAM_AVALON_WRITE_AND_PRECHARGE_WAIT => 
					sdram_cas_n <= '1';
					sdram_we_n <= '1';
					sdram_dq <= (others => 'Z');
					sdram_dqm <= "11";
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 0 then
						sdram_mode <= SDRAM_IDLE;
					end if;
					
			end case;
		end if;
	end process;
	
	sdram_clk <= clock;
	
end architecture rtl; -- of sega_saturn_abus_slave
