	library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity abus_avalon_sdram_bridge is
	port (
		clock                : in    std_logic                     := '0';             --         clock.clk
		abus_address         : in    std_logic_vector(24 downto 0) := (others => '0'); --          abus.address
		abus_data     : inout std_logic_vector(15 downto 0) := (others => '0'); --          abus.data
		abus_chipselect      : in    std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
		abus_read            : in    std_logic                     := '0';             --              .read
		abus_write           : in    std_logic_vector(1 downto 0)  := (others => '0'); --              .write
		abus_interrupt       : out   std_logic                     := '1';             --              .interrupt
		abus_direction       : out   std_logic                     := '0';             --              .direction
		abus_interrupt_disable_out  	: out   std_logic                     := '0';              --             .disableout

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
		avalon_sdram_address       : in   std_logic_vector(25 downto 0) := (others => '0');                    --              .address
		avalon_sdram_writedata     : in   std_logic_vector(15 downto 0) := (others => '0');                    --              .writedata
		avalon_sdram_readdata      : out    std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
		avalon_sdram_readdatavalid : out    std_logic                     := '0';             --              .readdatavalid
		avalon_sdram_byteenable    : in    std_logic_vector(1 downto 0) := (others => '0'); --              .readdata

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

component sniff_fifo
	PORT
	(
		clock		: IN STD_LOGIC ;
		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		rdreq		: IN STD_LOGIC ;
		wrreq		: IN STD_LOGIC ;
		empty		: OUT STD_LOGIC ;
		full		: OUT STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		usedw		: OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
	);
end component;
--xilinx mode
--component sniff_fifo
--	PORT
--	(
--    clk : IN STD_LOGIC;
--    srst : IN STD_LOGIC;
--    din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
--    wr_en : IN STD_LOGIC;
--    rd_en : IN STD_LOGIC;
--    dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
--    full : OUT STD_LOGIC;
--    empty : OUT STD_LOGIC;
--    data_count : OUT STD_LOGIC_VECTOR(9 DOWNTO 0)
--	);
--end component;

signal abus_address_ms         : std_logic_vector(24 downto 0) := (others => '0'); --          abus.address
signal abus_address_buf         : std_logic_vector(24 downto 0) := (others => '0'); --          abus.address
signal abus_data_ms       : std_logic_vector(15 downto 0) := (others => '0'); --              .data
signal abus_data_buf       : std_logic_vector(15 downto 0) := (others => '0'); --              .data
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

signal abus_address_latched_prepatch : std_logic_vector(24 downto 0) := (others => '0'); --          abus.address prior to patching
signal abus_address_latched         : std_logic_vector(24 downto 0) := (others => '0'); --          abus.address
signal abus_chipselect_latched         : std_logic_vector(1 downto 0) := (others => '1'); --          abus.address
signal abus_direction_internal            : std_logic                     := '0'; 
signal abus_data_out         : std_logic_vector(15 downto 0) := (others => '0');
signal abus_data_in         : std_logic_vector(15 downto 0) := (others => '0');

signal REG_PCNTR            : std_logic_vector(15 downto 0) := (others => '0');  
signal REG_STATUS            : std_logic_vector(15 downto 0) := (others => '0'); 
signal REG_MODE            : std_logic_vector(15 downto 0) := (others => '0'); 
signal REG_HWVER            : std_logic_vector(15 downto 0) := X"0002";
signal REG_SWVER            : std_logic_vector(15 downto 0) := (others => '0'); 
signal REG_MAPPER_READ            : std_logic_vector(63 downto 0) := (others => '1'); 
signal REG_MAPPER_WRITE            : std_logic_vector(63 downto 0) := (others => '1'); 

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
signal sdram_init_counter : unsigned(15 downto 0) := (others => '0'); 
signal sdram_autorefresh_counter : unsigned(9 downto 0) := (others => '1'); 
signal sdram_datain_latched          : std_logic_vector(15 downto 0) := (others => '0'); 

signal avalon_sdram_complete      : std_logic := '0';
signal avalon_sdram_reset_pending      : std_logic := '0';
signal avalon_sdram_read_pending      : std_logic := '0';
signal avalon_sdram_read_pending_f1      : std_logic := '0';
signal avalon_sdram_write_pending      : std_logic := '0';
signal avalon_sdram_pending_address          : std_logic_vector(25 downto 0) := (others => '0'); 
signal avalon_sdram_pending_data          : std_logic_vector(15 downto 0) := (others => '0'); 
signal avalon_sdram_readdata_latched          : std_logic_vector(15 downto 0) := (others => '0'); 

--signal avalon_regs_address_latched          : std_logic_vector(7 downto 0) := (others => '0'); 

signal counter_filter_control      : std_logic_vector(7 downto 0) := (others => '0'); 
signal counter_reset     : std_logic := '0';
signal counter_count_read     : std_logic := '0';
signal counter_count_write    : std_logic := '0';
signal counter_value     : unsigned(31 downto 0) := (others => '0'); 
signal sniffer_filter_control      : std_logic_vector(7 downto 0) := (others => '0'); 
signal sniffer_data_in     : std_logic_vector(15 downto 0) := (others => '0'); 
signal sniffer_data_in_p1     : std_logic_vector(15 downto 0) := (others => '0'); 
signal sniffer_data_out     : std_logic_vector(15 downto 0) := (others => '0'); 
--signal sniffer_data_write_p1    : std_logic := '0';
signal sniffer_data_write    : std_logic := '0';
signal sniffer_data_ack    : std_logic := '0';
signal sniffer_fifo_content_size     : std_logic_vector(10 downto 0) := (others => '0'); 
signal sniffer_fifo_empty    : std_logic := '0';
signal sniffer_fifo_full   : std_logic := '0';
signal sniffer_last_active_block     : std_logic_vector(15 downto 0) := (others => '1'); 
signal sniffer_pending_set  : std_logic := '0'; 
signal sniffer_pending_reset  : std_logic := '0'; 
signal sniffer_pending_flag  : std_logic := '0'; 
signal sniffer_pending_block  : std_logic_vector(15 downto 0) := (others => '0'); 
signal sniffer_pending_timeout  : std_logic := '0'; 
signal sniffer_pending_timeout_counter  : std_logic_vector(31 downto 0) := (others => '0'); 

signal mapper_write_enable    : std_logic := '1';
signal mapper_read_enable    : std_logic := '1';


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
						  SDRAM_INIT0,
						  SDRAM_INIT1,
						  SDRAM_INIT2,
						  SDRAM_INIT3,
						  SDRAM_INIT4,
						  SDRAM_INIT5,
						  SDRAM_IDLE,
						  SDRAM_AUTOREFRESH,
						  SDRAM_AUTOREFRESH2,
						  SDRAM_ABUS_ACTIVATE,
						  SDRAM_ABUS_READ_AND_PRECHARGE,
						  SDRAM_ABUS_WRITE_AND_PRECHARGE,
						  SDRAM_AVALON_ACTIVATE,
						  SDRAM_AVALON_READ_AND_PRECHARGE,
						  SDRAM_AVALON_WRITE_AND_PRECHARGE
						);
SIGNAL sdram_mode : sdram_mode_type := SDRAM_INIT0;
 

begin
	abus_direction <= abus_direction_internal;
	
	--we won't be aserting interrupt and waitrequest. because we can. can we?
	abus_interrupt <= '1';
	abus_interrupt_disable_out <= '1';  --dasbling waitrequest & int outputs, so they're tristate
	
	--ignoring functioncode, timing and addressstrobe for now
	
	--abus transactions are async, so first we must latch incoming signals
	--to get rid of metastability
	process (clock)
	begin
		if rising_edge(clock) then
			--1st stage
			abus_address_ms <= abus_address;
			abus_data_ms <= abus_data;
			abus_chipselect_ms <= abus_chipselect; --work only with CS1 for now
			abus_read_ms <= abus_read;
			abus_write_ms <= abus_write;
			--2nd stage
			abus_address_buf <= abus_address_ms;
			abus_data_buf <= abus_data_ms;
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
	--abus_write_pulse <= abus_write_buf2 and not abus_write_buf;
	abus_write_pulse <= abus_write_buf and not abus_write_ms;
	--abus_read_pulse <= abus_read_buf2 and not abus_read_buf;
	abus_read_pulse <= abus_read_buf and not abus_read_ms;
	abus_chipselect_pulse <= abus_chipselect_buf and not abus_chipselect_ms;
	--abus_write_pulse_off <= abus_write_buf and not abus_write_buf2;
	abus_write_pulse_off <= abus_write_ms and not abus_write_buf;
	--abus_read_pulse_off <= abus_read_buf and not abus_read_buf2;
	abus_read_pulse_off <= abus_read_ms and not abus_read_buf;
	--abus_chipselect_pulse_off <= abus_chipselect_buf and not abus_chipselect_buf2;
	abus_chipselect_pulse_off <= abus_chipselect_ms and not abus_chipselect_buf;
	
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
			if abus_cspulse = '1' then
				abus_address_latched_prepatch <= abus_address;
			end if;
		end if;
	end process;
	
	--patching abus_address_latched : for RAM 1M mode A19 and A20 should be set to zero
	--trying to do this asynchronously
	abus_address_latched <= abus_address_latched_prepatch(24 downto 21)&"00"&abus_address_latched_prepatch(18 downto 0) when wasca_mode = MODE_RAM_1M and abus_address_latched_prepatch(24 downto 21) = "0010"
								else abus_address_latched_prepatch;
								
	--mapper write enable decode
	process (clock)
	begin
		if rising_edge(clock) then
			if abus_chipselect_buf(0) = '0' then
				mapper_write_enable <= REG_MAPPER_WRITE(to_integer(unsigned(abus_address_latched(24 downto 20))));
			elsif abus_chipselect_buf(1) = '0' then
				mapper_write_enable <= REG_MAPPER_WRITE(32+to_integer(unsigned(abus_address_latched(23 downto 20))));
			elsif abus_chipselect_buf(2) = '0' then
				mapper_write_enable <= REG_MAPPER_WRITE(48);
			end if;
		end if;
	end process;	

	--mapper read enable decode
	process (clock)
	begin
		if rising_edge(clock) then
			if abus_chipselect_buf(0) = '0' then
				mapper_read_enable <= REG_MAPPER_READ(to_integer(unsigned(abus_address_latched(24 downto 20))));
			elsif abus_chipselect_buf(1) = '0' then
				mapper_read_enable <= REG_MAPPER_READ(32+to_integer(unsigned(abus_address_latched(23 downto 20))));
			elsif abus_chipselect_buf(2) = '0' then
				mapper_read_enable <= REG_MAPPER_READ(48);
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
			else
				--chipselect asserted
				case (my_little_transaction_dir) is
					when DIR_NONE => 
						abus_direction_internal <= '0'; --high-z
					when DIR_READ =>
						abus_direction_internal <= mapper_read_enable;--'1'; --active
					when DIR_WRITE =>
						abus_direction_internal <= '0'; --high-z
				end case;
			end if;
		end if;
	end process;
	
	--abus_disable_out <= '1' when abus_chipselect_latched(1) = '1' else 
	--						  '0';
	
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
						when MODE_POWER_MEMORY_05M => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_POWER_MEMORY_1M => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_POWER_MEMORY_2M => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_POWER_MEMORY_4M => abus_data_out <= sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
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
						when MODE_RAM_1M => abus_data_out <=  sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_RAM_4M => abus_data_out <=  sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_ROM_KOF95 => abus_data_out <=  sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_ROM_ULTRAMAN => abus_data_out <=  sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
						when MODE_BOOT => abus_data_out <=  sdram_datain_latched(7 downto 0) & sdram_datain_latched (15 downto 8) ;
					end case;					
				end if;
			else
				--CS2 access
				abus_data_out <= X"EEEE";
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

			elsif avalon_regs_write= '1' then
				case avalon_regs_address(7 downto 0) is 
					when X"F4" =>
						REG_MODE <= avalon_regs_writedata;
					when others =>
						null;
				end case;
			end if;

		end if;
	end process;
	
	abus_data_in <= abus_data_buf;
	
	--working only if direction is 1
	abus_data <= (others => 'Z') when abus_direction_internal='0' else
								abus_data_out;

	
	--Avalon regs read interface
	process (clock)
	begin
		if rising_edge(clock) then
			avalon_regs_readdatavalid <= '0';
			sniffer_data_ack <= '0';
			if avalon_regs_read = '1' then
				avalon_regs_readdatavalid <= '1';
				case avalon_regs_address(7 downto 0) is 
					when X"C0" => 
						avalon_regs_readdata <= REG_MAPPER_READ(15 downto 0);					
					when X"C2" => 
						avalon_regs_readdata <= REG_MAPPER_READ(31 downto 16);					
					when X"C4" => 
						avalon_regs_readdata <= REG_MAPPER_READ(47 downto 32);					
					when X"C6" => 
						avalon_regs_readdata <= REG_MAPPER_READ(63 downto 48);					
					when X"C8" => 
						avalon_regs_readdata <= REG_MAPPER_WRITE(15 downto 0);					
					when X"CA" => 
						avalon_regs_readdata <= REG_MAPPER_WRITE(31 downto 16);					
					when X"CC" => 
						avalon_regs_readdata <= REG_MAPPER_WRITE(47 downto 32);					
					when X"CE" => 
						avalon_regs_readdata <= REG_MAPPER_WRITE(63 downto 48);					
					when X"D0" => 
						avalon_regs_readdata <= std_logic_vector(counter_value(15 downto 0));
					when X"D2" => 
						avalon_regs_readdata <= std_logic_vector(counter_value(31 downto 16));
					when X"D4" => 
						avalon_regs_readdata(15 downto 8) <= X"00";						
						avalon_regs_readdata(7 downto 0) <= counter_filter_control;						
					--D6 is a reset, writeonly
					--D8 to DE are reserved
					when X"E0" => 
						avalon_regs_readdata <= sniffer_data_out;
						sniffer_data_ack <= '1';
					--E2 to E6 are reserved
					when X"E8" => 
						avalon_regs_readdata(15 downto 8) <= X"00";						
						avalon_regs_readdata(7 downto 0) <= sniffer_filter_control;						
					when X"EA" => 
						avalon_regs_readdata(15 downto 12) <= "0000";
						avalon_regs_readdata(11) <= sniffer_fifo_full;
						avalon_regs_readdata(10 downto 0) <= sniffer_fifo_content_size;						
					--EC to EE are reserved
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
			counter_reset <= '0';
			if avalon_regs_write= '1' then
				case avalon_regs_address(7 downto 0) is 
					when X"C0" => 
						REG_MAPPER_READ(15 downto 0) <= avalon_regs_writedata;
					when X"C2" => 
						REG_MAPPER_READ(31 downto 16) <= avalon_regs_writedata;
					when X"C4" => 
						REG_MAPPER_READ(47 downto 32) <= avalon_regs_writedata;
					when X"C6" => 
						REG_MAPPER_READ(63 downto 48) <= avalon_regs_writedata;
					when X"C8" => 
						REG_MAPPER_WRITE(15 downto 0) <= avalon_regs_writedata;
					when X"CA" => 
						REG_MAPPER_WRITE(31 downto 16) <= avalon_regs_writedata;
					when X"CC" => 
						REG_MAPPER_WRITE(47 downto 32) <= avalon_regs_writedata;
					when X"CE" => 
						REG_MAPPER_WRITE(63 downto 48) <= avalon_regs_writedata;
					when X"D0" => 
						null;
					when X"D2" => 
						null;
					when X"D4" => 
						counter_filter_control <= avalon_regs_writedata(7 downto 0);
					when X"D6" => 
						counter_reset <= '1';
					--D8 to DE are reserved
					when X"E0" => 
						null;
					--E2 to E6 are reserved
					when X"E8" => 
						sniffer_filter_control <= avalon_regs_writedata(7 downto 0);
					when X"EA" => 
						null;
					--EC to EE are reserved
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
	
	--to talk to sdram interface, avalon requests are latched until sdram is ready to process them
	process (clock)
	begin
		if rising_edge(clock) then
			if avalon_sdram_reset_pending = '1' then
				avalon_sdram_read_pending <= '0';
				avalon_sdram_write_pending <= '0';
			elsif avalon_sdram_read = '1' then
				avalon_sdram_read_pending <= '1';
				avalon_sdram_pending_address <= avalon_sdram_address;
			elsif avalon_sdram_write = '1' then
				avalon_sdram_write_pending <= '1';
                avalon_sdram_pending_address <= avalon_sdram_address;
                avalon_sdram_pending_data<= avalon_sdram_writedata;		    
			end if;
		end if;
	end process;
	
	avalon_sdram_read_pending_f1 <= avalon_sdram_read_pending when rising_edge(clock);

	--avalon_sdram_readdatavalid <= avalon_sdram_complete and avalon_sdram_read_pending_f1;
	
	avalon_sdram_readdata <= avalon_sdram_readdata_latched;
	
	--avalon_sdram_readdata_latched should be set by sdram interface directly
	

	------------------------------ SDRAM stuff ---------------------------------------
	
	-- abus pending flag.
	--	abus_anypulse might appear up to 3-4 times at transaction start, so we shouldn't issue ack until at least 3-4 cycles from the start
	process (clock)
	begin
		if rising_edge(clock) then
			if abus_cspulse2 = '1' then
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
				when SDRAM_INIT0 => 
					--first stage init. cke off, dqm high,  others Z
					sdram_addr <= (others => 'Z');
                    sdram_ba <= "ZZ";
                    sdram_cas_n <= 'Z';
                    sdram_cke <= '0';
                    sdram_cs_n <= 'Z';
                    sdram_dq <= (others => 'Z');
                    sdram_ras_n <= 'Z';
                    sdram_we_n <= 'Z';
                    sdram_dqm <= "11";
                    sdram_init_counter <= sdram_init_counter + 1;
						  avalon_sdram_readdatavalid <= '0';
                    if sdram_init_counter(15) = '1' then
                        -- 282 us from the start elapsed, moving to next init
                        sdram_init_counter <= (others => '0');
                        sdram_mode <= SDRAM_INIT1;
                    end if;

				when SDRAM_INIT1 => 
					--another stage init. cke on, dqm high, set other pin
					sdram_addr <= (others => '0');
                    sdram_ba <= "00";
                    sdram_cas_n <= '1';
                    sdram_cke <= '1';
                    sdram_cs_n <= '0';
                    sdram_dq <= (others => 'Z');
                    sdram_ras_n <= '1';
                    sdram_we_n <= '1';
                    sdram_dqm <= "11";
                    sdram_init_counter <= sdram_init_counter + 1;
                    if sdram_init_counter(10) = '1' then
                        -- some smaller time elapsed, moving to next init - issue "precharge all"
                        sdram_mode <= SDRAM_INIT2;
                        sdram_ras_n <= '0';
                        sdram_we_n <= '0';
                        sdram_addr(10) <= '1';
                        sdram_wait_counter <= to_unsigned(1,4);
                    end if;
                    
				when SDRAM_INIT2 => 
                        --move on with init
                        sdram_ras_n <= '1';
                        sdram_we_n <= '1';
                        sdram_addr(10) <= '0';
                        sdram_wait_counter <= sdram_wait_counter - 1;
                        if sdram_wait_counter = 0 then
                            -- issue "auto refresh"
                            sdram_mode <= SDRAM_INIT3;
                            sdram_ras_n <= '0';
                            sdram_cas_n <= '0';
                            sdram_wait_counter <= to_unsigned(7,4);
                        end if;                                    

				when SDRAM_INIT3 => 
                        --move on with init
                        sdram_ras_n <= '1';
                        sdram_cas_n <= '1';
                        sdram_wait_counter <= sdram_wait_counter - 1;
                        if sdram_wait_counter = 0 then
                            -- issue "auto refresh"
                            sdram_mode <= SDRAM_INIT4;
                            sdram_ras_n <= '0';
                            sdram_cas_n <= '0';
                            sdram_wait_counter <= to_unsigned(7,4);
                        end if;                                    

				when SDRAM_INIT4 => 
					--move on with init
                    sdram_ras_n <= '1';
                    sdram_cas_n <= '1';
                    sdram_wait_counter <= sdram_wait_counter - 1;
                    if sdram_wait_counter = 0 then
                        -- issue "mode register set command"
                        sdram_mode <= SDRAM_INIT5;
                        sdram_ras_n <= '0';
                        sdram_cas_n <= '0';
                        sdram_we_n <= '0';
                        sdram_addr <= "0001000110000"; --write single, no testmode, cas 3, burst seq, burst len 1
                        sdram_wait_counter <= to_unsigned(10,4);
                    end if;

				when SDRAM_INIT5 => 
					--move on with init
                    sdram_ras_n <= '1';
                    sdram_cas_n <= '1';
                    sdram_we_n <= '1';
                    sdram_addr <= (others => '0');
                    sdram_wait_counter <= sdram_wait_counter - 1;
                    if sdram_wait_counter = 0 then
                        -- init done, switching to working mode
                        sdram_mode <= SDRAM_IDLE;
                    end if;

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
					sdram_abus_complete <= '0';
					avalon_sdram_complete <= '0';
					avalon_sdram_readdatavalid <= '0';
					avalon_sdram_waitrequest <= '1';
					avalon_sdram_reset_pending <= '0';
					-- in idle mode we should check if any of the events occured:
					-- 1) abus transaction detected - priority 0
					-- 2) avalon transaction detected - priority 1
					-- 3) autorefresh counter exceeded threshold - priority 2
					-- if none of these events occur, we keep staying in the idle mode
					if sdram_abus_pending = '1' and sdram_abus_complete = '0' then
						sdram_mode <= SDRAM_ABUS_ACTIVATE;
						--something on abus, address should be stable already (is it???), so we activate row now
                  sdram_ras_n <= '0';
                  sdram_addr <= abus_address_latched(23 downto 11);
                  sdram_ba(0) <= abus_address_latched(24);
                  sdram_ba(1) <= abus_chipselect_buf(0); --if CS0 is active, it's 0, else it's 1
                  if abus_write_buf = "11" then
							sdram_dqm <= "00"; --it's a read
							sdram_wait_counter <= to_unsigned(3,4); -- tRCD = 21ns min ; 3 cycles @ 116mhz = 25ns
						else
							sdram_dqm(0) <= abus_write_buf(1); --it's a write
							sdram_dqm(1) <= abus_write_buf(0); --it's a write
							sdram_wait_counter <= to_unsigned(5,4); -- for writing we use a little longer activate delay, so that the data at the a-bus will become ready
						end if;
               elsif (avalon_sdram_read_pending = '1' or avalon_sdram_write_pending = '1')  and avalon_sdram_complete = '0'  then
						sdram_mode <= SDRAM_AVALON_ACTIVATE;
						--something on avalon, activating!
                  sdram_ras_n <= '0';
                  sdram_addr <= avalon_sdram_pending_address(23 downto 11);
                  sdram_ba <= avalon_sdram_pending_address(25 downto 24);
                  sdram_wait_counter <= to_unsigned(2,4); -- tRCD = 21ns min ; 3 cycles @ 116mhz = 25ns
						if avalon_sdram_read_pending = '1' then
							sdram_dqm <= "00";
						else
							sdram_dqm(0) <= not avalon_sdram_byteenable(0);
							sdram_dqm(1) <= not avalon_sdram_byteenable(1);
						end if;
					elsif sdram_autorefresh_counter(9) = '1' then --512 cycles
						sdram_mode <= SDRAM_AUTOREFRESH;
						--first stage of autorefresh issues "precharge all" command
					    sdram_ras_n <= '0';
						sdram_we_n <= '0';
						sdram_addr(10) <= '1';
					    sdram_autorefresh_counter <= (others => '0');
					    sdram_wait_counter <= to_unsigned(1,4); -- precharge all is fast
					end if;
				
				when SDRAM_AUTOREFRESH => 
				    sdram_ras_n <= '1';
                    sdram_we_n <= '1';
                    sdram_addr(10) <= '0';					
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 0 then
						--switching to ABUS in case of ABUS request caught us between refresh stages
						if sdram_abus_pending = '1' then
							sdram_mode <= SDRAM_ABUS_ACTIVATE;
							--something on abus, address should be stable already (is it???), so we activate row now
							sdram_ras_n <= '0';
							sdram_addr <= abus_address_latched(23 downto 11);
							sdram_ba(0) <= abus_address_latched(24);
							sdram_ba(1) <= abus_chipselect_buf(0); --if CS0 is active, it's 0, else it's 1
							sdram_wait_counter <= to_unsigned(3,4); -- tRCD = 21ns min ; 3 cycles @ 116mhz = 25ns
							if abus_write_buf = "11" then
								sdram_dqm <= "00"; --it's a read
							else
								sdram_dqm(0) <= abus_write_buf(1); --it's a write
								sdram_dqm(1) <= abus_write_buf(0); --it's a write
							end if;
						else
							 -- second autorefresh stage - autorefresh command 
							sdram_cas_n <= '0';
							sdram_ras_n <= '0';
							sdram_wait_counter <= to_unsigned(7,4); --7 cut to 6 -- tRC = 63ns min ;  8 cycles @ 116mhz = 67ns
							sdram_mode <= SDRAM_AUTOREFRESH2;
						end if;
					end if;

				when SDRAM_AUTOREFRESH2 => 
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
					--we keep updating dqm in activate stage, because it could change after abus pending
					if abus_write_buf = "11" then
						sdram_dqm <= "00"; --it's a read
					else
						sdram_dqm(0) <= abus_write_buf(1); --it's a write
						sdram_dqm(1) <= abus_write_buf(0); --it's a write
					end if;
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 0 then
						if my_little_transaction_dir = DIR_WRITE and mapper_write_enable = '1' then --if mapper write is not enabled, doing read instead
							sdram_mode <= SDRAM_ABUS_WRITE_AND_PRECHARGE;
							counter_count_write <= '1';
							sdram_cas_n <= '0';
                     sdram_we_n <= '0';
                     sdram_dq <= abus_data_in(7 downto 0)&abus_data_in(15 downto 8);
                     sdram_addr <= "001"&abus_address_latched(10 downto 1);
							sdram_ba(0) <= abus_address_latched(24);
							sdram_ba(1) <= abus_chipselect_buf(0); --if CS0 is active, it's 0, else it's 1
                     sdram_wait_counter <= to_unsigned(4,4); -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
						else --if my_little_transaction_dir = DIR_READ then
							sdram_mode <= SDRAM_ABUS_READ_AND_PRECHARGE;
							counter_count_read <= '1';
							sdram_cas_n <= '0';
							sdram_addr <= "001"&abus_address_latched(10 downto 1);
							sdram_ba(0) <= abus_address_latched(24);
							sdram_ba(1) <= abus_chipselect_buf(0); --if CS0 is active, it's 0, else it's 1
                     sdram_wait_counter <= to_unsigned(4,4); --5 cut to 4 -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
						--else 
							-- this is an invalid transaction - either it's for CS2 or from an unmapped range
							-- but the bank is already prepared, and we need to precharge it
							-- we can issue a precharge command, but read&precharge command will have the same effect, so we use that one
						end if;
					end if;					
					
				when SDRAM_ABUS_READ_AND_PRECHARGE => 
					--move on with reading, bus is a Z after idle
					--data should be latched at 2nd or 3rd clock (cas=2 or cas=3)
					counter_count_read <= '0';
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
					counter_count_write <= '0';
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
					sdram_addr <= (others => '0');
                    sdram_ba <= "00";
                    sdram_ras_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 0 then
						if avalon_sdram_read_pending = '1' then
							sdram_mode <= SDRAM_AVALON_READ_AND_PRECHARGE;
							sdram_ba <= avalon_sdram_pending_address(25 downto 24);
							sdram_cas_n <= '0';
                            sdram_addr <= "001"&avalon_sdram_pending_address(10 downto 1);
                            sdram_wait_counter <= to_unsigned(4,4); -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
						else
							sdram_mode <= SDRAM_AVALON_WRITE_AND_PRECHARGE;
							sdram_cas_n <= '0';
                            sdram_we_n <= '0';
                            sdram_ba <= avalon_sdram_pending_address(25 downto 24);
                            sdram_dq <= avalon_sdram_pending_data; 
                            sdram_addr <= "001"&avalon_sdram_pending_address(10 downto 1);
                            sdram_wait_counter <= to_unsigned(4,4); -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
						end if;
					end if;	
					
				when SDRAM_AVALON_READ_AND_PRECHARGE => 
					--move on with reading, bus is a Z after idle
					--data should be latched at 2nd or 3rd clock (cas=2 or cas=3)
					sdram_addr <= (others => '0');
					sdram_ba <= "00";
					sdram_cas_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 1 then
						avalon_sdram_readdata_latched <= sdram_dq;
						avalon_sdram_waitrequest <= '0';
					end if;	
					if sdram_wait_counter = 0 then
						sdram_mode <= SDRAM_IDLE;
						avalon_sdram_complete <= '1';
						sdram_dqm <= "11";
						avalon_sdram_waitrequest <= '1';
						avalon_sdram_reset_pending <= '1';		
						avalon_sdram_readdatavalid <= '1';--'0';			
					end if;	
					
				when SDRAM_AVALON_WRITE_AND_PRECHARGE => 
					--move on with writing
					sdram_addr <= (others => '0');
					sdram_ba <= "00";
					sdram_cas_n <= '1';
					sdram_we_n <= '1';
					sdram_dq <= (others => 'Z');
					sdram_wait_counter <= sdram_wait_counter - 1;
					if sdram_wait_counter = 1 then
						avalon_sdram_reset_pending <= '1';
						avalon_sdram_waitrequest <= '0';
					end if;	
					if sdram_wait_counter = 0 then
						sdram_mode <= SDRAM_IDLE;
						avalon_sdram_complete <= '1';
						sdram_dqm <= "11";
						avalon_sdram_waitrequest <= '1';
						avalon_sdram_reset_pending <= '0';
					end if;
					
			end case;
		end if;
	end process;
	
	sdram_clk <= clock;
	
	------------------------------ A-bus transactions counter ---------------------------------------
	
	-- counter filters transactions transferred over a-bus and counts them
	-- for writes, 8-bit transactions are counted as 1 byte, 16-bit as 2 bytes
	-- for reads, every access is counted as 2 bytes
	-- filter control :
	-- bit 0 - read
	-- bit 1 - write
	-- bit 2 - CS0
	-- bit 3 - CS1
	-- bit 4 - CS2
	
	process (clock)
	begin
		if rising_edge(clock) then
			if counter_reset = '1' then
				counter_value <= (others =>'0');
			elsif counter_count_write='1' and counter_filter_control(1) = '1' then
				--write detected, checking state 
				if abus_chipselect_buf(0) = '0' and counter_filter_control(2) = '1' then
					if abus_write_buf="00" then
						counter_value <= counter_value + 2;
					else
						counter_value <= counter_value + 1;
					end if;
				elsif abus_chipselect_buf(1) = '0' and counter_filter_control(3) = '1' then
					if abus_write_buf="00" then
						counter_value <= counter_value + 2;
					else
						counter_value <= counter_value + 1;
					end if;
				elsif abus_chipselect_buf(2) = '0' and counter_filter_control(4) = '1' then
					if abus_write_buf="00" then
						counter_value <= counter_value + 2;
					else
						counter_value <= counter_value + 1;
					end if;	
				end if;
			elsif counter_count_read='1' and counter_filter_control(0) = '1' then
				--read detected, checking state 
				if abus_chipselect_buf(0) = '0' and counter_filter_control(2) = '1' then
					counter_value <= counter_value + 2;
				elsif abus_chipselect_buf(1) = '0' and counter_filter_control(3) = '1' then
					counter_value <= counter_value + 2;
				elsif abus_chipselect_buf(2) = '0' and counter_filter_control(4) = '1' then
					counter_value <= counter_value + 2;
				end if;
			end if;
		end if;
	end process;

	------------------------------ A-bus sniffer ---------------------------------------
	
	--fifo should be written in 2 cases
	-- 1) write was done to a different block
	-- 2) no write within 10 ms 
	
	process (clock)
	begin
		if rising_edge(clock) then
			sniffer_pending_set <= '0';
			if counter_count_write='1' and sniffer_filter_control(1) = '1' then
				--write detected, checking state 
				if abus_chipselect_buf(0) = '0' and sniffer_filter_control(2) = '1' then
					sniffer_pending_set <= '1';
				elsif abus_chipselect_buf(1) = '0' and sniffer_filter_control(3) = '1' then
					sniffer_pending_set <= '1';
				elsif abus_chipselect_buf(2) = '0' and sniffer_filter_control(4) = '1' then
					sniffer_pending_set <= '1';	
				end if;
			elsif counter_count_read='1' and sniffer_filter_control(0) = '1' then
				--read detected, checking state 
				if abus_chipselect_buf(0) = '0' and sniffer_filter_control(2) = '1' then
					sniffer_pending_set <= '1';
				elsif abus_chipselect_buf(1) = '0' and sniffer_filter_control(3) = '1' then
					sniffer_pending_set <= '1';
				elsif abus_chipselect_buf(2) = '0' and sniffer_filter_control(4) = '1' then
					sniffer_pending_set <= '1';
				end if;
			end if;
		end if;
	end process;
	
	--if an access passed thru filter, set the request as pending
    process (clock)
    begin
        if rising_edge(clock) then
	       if sniffer_pending_set = '1' then
	           sniffer_pending_flag <= '1';
	           sniffer_pending_block <= abus_address_latched(24 downto 9);
	       elsif sniffer_pending_reset = '1' then
	           sniffer_pending_flag <= '0';
          end if;
        end if;
    end process;

    --if we have a pending request, and it's for a different block, issue write
    --if we don't have eny requests, but the timeout fired, issue write as well
    process (clock)
    begin
        if rising_edge(clock) then
           sniffer_pending_reset <= '0';
           sniffer_data_write <= '0';
           if sniffer_pending_flag = '1' and sniffer_pending_block /= sniffer_last_active_block then
               sniffer_data_write <= '1';
               sniffer_last_active_block <= sniffer_pending_block;
               sniffer_pending_reset <= '1';
           elsif sniffer_pending_timeout = '1' then
               sniffer_data_write <= '1';
               sniffer_last_active_block <= sniffer_pending_block;
               sniffer_pending_reset <= '1';
           end if;
        end if;
    end process;   	
    
    --timeout counter. resets when another pending is set
    process (clock)
    begin
        if rising_edge(clock) then
           if sniffer_pending_set = '1' then
               sniffer_pending_timeout_counter <= (others => '0');
           elsif sniffer_pending_timeout_counter < std_logic_vector(to_unsigned(134217728,32)) then
               sniffer_pending_timeout_counter <= std_logic_vector(unsigned(sniffer_pending_timeout_counter) + 1);
           end if;
        end if;
    end process;
    
    --timeout comparator @ 10ms = 1160000
    process (clock)
    begin
        if rising_edge(clock) then
           sniffer_pending_timeout <= '0';
           if sniffer_pending_timeout_counter = std_logic_vector(to_unsigned(1160000,32)) then
                sniffer_pending_timeout <= '1';
           end if;
        end if;
    end process;    

	sniffer_data_in_p1(15 downto 0) <= sniffer_last_active_block when rising_edge(clock);
	sniffer_data_in <= sniffer_data_in_p1 when rising_edge(clock);
	--sniffer_data_write <= sniffer_data_write_p1 when rising_edge(clock);
	
	sniff_fifo_inst : sniff_fifo PORT MAP (
		clock	 => clock,
		data	 => sniffer_data_in,
		rdreq	 => sniffer_data_ack,
		wrreq	 => sniffer_data_write,
		empty	 => sniffer_fifo_empty,
		full	 => sniffer_fifo_full,
		q	 => sniffer_data_out,
		usedw	 => sniffer_fifo_content_size
	);
--	--xilinx mode
--	sniff_fifo_inst : sniff_fifo PORT MAP (
--        clk     => clock,
--        srst => '0',
--        din     => sniffer_data_in,
--        rd_en     => sniffer_data_ack,
--        wr_en     => sniffer_data_write,
--        empty     => sniffer_fifo_empty,
--        full     => sniffer_fifo_full,
--        dout     => sniffer_data_out,
--        data_count     => sniffer_fifo_content_size
--    );
	
end architecture rtl; -- of sega_saturn_abus_slave
