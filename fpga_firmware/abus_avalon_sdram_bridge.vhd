LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY abus_avalon_sdram_bridge IS
	PORT (
		clock : IN STD_LOGIC := '0'; --         clock.clk
		abus_address : IN STD_LOGIC_VECTOR(24 DOWNTO 0) := (OTHERS => '0'); --          abus.address
		abus_data : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0'); --          abus.data
		abus_chipselect : IN STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0'); --              .chipselect
		abus_read : IN STD_LOGIC := '0'; --              .read
		abus_write : IN STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0'); --              .write
		abus_interrupt : OUT STD_LOGIC := '1'; --              .interrupt
		abus_direction : OUT STD_LOGIC := '0'; --              .direction
		abus_interrupt_disable_out : OUT STD_LOGIC := '0'; --             .disableout

		sdram_addr : OUT STD_LOGIC_VECTOR(12 DOWNTO 0); -- external_sdram_controller_wire.addr
		sdram_ba : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); --                               .ba
		sdram_cas_n : OUT STD_LOGIC; --                               .cas_n
		sdram_cke : OUT STD_LOGIC; --                               .cke
		sdram_cs_n : OUT STD_LOGIC; --                               .cs_n
		sdram_dq : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0'); --                               .dq
		sdram_dqm : OUT STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '1'); --                               .dqm
		sdram_ras_n : OUT STD_LOGIC; --                               .ras_n
		sdram_we_n : OUT STD_LOGIC; --                               .we_n
		sdram_clk : OUT STD_LOGIC;

		avalon_sdram_read : IN STD_LOGIC := '0'; -- avalon_master.read
		avalon_sdram_write : IN STD_LOGIC := '0'; --              .write
		avalon_sdram_waitrequest : OUT STD_LOGIC := '0'; --              .waitrequest
		avalon_sdram_address : IN STD_LOGIC_VECTOR(25 DOWNTO 0) := (OTHERS => '0'); --              .address
		avalon_sdram_writedata : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0'); --              .writedata
		avalon_sdram_readdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0'); --              .readdata
		avalon_sdram_readdatavalid : OUT STD_LOGIC := '0'; --              .readdatavalid
		avalon_sdram_byteenable : IN STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0'); --              .readdata

		avalon_regs_read : IN STD_LOGIC := '0'; -- avalon_master.read
		avalon_regs_write : IN STD_LOGIC := '0'; --              .write
		avalon_regs_waitrequest : OUT STD_LOGIC := '0'; --              .waitrequest
		avalon_regs_address : IN STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0'); --              .address
		avalon_regs_writedata : IN STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0'); --              .writedata
		avalon_regs_readdata : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0'); --              .readdata
		avalon_regs_readdatavalid : OUT STD_LOGIC := '0'; --              .readdatavalid

		saturn_reset : IN STD_LOGIC := '0'; --         	  .saturn_reset
		reset : IN STD_LOGIC := '0' --         reset.reset
	);
END ENTITY abus_avalon_sdram_bridge;

ARCHITECTURE rtl OF abus_avalon_sdram_bridge IS

	--component sniff_fifo
	--	PORT
	--	(
	--		clock		: IN STD_LOGIC ;
	--		data		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
	--		rdreq		: IN STD_LOGIC ;
	--		wrreq		: IN STD_LOGIC ;
	--		empty		: OUT STD_LOGIC ;
	--		full		: OUT STD_LOGIC ;
	--		q		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
	--		usedw		: OUT STD_LOGIC_VECTOR (10 DOWNTO 0)
	--	);
	--end component;
	--xilinx mode
	COMPONENT sniff_fifo
		PORT (
			clk : IN STD_LOGIC;
			srst : IN STD_LOGIC;
			din : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
			wr_en : IN STD_LOGIC;
			rd_en : IN STD_LOGIC;
			dout : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
			full : OUT STD_LOGIC;
			empty : OUT STD_LOGIC;
			data_count : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
		);
	END COMPONENT;

	SIGNAL abus_address_ms : STD_LOGIC_VECTOR(24 DOWNTO 0) := (OTHERS => '0'); --          abus.address
	SIGNAL abus_address_buf : STD_LOGIC_VECTOR(24 DOWNTO 0) := (OTHERS => '0'); --          abus.address
	SIGNAL abus_data_ms : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0'); --              .data
	SIGNAL abus_data_buf : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0'); --              .data
	SIGNAL abus_chipselect_ms : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0'); --              .chipselect
	SIGNAL abus_chipselect_buf : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0'); --              .chipselect
	--signal abus_read_ms            : std_logic                     := '0';             --              .read
	SIGNAL abus_read_buf : STD_LOGIC := '0'; --              .read
	SIGNAL abus_write_ms : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0'); --              .write
	SIGNAL abus_write_buf : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0'); --              .write

	SIGNAL abus_write_buf2 : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0'); --              .write
	SIGNAL abus_chipselect_buf2 : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0'); --              .chipselect

	SIGNAL abus_read_pulse : STD_LOGIC := '0'; --              .read
	SIGNAL abus_write_pulse : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0'); --              .write
	SIGNAL abus_chipselect_pulse : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0'); --              .chipselect
	SIGNAL abus_read_pulse_off : STD_LOGIC := '0'; --              .read
	SIGNAL abus_write_pulse_off : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '0'); --              .write
	SIGNAL abus_chipselect_pulse_off : STD_LOGIC_VECTOR(2 DOWNTO 0) := (OTHERS => '0'); --              .chipselect

	SIGNAL abus_anypulse : STD_LOGIC := '0';
	SIGNAL abus_anypulse2 : STD_LOGIC := '0';
	SIGNAL abus_anypulse3 : STD_LOGIC := '0';
	SIGNAL abus_anypulse_off : STD_LOGIC := '0';
	SIGNAL abus_cspulse : STD_LOGIC := '0';
	SIGNAL abus_cspulse2 : STD_LOGIC := '0';
	SIGNAL abus_cspulse3 : STD_LOGIC := '0';
	SIGNAL abus_cspulse4 : STD_LOGIC := '0';
	SIGNAL abus_cspulse5 : STD_LOGIC := '0';
	SIGNAL abus_cspulse6 : STD_LOGIC := '0';
	SIGNAL abus_cspulse7 : STD_LOGIC := '0';
	SIGNAL abus_cspulse_off : STD_LOGIC := '0';

	SIGNAL abus_address_latched_prepatch : STD_LOGIC_VECTOR(24 DOWNTO 0) := (OTHERS => '0'); --          abus.address prior to patching
	SIGNAL abus_address_latched : STD_LOGIC_VECTOR(24 DOWNTO 0) := (OTHERS => '0'); --          abus.address
	SIGNAL abus_chipselect_latched : STD_LOGIC_VECTOR(1 DOWNTO 0) := (OTHERS => '1'); --          abus.address
	SIGNAL abus_direction_internal : STD_LOGIC := '0';
	SIGNAL abus_data_out : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL abus_data_in : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');

	SIGNAL REG_PCNTR : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL REG_STATUS : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL REG_MODE : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL REG_HWVER : STD_LOGIC_VECTOR(15 DOWNTO 0) := X"0002";
	SIGNAL REG_SWVER : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL REG_MAPPER_READ : STD_LOGIC_VECTOR(63 DOWNTO 0) := (OTHERS => '1');
	SIGNAL REG_MAPPER_WRITE : STD_LOGIC_VECTOR(63 DOWNTO 0) := (OTHERS => '1');

	------------------- sdram signals ---------------
	SIGNAL sdram_abus_pending_read : STD_LOGIC := '0'; --abus read request is detected and should be parsed
	SIGNAL sdram_abus_pending_write : STD_LOGIC := '0'; --abus write request is detected and should be parsed
	SIGNAL sdram_abus_complete : STD_LOGIC := '0';
	SIGNAL sdram_wait_counter : unsigned(3 DOWNTO 0) := (OTHERS => '0');
	--refresh interval should be no bigger than 7.8us = 906 clock cycles
	--to keep things simple, perfrorm autorefresh at 512 cycles
	SIGNAL sdram_init_counter : unsigned(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sdram_autorefresh_counter : unsigned(9 DOWNTO 0) := (OTHERS => '1');
	SIGNAL sdram_datain_latched : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sdram_datain_next_latched : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');

	SIGNAL avalon_sdram_complete : STD_LOGIC := '0';
	SIGNAL avalon_sdram_reset_pending : STD_LOGIC := '0';
	SIGNAL avalon_sdram_read_pending : STD_LOGIC := '0';
	SIGNAL avalon_sdram_read_pending_f1 : STD_LOGIC := '0';
	SIGNAL avalon_sdram_write_pending : STD_LOGIC := '0';
	SIGNAL avalon_sdram_pending_address : STD_LOGIC_VECTOR(25 DOWNTO 0) := (OTHERS => '0');
	SIGNAL avalon_sdram_pending_data : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL avalon_sdram_readdata_latched : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');

	SIGNAL avalon_regs_readdatavalid_p1 : STD_LOGIC := '0';

	SIGNAL counter_filter_control : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL counter_reset : STD_LOGIC := '0';
	SIGNAL counter_count_read : STD_LOGIC := '0';
	SIGNAL counter_count_write : STD_LOGIC := '0';
	SIGNAL counter_value : unsigned(31 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sniffer_filter_control : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sniffer_data_in : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sniffer_data_in_p1 : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sniffer_data_out : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sniffer_prefifo : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sniffer_prefifo_full : STD_LOGIC := '0';
	SIGNAL sniffer_data_write : STD_LOGIC := '0';
	SIGNAL sniffer_data_ack : STD_LOGIC := '0';
	SIGNAL sniffer_fifo_content_size : STD_LOGIC_VECTOR(10 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sniffer_fifo_empty : STD_LOGIC := '0';
	SIGNAL sniffer_fifo_full : STD_LOGIC := '0';
	SIGNAL sniffer_last_active_block : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '1');
	SIGNAL sniffer_pending_set : STD_LOGIC := '0';
	SIGNAL sniffer_pending_reset : STD_LOGIC := '0';
	SIGNAL sniffer_pending_flag : STD_LOGIC := '0';
	SIGNAL sniffer_pending_block : STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	SIGNAL sniffer_pending_timeout : STD_LOGIC := '0';
	SIGNAL sniffer_pending_timeout_counter : STD_LOGIC_VECTOR(31 DOWNTO 0) := (OTHERS => '0');

	SIGNAL mapper_write_enable : STD_LOGIC := '1';
	SIGNAL mapper_read_enable : STD_LOGIC := '1';
	TYPE transaction_dir IS (DIR_NONE, DIR_WRITE, DIR_READ);
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
		SDRAM_PRECHARGE,
		SDRAM_AUTOREFRESH,
		SDRAM_ABUS_ACTIVATE_READ,
		SDRAM_ABUS_ACTIVATE_WRITE,
		SDRAM_ABUS_READ_AND_PRECHARGE,
		SDRAM_ABUS_WRITE_AND_PRECHARGE,
		SDRAM_AVALON_ACTIVATE,
		SDRAM_AVALON_READ_AND_PRECHARGE,
		SDRAM_AVALON_WRITE_AND_PRECHARGE
	);
	SIGNAL sdram_mode : sdram_mode_type := SDRAM_INIT0;
BEGIN
	abus_direction <= abus_direction_internal;

	--we won't be aserting interrupt and waitrequest. because we can. can we?
	abus_interrupt <= '1';
	abus_interrupt_disable_out <= '1'; --dasbling waitrequest & int outputs, so they're tristate

	--ignoring functioncode, timing and addressstrobe for now

	--abus transactions are async, so first we must latch incoming signals
	--to get rid of metastability
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			--1st stage
			abus_address_ms <= abus_address;
			abus_data_ms <= abus_data;
			abus_chipselect_ms <= abus_chipselect; --work only with CS1 for now
			--abus_read_ms <= abus_read;
			abus_write_ms <= abus_write;
			--2nd stage
			abus_address_buf <= abus_address_ms;
			abus_data_buf <= abus_data_ms;
			abus_chipselect_buf <= abus_chipselect_ms;
			--abus_read_buf <= abus_read_ms;
			abus_write_buf <= abus_write_ms;
		END IF;
	END PROCESS;

	--abus read/write latch
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			abus_write_buf2 <= abus_write_buf;
			abus_chipselect_buf2 <= abus_chipselect_buf;
			abus_anypulse2 <= abus_anypulse;
			abus_anypulse3 <= abus_anypulse2;
			abus_cspulse2 <= abus_cspulse;
			abus_cspulse3 <= abus_cspulse2;
			abus_cspulse4 <= abus_cspulse3;
			abus_cspulse5 <= abus_cspulse4;
			abus_cspulse6 <= abus_cspulse5;
			abus_cspulse7 <= abus_cspulse6;
		END IF;
	END PROCESS;

	--abus write/read pulse is a falling edge since read and write signals are negative polarity
	abus_write_pulse <= abus_write_buf AND NOT abus_write_ms;
	--abus_read_pulse <= abus_read_buf and not abus_read_ms;
	abus_chipselect_pulse <= abus_chipselect_buf AND NOT abus_chipselect_ms;
	abus_write_pulse_off <= abus_write_ms AND NOT abus_write_buf;
	--abus_read_pulse_off <= abus_read_ms and not abus_read_buf;
	abus_chipselect_pulse_off <= abus_chipselect_ms AND NOT abus_chipselect_buf;

	abus_anypulse <= abus_write_pulse(0) OR abus_write_pulse(1) OR abus_read_pulse OR
		abus_chipselect_pulse(0) OR abus_chipselect_pulse(1) OR abus_chipselect_pulse(2);
	abus_anypulse_off <= abus_write_pulse_off(0) OR abus_write_pulse_off(1) OR abus_read_pulse_off OR
		abus_chipselect_pulse_off(0) OR abus_chipselect_pulse_off(1) OR abus_chipselect_pulse_off(2);
	abus_cspulse <= abus_chipselect_pulse(0) OR abus_chipselect_pulse(1) OR abus_chipselect_pulse(2);
	abus_cspulse_off <= abus_chipselect_pulse_off(0) OR abus_chipselect_pulse_off(1) OR abus_chipselect_pulse_off(2);

	--whatever pulse we've got, latch address
	--it might be latched twice per transaction, but it's not a problem
	--multiplexer was switched to address after previous transaction or after boot,
	--so we have address ready to latch
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF abus_cspulse = '1' THEN
				abus_address_latched_prepatch <= abus_address;
			END IF;
		END IF;
	END PROCESS;

	--patching abus_address_latched : for RAM 1M mode A19 and A20 should be set to zero
	--trying to do this asynchronously
	abus_address_latched <= abus_address_latched_prepatch(24 DOWNTO 21) & "00" & abus_address_latched_prepatch(18 DOWNTO 0) WHEN wasca_mode = MODE_RAM_1M AND abus_address_latched_prepatch(24 DOWNTO 21) = "0010"
		ELSE abus_address_latched_prepatch;

	--mapper write enable decode
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF abus_chipselect_buf(0) = '0' THEN
				mapper_write_enable <= REG_MAPPER_WRITE(to_integer(unsigned(abus_address_latched(24 DOWNTO 20))));
			ELSIF abus_chipselect_buf(1) = '0' THEN
				mapper_write_enable <= REG_MAPPER_WRITE(32 + to_integer(unsigned(abus_address_latched(23 DOWNTO 20))));
			ELSIF abus_chipselect_buf(2) = '0' THEN
				mapper_write_enable <= REG_MAPPER_WRITE(48);
			END IF;
		END IF;
	END PROCESS;

	--mapper read enable decode
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF abus_chipselect_buf(0) = '0' THEN
				mapper_read_enable <= REG_MAPPER_READ(to_integer(unsigned(abus_address_latched(24 DOWNTO 20))));
			ELSIF abus_chipselect_buf(1) = '0' THEN
				mapper_read_enable <= REG_MAPPER_READ(32 + to_integer(unsigned(abus_address_latched(23 DOWNTO 20))));
			ELSIF abus_chipselect_buf(2) = '0' THEN
				mapper_read_enable <= REG_MAPPER_READ(48);
			END IF;
		END IF;
	END PROCESS;
	--latch transaction direction
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF abus_write_pulse(0) = '1' OR abus_write_pulse(1) = '1' THEN
				my_little_transaction_dir <= DIR_WRITE;
			ELSIF abus_read_pulse = '1' THEN
				my_little_transaction_dir <= DIR_READ;
			ELSIF abus_anypulse_off = '1' AND abus_cspulse_off = '0' THEN --ending anything but not cs
				my_little_transaction_dir <= DIR_NONE;
			END IF;
		END IF;
	END PROCESS;

	--latch chipselect number
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF abus_chipselect_pulse(0) = '1' THEN
				abus_chipselect_latched <= "00";
			ELSIF abus_chipselect_pulse(1) = '1' THEN
				abus_chipselect_latched <= "01";
			ELSIF abus_chipselect_pulse(2) = '1' THEN
				abus_chipselect_latched <= "10";
			ELSIF abus_cspulse_off = '1' THEN
				abus_chipselect_latched <= "11";
			END IF;
		END IF;
	END PROCESS;

	--if valid transaction captured, switch to corresponding multiplex mode
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF abus_chipselect_latched = "11" THEN
				--chipselect deasserted
				abus_direction_internal <= '0'; --high-z
			ELSE
				--chipselect asserted
				CASE (my_little_transaction_dir) IS
					WHEN DIR_NONE =>
						abus_direction_internal <= '0'; --high-z
					WHEN DIR_READ =>
						abus_direction_internal <= mapper_read_enable;--'1'; --active
					WHEN DIR_WRITE =>
						abus_direction_internal <= '0'; --high-z
				END CASE;
			END IF;
		END IF;
	END PROCESS;

	--abus_disable_out <= '1' when abus_chipselect_latched(1) = '1' else 
	--						  '0';

	--sync mux for abus read requests
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF abus_chipselect_latched = "00" THEN
				--CS0 access
				IF abus_address_latched(24 DOWNTO 0) = "1" & X"FF0FFE" THEN
					--wasca specific SD card control register
					abus_data_out <= X"CDCD";
				ELSIF abus_address_latched(24 DOWNTO 0) = "1" & X"FFFFF0" THEN
					--wasca prepare counter
					abus_data_out <= REG_PCNTR;
				ELSIF abus_address_latched(24 DOWNTO 0) = "1" & X"FFFFF2" THEN
					--wasca status register
					abus_data_out <= REG_STATUS;
				ELSIF abus_address_latched(24 DOWNTO 0) = "1" & X"FFFFF4" THEN
					--wasca mode register
					abus_data_out <= REG_MODE;
				ELSIF abus_address_latched(24 DOWNTO 0) = "1" & X"FFFFF6" THEN
					--wasca hwver register
					abus_data_out <= REG_HWVER;
				ELSIF abus_address_latched(24 DOWNTO 0) = "1" & X"FFFFF8" THEN
					--wasca swver register
					abus_data_out <= REG_SWVER;
				ELSIF abus_address_latched(24 DOWNTO 0) = "1" & X"FFFFFA" THEN
					--wasca signature "wa"
					abus_data_out <= X"7761";
				ELSIF abus_address_latched(24 DOWNTO 0) = "1" & X"FFFFFC" THEN
					--wasca signature "sc"
					abus_data_out <= X"7363";
				ELSIF abus_address_latched(24 DOWNTO 0) = "1" & X"FFFFFE" THEN
					--wasca signature "a "
					abus_data_out <= X"6120";
				ELSE
					--normal CS0 read access
					CASE wasca_mode IS
						WHEN MODE_INIT => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_POWER_MEMORY_05M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_POWER_MEMORY_1M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_POWER_MEMORY_2M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_POWER_MEMORY_4M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_RAM_1M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_RAM_4M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_ROM_KOF95 => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_ROM_ULTRAMAN => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_BOOT => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
					END CASE;
				END IF;
			ELSIF abus_chipselect_latched = "01" THEN
				--CS1 access
				IF (abus_address_latched(23 DOWNTO 0) = X"FFFFFE" OR abus_address_latched(23 DOWNTO 0) = X"FFFFFC") THEN
					--saturn cart id register
					CASE wasca_mode IS
						WHEN MODE_INIT => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_POWER_MEMORY_05M => abus_data_out <= X"FF21";
						WHEN MODE_POWER_MEMORY_1M => abus_data_out <= X"FF22";
						WHEN MODE_POWER_MEMORY_2M => abus_data_out <= X"FF23";
						WHEN MODE_POWER_MEMORY_4M => abus_data_out <= X"FF24";
						WHEN MODE_RAM_1M => abus_data_out <= X"FF5A";
						WHEN MODE_RAM_4M => abus_data_out <= X"FF5C";
						WHEN MODE_ROM_KOF95 => abus_data_out <= X"FFFF";
						WHEN MODE_ROM_ULTRAMAN => abus_data_out <= X"FFFF";
						WHEN MODE_BOOT => abus_data_out <= X"FFFF";
					END CASE;
				ELSE
					--normal CS1 access
					CASE wasca_mode IS
						WHEN MODE_INIT => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_POWER_MEMORY_05M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_POWER_MEMORY_1M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_POWER_MEMORY_2M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_POWER_MEMORY_4M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_RAM_1M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_RAM_4M => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_ROM_KOF95 => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_ROM_ULTRAMAN => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
						WHEN MODE_BOOT => abus_data_out <= sdram_datain_latched(7 DOWNTO 0) & sdram_datain_latched (15 DOWNTO 8);
					END CASE;
				END IF;
			ELSE
				--CS2 access
				abus_data_out <= X"EEEE";
			END IF;
		END IF;
	END PROCESS;

	--wasca mode register write
	--reset
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			--if saturn_reset='0' then wasca_mode  <= MODE_INIT;
			--els
			IF my_little_transaction_dir = DIR_WRITE AND abus_chipselect_latched = "00" AND abus_cspulse7 = '1' AND
				abus_address_latched(23 DOWNTO 0) = X"FFFFF4" THEN
				--wasca mode register
				REG_MODE <= abus_data_in;
				CASE (abus_data_in (3 DOWNTO 0)) IS
					WHEN X"1" => wasca_mode <= MODE_POWER_MEMORY_05M;
					WHEN X"2" => wasca_mode <= MODE_POWER_MEMORY_1M;
					WHEN X"3" => wasca_mode <= MODE_POWER_MEMORY_2M;
					WHEN X"4" => wasca_mode <= MODE_POWER_MEMORY_4M;
					WHEN OTHERS =>
						CASE (abus_data_in (7 DOWNTO 4)) IS
							WHEN X"1" => wasca_mode <= MODE_RAM_1M;
							WHEN X"2" => wasca_mode <= MODE_RAM_4M;
							WHEN OTHERS =>
								CASE (abus_data_in (11 DOWNTO 8)) IS
									WHEN X"1" => wasca_mode <= MODE_ROM_KOF95;
									WHEN X"2" => wasca_mode <= MODE_ROM_ULTRAMAN;
									WHEN OTHERS => NULL;-- wasca_mode  <= MODE_INIT;
								END CASE;
						END CASE;
				END CASE;

			ELSIF avalon_regs_write = '1' THEN
				CASE avalon_regs_address(7 DOWNTO 0) IS
					WHEN X"F4" =>
						REG_MODE <= avalon_regs_writedata;
						CASE (avalon_regs_writedata (3 DOWNTO 0)) IS
							WHEN X"1" => wasca_mode <= MODE_POWER_MEMORY_05M;
							WHEN X"2" => wasca_mode <= MODE_POWER_MEMORY_1M;
							WHEN X"3" => wasca_mode <= MODE_POWER_MEMORY_2M;
							WHEN X"4" => wasca_mode <= MODE_POWER_MEMORY_4M;
							WHEN OTHERS =>
								CASE (avalon_regs_writedata (7 DOWNTO 4)) IS
									WHEN X"1" => wasca_mode <= MODE_RAM_1M;
									WHEN X"2" => wasca_mode <= MODE_RAM_4M;
									WHEN OTHERS =>
										CASE (avalon_regs_writedata (11 DOWNTO 8)) IS
											WHEN X"1" => wasca_mode <= MODE_ROM_KOF95;
											WHEN X"2" => wasca_mode <= MODE_ROM_ULTRAMAN;
											WHEN OTHERS => NULL;-- wasca_mode  <= MODE_INIT;
										END CASE;
								END CASE;
						END CASE;
					WHEN OTHERS =>
						NULL;
				END CASE;
			END IF;

		END IF;
	END PROCESS;

	abus_data_in <= abus_data_buf;

	--working only if direction is 1
	abus_data <= (OTHERS => 'Z') WHEN abus_direction_internal = '0' ELSE
		abus_data_out;
	--Avalon regs read interface
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			avalon_regs_readdatavalid_p1 <= '0';
			sniffer_data_ack <= '0';
			IF avalon_regs_read = '1' THEN
				avalon_regs_readdatavalid_p1 <= '1';
				CASE avalon_regs_address(7 DOWNTO 0) IS
					WHEN X"C0" =>
						avalon_regs_readdata <= REG_MAPPER_READ(15 DOWNTO 0);
					WHEN X"C2" =>
						avalon_regs_readdata <= REG_MAPPER_READ(31 DOWNTO 16);
					WHEN X"C4" =>
						avalon_regs_readdata <= REG_MAPPER_READ(47 DOWNTO 32);
					WHEN X"C6" =>
						avalon_regs_readdata <= REG_MAPPER_READ(63 DOWNTO 48);
					WHEN X"C8" =>
						avalon_regs_readdata <= REG_MAPPER_WRITE(15 DOWNTO 0);
					WHEN X"CA" =>
						avalon_regs_readdata <= REG_MAPPER_WRITE(31 DOWNTO 16);
					WHEN X"CC" =>
						avalon_regs_readdata <= REG_MAPPER_WRITE(47 DOWNTO 32);
					WHEN X"CE" =>
						avalon_regs_readdata <= REG_MAPPER_WRITE(63 DOWNTO 48);
					WHEN X"D0" =>
						avalon_regs_readdata <= STD_LOGIC_VECTOR(counter_value(15 DOWNTO 0));
					WHEN X"D2" =>
						avalon_regs_readdata <= STD_LOGIC_VECTOR(counter_value(31 DOWNTO 16));
					WHEN X"D4" =>
						avalon_regs_readdata(15 DOWNTO 8) <= X"00";
						avalon_regs_readdata(7 DOWNTO 0) <= counter_filter_control;
						--D6 is a reset, writeonly
						--D8 to DE are reserved
					WHEN X"E0" =>
						avalon_regs_readdata <= sniffer_data_out;
						sniffer_data_ack <= '1';
						--E2 to E6 are reserved
					WHEN X"E8" =>
						avalon_regs_readdata(15 DOWNTO 8) <= X"00";
						avalon_regs_readdata(7 DOWNTO 0) <= sniffer_filter_control;
					WHEN X"EA" =>
						avalon_regs_readdata(15 DOWNTO 12) <= "0000";
						avalon_regs_readdata(11) <= sniffer_fifo_full;
						avalon_regs_readdata(10 DOWNTO 0) <= sniffer_fifo_content_size;
						--EC to EE are reserved
					WHEN X"F0" =>
						avalon_regs_readdata <= REG_PCNTR;
					WHEN X"F2" =>
						avalon_regs_readdata <= REG_STATUS;
					WHEN X"F4" =>
						avalon_regs_readdata <= REG_MODE;
					WHEN X"F6" =>
						avalon_regs_readdata <= REG_HWVER;
					WHEN X"F8" =>
						avalon_regs_readdata <= REG_SWVER;
					WHEN X"FA" =>
						avalon_regs_readdata <= X"ABCD"; --for debug, remove later
					WHEN OTHERS =>
						avalon_regs_readdata <= REG_HWVER; --to simplify mux
				END CASE;
			END IF;
		END IF;
	END PROCESS;

	avalon_regs_readdatavalid <= avalon_regs_readdatavalid_p1 WHEN rising_edge(clock);

	--Avalon regs write interface
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			counter_reset <= '0';
			IF avalon_regs_write = '1' THEN
				CASE avalon_regs_address(7 DOWNTO 0) IS
					WHEN X"C0" =>
						REG_MAPPER_READ(15 DOWNTO 0) <= avalon_regs_writedata;
					WHEN X"C2" =>
						REG_MAPPER_READ(31 DOWNTO 16) <= avalon_regs_writedata;
					WHEN X"C4" =>
						REG_MAPPER_READ(47 DOWNTO 32) <= avalon_regs_writedata;
					WHEN X"C6" =>
						REG_MAPPER_READ(63 DOWNTO 48) <= avalon_regs_writedata;
					WHEN X"C8" =>
						REG_MAPPER_WRITE(15 DOWNTO 0) <= avalon_regs_writedata;
					WHEN X"CA" =>
						REG_MAPPER_WRITE(31 DOWNTO 16) <= avalon_regs_writedata;
					WHEN X"CC" =>
						REG_MAPPER_WRITE(47 DOWNTO 32) <= avalon_regs_writedata;
					WHEN X"CE" =>
						REG_MAPPER_WRITE(63 DOWNTO 48) <= avalon_regs_writedata;
					WHEN X"D0" =>
						NULL;
					WHEN X"D2" =>
						NULL;
					WHEN X"D4" =>
						counter_filter_control <= avalon_regs_writedata(7 DOWNTO 0);
					WHEN X"D6" =>
						counter_reset <= '1';
						--D8 to DE are reserved
					WHEN X"E0" =>
						NULL;
						--E2 to E6 are reserved
					WHEN X"E8" =>
						sniffer_filter_control <= avalon_regs_writedata(7 DOWNTO 0);
					WHEN X"EA" =>
						NULL;
						--EC to EE are reserved
					WHEN X"F0" =>
						REG_PCNTR <= avalon_regs_writedata;
					WHEN X"F2" =>
						REG_STATUS <= avalon_regs_writedata;
					WHEN X"F4" =>
						NULL;
					WHEN X"F6" =>
						NULL;
					WHEN X"F8" =>
						REG_SWVER <= avalon_regs_writedata;
					WHEN OTHERS =>
						NULL;
				END CASE;
			END IF;
		END IF;
	END PROCESS;

	--Avalon regs interface is only regs, so always ready to write.
	avalon_regs_waitrequest <= '0';
	---------------------- sdram avalon interface -------------------

	--to talk to sdram interface, avalon requests are latched until sdram is ready to process them
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF avalon_sdram_reset_pending = '1' THEN
				avalon_sdram_read_pending <= '0';
				avalon_sdram_write_pending <= '0';
			ELSIF avalon_sdram_read = '1' THEN
				avalon_sdram_read_pending <= '1';
				avalon_sdram_pending_address <= avalon_sdram_address;
			ELSIF avalon_sdram_write = '1' THEN
				avalon_sdram_write_pending <= '1';
				avalon_sdram_pending_address <= avalon_sdram_address;
				avalon_sdram_pending_data <= avalon_sdram_writedata;
			END IF;
		END IF;
	END PROCESS;

	avalon_sdram_read_pending_f1 <= avalon_sdram_read_pending WHEN rising_edge(clock);

	--avalon_sdram_readdatavalid <= avalon_sdram_complete and avalon_sdram_read_pending_f1;

	avalon_sdram_readdata <= avalon_sdram_readdata_latched;

	--avalon_sdram_readdata_latched should be set by sdram interface directly
	------------------------------ SDRAM stuff ---------------------------------------

	-- abus pending flag.
	--	abus_anypulse might appear up to 3-4 times at transaction start, so we shouldn't issue ack until at least 3-4 cycles from the start
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF abus_read_pulse = '1' THEN --for abus reads, we react faster
				sdram_abus_pending_read <= '1';
			ELSIF abus_read = '1' AND abus_cspulse2 = '1' THEN
				sdram_abus_pending_write <= '1';
			ELSIF sdram_abus_complete = '1' THEN
				sdram_abus_pending_read <= '0';
				sdram_abus_pending_write <= '0';
			END IF;
		END IF;
	END PROCESS;

	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			sdram_autorefresh_counter <= sdram_autorefresh_counter + 1;
			CASE sdram_mode IS
				WHEN SDRAM_INIT0 =>
					--first stage init. cke off, dqm high,  others Z
					sdram_addr <= (OTHERS => 'Z');
					sdram_ba <= "ZZ";
					sdram_cas_n <= 'Z';
					sdram_cke <= '0';
					sdram_cs_n <= 'Z';
					sdram_dq <= (OTHERS => 'Z');
					sdram_ras_n <= 'Z';
					sdram_we_n <= 'Z';
					sdram_dqm <= "11";
					sdram_init_counter <= sdram_init_counter + 1;
					avalon_sdram_readdatavalid <= '0';
					IF sdram_init_counter(15) = '1' THEN
						-- 282 us from the start elapsed, moving to next init
						sdram_init_counter <= (OTHERS => '0');
						sdram_mode <= SDRAM_INIT1;
					END IF;

				WHEN SDRAM_INIT1 =>
					--another stage init. cke on, dqm high, set other pin
					sdram_addr <= (OTHERS => '0');
					sdram_ba <= "00";
					sdram_cas_n <= '1';
					sdram_cke <= '1';
					sdram_cs_n <= '0';
					sdram_dq <= (OTHERS => 'Z');
					sdram_ras_n <= '1';
					sdram_we_n <= '1';
					sdram_dqm <= "11";
					sdram_init_counter <= sdram_init_counter + 1;
					IF sdram_init_counter(10) = '1' THEN
						-- some smaller time elapsed, moving to next init - issue "precharge all"
						sdram_mode <= SDRAM_INIT2;
						sdram_ras_n <= '0';
						sdram_we_n <= '0';
						sdram_addr(10) <= '1';
						sdram_wait_counter <= to_unsigned(1, 4);
					END IF;

				WHEN SDRAM_INIT2 =>
					--move on with init
					sdram_ras_n <= '1';
					sdram_we_n <= '1';
					sdram_addr(10) <= '0';
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 0 THEN
						-- issue "auto refresh"
						sdram_mode <= SDRAM_INIT3;
						sdram_ras_n <= '0';
						sdram_cas_n <= '0';
						sdram_wait_counter <= to_unsigned(7, 4);
					END IF;

				WHEN SDRAM_INIT3 =>
					--move on with init
					sdram_ras_n <= '1';
					sdram_cas_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 0 THEN
						-- issue "auto refresh"
						sdram_mode <= SDRAM_INIT4;
						sdram_ras_n <= '0';
						sdram_cas_n <= '0';
						sdram_wait_counter <= to_unsigned(7, 4);
					END IF;

				WHEN SDRAM_INIT4 =>
					--move on with init
					sdram_ras_n <= '1';
					sdram_cas_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 0 THEN
						-- issue "mode register set command"
						sdram_mode <= SDRAM_INIT5;
						sdram_ras_n <= '0';
						sdram_cas_n <= '0';
						sdram_we_n <= '0';
						--sdram_addr <= "0001000110000"; --write single, no testmode, cas 3, burst seq, burst len 1
						sdram_addr <= "0001000110001"; --write single, no testmode, cas 3, burst seq, burst len 2
						sdram_wait_counter <= to_unsigned(10, 4);
					END IF;

				WHEN SDRAM_INIT5 =>
					--move on with init
					sdram_ras_n <= '1';
					sdram_cas_n <= '1';
					sdram_we_n <= '1';
					sdram_addr <= (OTHERS => '0');
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 0 THEN
						-- init done, switching to working mode
						sdram_mode <= SDRAM_IDLE;
					END IF;

				WHEN SDRAM_IDLE =>
					sdram_addr <= (OTHERS => '0');
					sdram_ba <= "00";
					sdram_cas_n <= '1';
					sdram_cke <= '1';
					sdram_cs_n <= '0';
					sdram_dq <= (OTHERS => 'Z');
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
					IF sdram_abus_pending_read = '1' AND sdram_abus_complete = '0' THEN
						sdram_mode <= SDRAM_ABUS_ACTIVATE_READ;
						sdram_datain_latched <= sdram_datain_next_latched; --if someone tries to read data too early, he gets "next" value
						--something on abus, address should be stable already (is it???), so we activate row now
						sdram_ras_n <= '0';
						sdram_addr <= abus_address_latched(23 DOWNTO 11);
						sdram_ba(0) <= abus_address_latched(24);
						sdram_ba(1) <= abus_chipselect_buf(0); --if CS0 is active, it's 0, else it's 1
						sdram_dqm <= "00"; --it's a read
						sdram_wait_counter <= to_unsigned(3, 4); -- tRCD = 21ns min ; 3 cycles @ 116mhz = 25ns
					ELSIF sdram_abus_pending_write = '1' AND sdram_abus_complete = '0' THEN
						sdram_mode <= SDRAM_ABUS_ACTIVATE_WRITE;
						--something on abus, address should be stable already (is it???), so we activate row now
						sdram_ras_n <= '0';
						sdram_addr <= abus_address_latched(23 DOWNTO 11);
						sdram_ba(0) <= abus_address_latched(24);
						sdram_ba(1) <= abus_chipselect_buf(0); --if CS0 is active, it's 0, else it's 1
						sdram_dqm(0) <= abus_write_buf(1); --it's a write
						sdram_dqm(1) <= abus_write_buf(0); --it's a write
						sdram_wait_counter <= to_unsigned(5, 4); -- for writing we use a little longer activate delay, so that the data at the a-bus will become ready
					ELSIF (avalon_sdram_read_pending = '1' OR avalon_sdram_write_pending = '1') AND avalon_sdram_complete = '0' THEN
						sdram_mode <= SDRAM_AVALON_ACTIVATE;
						--something on avalon, activating!
						sdram_ras_n <= '0';
						sdram_addr <= avalon_sdram_pending_address(23 DOWNTO 11);
						sdram_ba <= avalon_sdram_pending_address(25 DOWNTO 24);
						sdram_wait_counter <= to_unsigned(2, 4); -- tRCD = 21ns min ; 3 cycles @ 116mhz = 25ns
						IF avalon_sdram_read_pending = '1' THEN
							sdram_dqm <= "00";
						ELSE
							sdram_dqm(0) <= NOT avalon_sdram_byteenable(0);
							sdram_dqm(1) <= NOT avalon_sdram_byteenable(1);
						END IF;
					ELSIF sdram_autorefresh_counter(9) = '1' THEN --512 cycles
						sdram_mode <= SDRAM_PRECHARGE;
						--first stage of autorefresh issues "precharge all" command
						sdram_ras_n <= '0';
						sdram_we_n <= '0';
						sdram_addr(10) <= '1';
						sdram_autorefresh_counter <= (OTHERS => '0');
						sdram_wait_counter <= to_unsigned(1, 4); -- precharge all is fast
					END IF;

				WHEN SDRAM_PRECHARGE =>
					sdram_ras_n <= '1';
					sdram_we_n <= '1';
					sdram_addr(10) <= '0';
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 0 THEN
						--switching to ABUS in case of ABUS request caught us between refresh stages
						IF sdram_abus_pending_read = '1' THEN
							sdram_mode <= SDRAM_ABUS_ACTIVATE_READ;
							sdram_datain_latched <= sdram_datain_next_latched; --if someone tries to read data too early, he gets "next" value
							--something on abus, address should be stable already (is it???), so we activate row now
							sdram_ras_n <= '0';
							sdram_addr <= abus_address_latched(23 DOWNTO 11);
							sdram_ba(0) <= abus_address_latched(24);
							sdram_ba(1) <= abus_chipselect_buf(0); --if CS0 is active, it's 0, else it's 1
							sdram_wait_counter <= to_unsigned(3, 4); -- tRCD = 21ns min ; 3 cycles @ 116mhz = 25ns
							IF abus_write_buf = "11" THEN
								sdram_dqm <= "00"; --it's a read
							ELSE
								sdram_dqm(0) <= abus_write_buf(1); --it's a write
								sdram_dqm(1) <= abus_write_buf(0); --it's a write
							END IF;
						ELSE
							-- second autorefresh stage - autorefresh command 
							sdram_cas_n <= '0';
							sdram_ras_n <= '0';
							sdram_wait_counter <= to_unsigned(7, 4); --7 cut to 6 -- tRC = 63ns min ;  8 cycles @ 116mhz = 67ns
							sdram_mode <= SDRAM_AUTOREFRESH;
						END IF;
					END IF;

				WHEN SDRAM_AUTOREFRESH =>
					--here we wait for autorefresh to end and move on to idle state
					sdram_cas_n <= '1';
					sdram_ras_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 0 THEN
						sdram_mode <= SDRAM_IDLE;
					END IF;

				WHEN SDRAM_ABUS_ACTIVATE_READ =>
					--while waiting for row to be activated, we choose where to switch to - read or write
					sdram_addr <= (OTHERS => '0');
					sdram_ba <= "00";
					sdram_ras_n <= '1';
					--we keep updating dqm in activate stage, because it could change after abus pending
					sdram_dqm <= "00"; --it's a read
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 0 THEN
						sdram_mode <= SDRAM_ABUS_READ_AND_PRECHARGE;
						counter_count_read <= '1';
						sdram_cas_n <= '0';
						sdram_addr <= "001" & abus_address_latched(10 DOWNTO 1);
						sdram_ba(0) <= abus_address_latched(24);
						sdram_ba(1) <= abus_chipselect_buf(0); --if CS0 is active, it's 0, else it's 1
						sdram_wait_counter <= to_unsigned(4, 4); --5 cut to 4 -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
						-- this is an invalid transaction - either it's for CS2 or from an unmapped range
						-- but the bank is already prepared, and we need to precharge it
						-- we can issue a precharge command, but read&precharge command will have the same effect, so we use that one
					END IF;

				WHEN SDRAM_ABUS_ACTIVATE_WRITE =>
					--while waiting for row to be activated, we choose where to switch to - read or write
					sdram_addr <= (OTHERS => '0');
					sdram_ba <= "00";
					sdram_ras_n <= '1';
					--we keep updating dqm in activate stage, because it could change after abus pending
					sdram_dqm(0) <= abus_write_buf(1); --it's a write
					sdram_dqm(1) <= abus_write_buf(0); --it's a write
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 0 THEN
						sdram_mode <= SDRAM_ABUS_WRITE_AND_PRECHARGE;
						counter_count_write <= '1';
						sdram_cas_n <= '0';
						sdram_we_n <= '0';
						sdram_dq <= abus_data_in(7 DOWNTO 0) & abus_data_in(15 DOWNTO 8);
						sdram_addr <= "001" & abus_address_latched(10 DOWNTO 1);
						sdram_ba(0) <= abus_address_latched(24);
						sdram_ba(1) <= abus_chipselect_buf(0); --if CS0 is active, it's 0, else it's 1
						sdram_wait_counter <= to_unsigned(4, 4); -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
					END IF;

				WHEN SDRAM_ABUS_READ_AND_PRECHARGE =>
					--move on with reading, bus is a Z after idle
					--data should be latched at 2nd or 3rd clock (cas=2 or cas=3)
					counter_count_read <= '0';
					sdram_addr <= (OTHERS => '0');
					sdram_ba <= "00";
					sdram_cas_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 1 THEN
						sdram_datain_latched <= sdram_dq;
					END IF;
					IF sdram_wait_counter = 0 THEN
						sdram_datain_next_latched <= sdram_dq;
						sdram_mode <= SDRAM_IDLE;
						sdram_abus_complete <= '1';
						sdram_dqm <= "11";
					END IF;

				WHEN SDRAM_ABUS_WRITE_AND_PRECHARGE =>
					--move on with writing
					counter_count_write <= '0';
					sdram_addr <= (OTHERS => '0');
					sdram_ba <= "00";
					sdram_cas_n <= '1';
					sdram_we_n <= '1';
					sdram_dq <= (OTHERS => 'Z');
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 4 THEN
						--issue burst stop immediately to cancel second burst write
						sdram_we_n <= '0';
					ELSIF sdram_wait_counter = 0 THEN
						sdram_mode <= SDRAM_IDLE;
						sdram_abus_complete <= '1';
						sdram_dqm <= "11";
					END IF;

				WHEN SDRAM_AVALON_ACTIVATE =>
					--while waiting for row to be activated, we choose where to switch to - read or write
					sdram_addr <= (OTHERS => '0');
					sdram_ba <= "00";
					sdram_ras_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 0 THEN
						IF avalon_sdram_read_pending = '1' THEN
							sdram_mode <= SDRAM_AVALON_READ_AND_PRECHARGE;
							sdram_ba <= avalon_sdram_pending_address(25 DOWNTO 24);
							sdram_cas_n <= '0';
							sdram_addr <= "001" & avalon_sdram_pending_address(10 DOWNTO 1);
							sdram_wait_counter <= to_unsigned(4, 4); -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
						ELSE
							sdram_mode <= SDRAM_AVALON_WRITE_AND_PRECHARGE;
							sdram_cas_n <= '0';
							sdram_we_n <= '0';
							sdram_ba <= avalon_sdram_pending_address(25 DOWNTO 24);
							sdram_dq <= avalon_sdram_pending_data;
							sdram_addr <= "001" & avalon_sdram_pending_address(10 DOWNTO 1);
							sdram_wait_counter <= to_unsigned(4, 4); -- tRP = 21ns min ; 3 cycles @ 116mhz = 25ns
						END IF;
					END IF;

				WHEN SDRAM_AVALON_READ_AND_PRECHARGE =>
					--move on with reading, bus is a Z after idle
					--data should be latched at 2nd or 3rd clock (cas=2 or cas=3)
					sdram_addr <= (OTHERS => '0');
					sdram_ba <= "00";
					sdram_cas_n <= '1';
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 1 THEN
						avalon_sdram_readdata_latched <= sdram_dq;
						avalon_sdram_waitrequest <= '0';
					END IF;
					IF sdram_wait_counter = 0 THEN
						sdram_mode <= SDRAM_IDLE;
						avalon_sdram_complete <= '1';
						sdram_dqm <= "11";
						avalon_sdram_waitrequest <= '1';
						avalon_sdram_reset_pending <= '1';
						avalon_sdram_readdatavalid <= '1';--'0';			
					END IF;

				WHEN SDRAM_AVALON_WRITE_AND_PRECHARGE =>
					--move on with writing
					sdram_addr <= (OTHERS => '0');
					sdram_ba <= "00";
					sdram_cas_n <= '1';
					sdram_we_n <= '1';
					sdram_dq <= (OTHERS => 'Z');
					sdram_wait_counter <= sdram_wait_counter - 1;
					IF sdram_wait_counter = 1 THEN
						avalon_sdram_reset_pending <= '1';
						avalon_sdram_waitrequest <= '0';
					END IF;
					IF sdram_wait_counter = 0 THEN
						sdram_mode <= SDRAM_IDLE;
						avalon_sdram_complete <= '1';
						sdram_dqm <= "11";
						avalon_sdram_waitrequest <= '1';
						avalon_sdram_reset_pending <= '0';
					END IF;

			END CASE;
		END IF;
	END PROCESS;

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

	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF counter_reset = '1' THEN
				counter_value <= (OTHERS => '0');
			ELSIF counter_count_write = '1' AND counter_filter_control(1) = '1' THEN
				--write detected, checking state 
				IF abus_chipselect_buf(0) = '0' AND counter_filter_control(2) = '1' THEN
					IF abus_write_buf = "00" THEN
						counter_value <= counter_value + 2;
					ELSE
						counter_value <= counter_value + 1;
					END IF;
				ELSIF abus_chipselect_buf(1) = '0' AND counter_filter_control(3) = '1' THEN
					IF abus_write_buf = "00" THEN
						counter_value <= counter_value + 2;
					ELSE
						counter_value <= counter_value + 1;
					END IF;
				ELSIF abus_chipselect_buf(2) = '0' AND counter_filter_control(4) = '1' THEN
					IF abus_write_buf = "00" THEN
						counter_value <= counter_value + 2;
					ELSE
						counter_value <= counter_value + 1;
					END IF;
				END IF;
			ELSIF counter_count_read = '1' AND counter_filter_control(0) = '1' THEN
				--read detected, checking state 
				IF abus_chipselect_buf(0) = '0' AND counter_filter_control(2) = '1' THEN
					counter_value <= counter_value + 2;
				ELSIF abus_chipselect_buf(1) = '0' AND counter_filter_control(3) = '1' THEN
					counter_value <= counter_value + 2;
				ELSIF abus_chipselect_buf(2) = '0' AND counter_filter_control(4) = '1' THEN
					counter_value <= counter_value + 2;
				END IF;
			END IF;
		END IF;
	END PROCESS;

	------------------------------ A-bus sniffer ---------------------------------------

	--fifo should be written in 2 cases
	-- 1) write was done to a different block
	-- 2) no write within 10 ms 

	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			sniffer_pending_set <= '0';
			IF counter_count_write = '1' AND sniffer_filter_control(1) = '1' THEN
				--write detected, checking state 
				IF abus_chipselect_buf(0) = '0' AND sniffer_filter_control(2) = '1' THEN
					sniffer_pending_set <= '1';
				ELSIF abus_chipselect_buf(1) = '0' AND sniffer_filter_control(3) = '1' THEN
					sniffer_pending_set <= '1';
				ELSIF abus_chipselect_buf(2) = '0' AND sniffer_filter_control(4) = '1' THEN
					sniffer_pending_set <= '1';
				END IF;
			ELSIF counter_count_read = '1' AND sniffer_filter_control(0) = '1' THEN
				--read detected, checking state 
				IF abus_chipselect_buf(0) = '0' AND sniffer_filter_control(2) = '1' THEN
					sniffer_pending_set <= '1';
				ELSIF abus_chipselect_buf(1) = '0' AND sniffer_filter_control(3) = '1' THEN
					sniffer_pending_set <= '1';
				ELSIF abus_chipselect_buf(2) = '0' AND sniffer_filter_control(4) = '1' THEN
					sniffer_pending_set <= '1';
				END IF;
			END IF;
		END IF;
	END PROCESS;

	--if an access passed thru filter, set the request as pending
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF sniffer_pending_set = '1' THEN
				sniffer_pending_flag <= '1';
				sniffer_pending_block <= abus_address_latched(24 DOWNTO 9);
			ELSIF sniffer_pending_reset = '1' THEN
				sniffer_pending_flag <= '0';
			END IF;
		END IF;
	END PROCESS;

	--if we have a pending request, and it's for a different block, fill prefifo
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			sniffer_pending_reset <= '0';
			IF sniffer_pending_flag = '1' AND sniffer_pending_block /= sniffer_last_active_block THEN
				sniffer_last_active_block <= sniffer_pending_block;
				sniffer_prefifo <= sniffer_pending_block;
				sniffer_pending_reset <= '1';
			END IF;
		END IF;
	END PROCESS;

	--if we have a pending request, and it's for a different block, and prefifo is full, flush prefifo
	--if we don't have eny requests, but the timeout fired, flush prefifo as well
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			sniffer_data_write <= '0';
			IF sniffer_pending_flag = '1' AND sniffer_pending_block /= sniffer_last_active_block THEN
				sniffer_prefifo_full <= '1';
				IF sniffer_prefifo_full = '1' THEN
					sniffer_data_in <= sniffer_prefifo;
					sniffer_data_write <= '1';
				END IF;
			ELSIF sniffer_pending_timeout = '1' THEN
				sniffer_data_write <= '1';
				sniffer_data_in <= sniffer_prefifo;
				sniffer_prefifo_full <= '0';
			END IF;
		END IF;
	END PROCESS;

	--timeout counter. resets when another pending is set
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			IF sniffer_pending_set = '1' THEN
				sniffer_pending_timeout_counter <= (OTHERS => '0');
			ELSIF sniffer_pending_timeout_counter < STD_LOGIC_VECTOR(to_unsigned(134217728, 32)) THEN
				sniffer_pending_timeout_counter <= STD_LOGIC_VECTOR(unsigned(sniffer_pending_timeout_counter) + 1);
			END IF;
		END IF;
	END PROCESS;

	--timeout comparator @ 10ms = 1160000
	PROCESS (clock)
	BEGIN
		IF rising_edge(clock) THEN
			sniffer_pending_timeout <= '0';
			IF sniffer_pending_timeout_counter = STD_LOGIC_VECTOR(to_unsigned(1160000, 32)) THEN
				sniffer_pending_timeout <= '1';
			END IF;
		END IF;
	END PROCESS;

	--sniffer_data_in_p1(15 downto 0) <= sniffer_last_active_block when rising_edge(clock);
	--sniffer_data_in <= sniffer_data_in_p1 when rising_edge(clock);
	--sniffer_data_write <= sniffer_data_write_p1 when rising_edge(clock);
	--sniffer_data_out_p1 <= sniffer_data_out when rising_edge(clock);

	--	sniff_fifo_inst : sniff_fifo PORT MAP (
	--		clock	 => clock,
	--		data	 => sniffer_data_in,
	--		rdreq	 => sniffer_data_ack,
	--		wrreq	 => sniffer_data_write,
	--		empty	 => sniffer_fifo_empty,
	--		full	 => sniffer_fifo_full,
	--		q	 => sniffer_data_out,
	--		usedw	 => sniffer_fifo_content_size
	--	);
	--	--xilinx mode
	sniff_fifo_inst : sniff_fifo PORT MAP(
		clk => clock,
		srst => '0',
		din => sniffer_data_in,
		rd_en => sniffer_data_ack,
		wr_en => sniffer_data_write,
		empty => sniffer_fifo_empty,
		full => sniffer_fifo_full,
		dout => sniffer_data_out,
		data_count => sniffer_fifo_content_size
	);

END ARCHITECTURE rtl; -- of sega_saturn_abus_slave
