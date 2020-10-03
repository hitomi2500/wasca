library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

entity buffered_spi is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           avalon_read : in STD_LOGIC;
           avalon_write : in STD_LOGIC;
           avalon_address : in STD_LOGIC_VECTOR (13 downto 0);
           avalon_waitrequest : out    std_logic  := '0'; 
           avalon_writedata : in STD_LOGIC_VECTOR (15 downto 0);
           avalon_readdata : out STD_LOGIC_VECTOR (15 downto 0);
           avalon_readdatavalid : out std_logic := '0';
           spi_mosi : out STD_LOGIC := '0';
           spi_clk : out STD_LOGIC := '0';
           spi_miso : in STD_LOGIC;
           spi_cs : out STD_LOGIC := '1');
end buffered_spi;

architecture Behavioral of buffered_spi is

signal transaction_active           : std_logic := '0';
signal transaction_active_p1           : std_logic := '0';
signal transaction_active_readreg           : std_logic := '0';
signal writebuffer_write1           : std_logic := '0';
signal writebuffer_write2          : std_logic := '0';
signal readbuffer_write1           : std_logic := '0';
signal readbuffer_write2           : std_logic := '0';
signal readbuffer_transaction_write1           : std_logic := '0';
signal readbuffer_transaction_write2           : std_logic := '0';

signal transaction_prestart_1           : std_logic := '0';
signal transaction_prestart_2           : std_logic := '0';
signal transaction_start           : std_logic := '0';
signal transaction_bit_counter         : unsigned (15 downto 0)  := (others => '1');
signal transaction_bit_counter_p1         : unsigned (15 downto 0)  := (others => '1');
signal transaction_byte_counter        : unsigned (11 downto 0)  := (others => '1');
signal transaction_byte_counter_p1        : unsigned (11 downto 0)  := (others => '1');
signal transaction_data_read          : std_logic_vector (15 downto 0)  := (others => '0');
signal transaction_data_write1          : std_logic_vector (15 downto 0)  := (others => '0');
signal transaction_data_write2          : std_logic_vector (15 downto 0)  := (others => '0');
signal transaction_buf_write1           : std_logic := '0';
signal transaction_buf_write2           : std_logic := '0';
signal transaction_clkdiv_counter            : std_logic_vector (3 downto 0)  := (others => '0');


signal spi_cs_constant            : std_logic := '1';
signal spi_cs_gappy            : std_logic := '1';


signal length_register         : std_logic_vector(10 downto 0)  := (others => '0');
signal cs_mode_register         : std_logic  := '0';
signal delay_register         : std_logic_vector(15 downto 0)  := (others => '0');
signal buffer_select_register         : std_logic  := '0';

signal avalon_readdata_readbuf1 : std_logic_vector (15 downto 0);
signal avalon_readdata_writebuf1 : std_logic_vector (15 downto 0);
signal avalon_readdata_readbuf2 : std_logic_vector (15 downto 0);
signal avalon_readdata_writebuf2 : std_logic_vector (15 downto 0);

--signal avalon_address_f1 : std_logic_vector (13 downto 0);
signal avalon_readdata_p1 : std_logic_vector (15 downto 0);
signal avalon_read_f1 : STD_LOGIC;
signal avalon_read_f2 : STD_LOGIC;
signal avalon_address_latched : std_logic_vector (13 downto 0);

signal avalon_readdatavalid_p1 : STD_LOGIC;


--inferred ram, quartus fails to recognize'em like bram
--type spi_buf_type is array(0 to 511) of std_logic_vector(15 downto 0);
--signal write_buffer1 : spi_buf_type;
--signal read_buffer1 : spi_buf_type;
--signal write_buffer2 : spi_buf_type;
--signal read_buffer2 : spi_buf_type;

--using core-generated bram instead
component buff_spi_ram IS
	PORT
	(
		address_a		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		address_b		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data_a		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		data_b		: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
		wren_a		: IN STD_LOGIC  := '0';
		wren_b		: IN STD_LOGIC  := '0';
		q_a		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
		q_b		: OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
	);
end component;

begin

	avalon_address_latched <= avalon_address when rising_edge(clock) and (avalon_read = '1' or avalon_write = '1');
	avalon_read_f1 <=  avalon_read when rising_edge(clock);
	avalon_read_f2 <=  avalon_read_f1 when rising_edge(clock);

	--Avalon regs read interface
	process (clock)
	begin
		if rising_edge(clock) then
			avalon_readdatavalid_p1 <= '0';
			if avalon_read_f2 = '1' then
				avalon_readdatavalid_p1 <= '1';
				case avalon_address_latched(13 downto 11) is 
					when "000" => 
						avalon_readdata_p1 <= avalon_readdata_writebuf1;
					when "001" => 
                  avalon_readdata_p1 <= avalon_readdata_writebuf2;
					when "010" => 
						avalon_readdata_p1 <= avalon_readdata_readbuf1;
					when "011" => 
						avalon_readdata_p1 <= avalon_readdata_readbuf2;
					when "100" => 
					   	case avalon_address_latched(2 downto 0) is 
                           when "000" => 
                                 avalon_readdata_p1 <= X"000"&"000"&transaction_active_readreg;
                           when "001" => 
                                 avalon_readdata_p1 <= X"0"&"0"&length_register;
                           when "010" => 
                                 avalon_readdata_p1 <= X"0"&std_logic_vector(transaction_byte_counter);
                           when "011" => 
                                 avalon_readdata_p1 <= X"000"&"000"&cs_mode_register;
                           when "100" => 
                                 avalon_readdata_p1 <= delay_register;
                           when "101" =>
                                 avalon_readdata_p1 <= X"000"&"000"&buffer_select_register;
                           when "110" =>
                                 avalon_readdata_p1 <= X"DEAF";
                           when "111" =>
                                 avalon_readdata_p1 <= X"FACE";
                           when others =>
                                 avalon_readdata_p1 <= X"ABBA";
					  	end case;
					when others => 
                        null;
			    end case;
			end if;
		end if;
	end process;
	
	avalon_readdata <= avalon_readdata_p1 when rising_edge(clock);
	avalon_readdatavalid <= avalon_readdatavalid_p1 when rising_edge(clock);
	
	--Avalon regs write interface
	process (clock)
	begin
		if rising_edge(clock) then
			transaction_prestart_1 <= '0';
			writebuffer_write1 <= '0';
			writebuffer_write2 <= '0';
			readbuffer_write1 <= '0';
			readbuffer_write2 <= '0';
			if avalon_write= '1' then
				case avalon_address(13 downto 11) is 
                when "000" => 
                    writebuffer_write1 <= '1';
                when "001" => 
                    writebuffer_write2 <= '1';
                when "010" => 
                    readbuffer_write1 <= '1';
                when "011" => 
                    readbuffer_write2 <= '1';
                when "100" => 
                       case avalon_address(2 downto 0) is 
                       when "000" => 
                             transaction_prestart_1 <= avalon_writedata(0);
                       when "001" => 
                             length_register <= avalon_writedata(10 downto 0);
                       when "010" => 
                             null;
                       when "011" => 
                             cs_mode_register <= avalon_writedata(0);
                       when "100" => 
                             delay_register <= avalon_writedata;
                       when "101" => 
                             buffer_select_register <= avalon_writedata(0);
                       when others =>
                             null; 
                       end case;
                when others =>
                    null; 
                end case;
			end if;
		end if;
	end process;
	
	--async avalon write decoders
	--writebuffer_write1 <= avalon_write when avalon_address(13 downto 11) = "000" else '0';
	--writebuffer_write2 <= avalon_write when avalon_address(13 downto 11) = "001" else '0';
	--readbuffer_write1 <= avalon_write when avalon_address(13 downto 11) = "010" else '0';
	--readbuffer_write2 <= avalon_write when avalon_address(13 downto 11) = "011" else '0';
	
	--delaying transaction_start cor a clock cycle to wait for cs
	process (clock)
    begin
       if rising_edge(clock) then
          if transaction_prestart_1 = '1' then
                transaction_prestart_2 <= '1';
          elsif transaction_clkdiv_counter = "1011" then
                transaction_prestart_2 <= '0';
          end if;
       end if;
    end process;

	process (clock)
    begin
       if rising_edge(clock) then
          if transaction_clkdiv_counter = "1011" then
                transaction_start<= transaction_prestart_2;   
          end if;
       end if;
    end process;
    
    transaction_byte_counter_p1 <= transaction_byte_counter when rising_edge(clock);

--	--read buffer1, should be inferred as 1.5-port block ram
--	process (clock)
--    begin
--       if rising_edge(clock) then
--          if (readbuffer_write1 = '1') then
--             read_buffer1(to_integer(unsigned(avalon_address(8 downto 0)))) <= avalon_writedata;
--          end if;
--          avalon_readdata_readbuf1 <= read_buffer1(to_integer(unsigned(avalon_address(8 downto 0))));
--          if (readbuffer_transaction_write1 = '1') then
--             read_buffer1(to_integer(unsigned(transaction_byte_counter_p1(8 downto 0)))) <= transaction_data_read;
--          end if;
--       end if;
--    end process;
--    --read buffer2
--	process (clock)
--    begin
--       if rising_edge(clock) then
--          if (readbuffer_write2 = '1') then
--              read_buffer2(to_integer(unsigned(avalon_address(8 downto 0)))) <= avalon_writedata;
--          end if;
--          avalon_readdata_readbuf2 <= read_buffer2(to_integer(unsigned(avalon_address(8 downto 0))));
--          if (readbuffer_transaction_write2 = '1') then
--             read_buffer2(to_integer(unsigned(transaction_byte_counter_p1(8 downto 0)))) <= transaction_data_read;
--          end if;
--       end if;
--    end process;

--    --write buffer1
--    process (clock)
--    begin
--       if rising_edge(clock) then
--          if (writebuffer_write1 = '1') then
--             write_buffer1(to_integer(unsigned(avalon_address(8 downto 0)))) <= avalon_writedata;
--          end if;
--          transaction_data_write1 <= write_buffer1(to_integer(unsigned(transaction_byte_counter(8 downto 0))));
--          avalon_readdata_writebuf1 <= write_buffer1(to_integer(unsigned(avalon_address(8 downto 0))));
--       end if;
--    end process;
--    --write buffer2
--    process (clock)
--    begin
--       if rising_edge(clock) then
--          if (writebuffer_write2 = '1') then
--             write_buffer2(to_integer(unsigned(avalon_address(8 downto 0)))) <= avalon_writedata;
--          end if;
--          transaction_data_write2 <= write_buffer2(to_integer(unsigned(transaction_byte_counter(8 downto 0))));
--          avalon_readdata_writebuf2 <= write_buffer2(to_integer(unsigned(avalon_address(8 downto 0))));
--       end if;
--    end process;

--using bram cores instead
read1_buf: buff_spi_ram 
	port map
	(
		address_a => avalon_address_latched(8 downto 0),
		address_b => std_logic_vector(transaction_byte_counter_p1(8 downto 0)),
		clock	 => clock,
		data_a => avalon_writedata,
		data_b => transaction_data_read,
		wren_a => readbuffer_write1,
		wren_b => readbuffer_transaction_write1,
		q_a    => avalon_readdata_readbuf1,
		q_b	 => open --write-only port
	);
read2_buf: buff_spi_ram 
	port map
	(
		address_a => avalon_address_latched(8 downto 0),
		address_b => std_logic_vector(transaction_byte_counter_p1(8 downto 0)),
		clock	 => clock,
		data_a => avalon_writedata,
		data_b => transaction_data_read,
		wren_a => readbuffer_write2,
		wren_b => readbuffer_transaction_write2,
		q_a    => avalon_readdata_readbuf2,
		q_b	 => open --write-only port
	);	
write1_buf: buff_spi_ram 
	port map
	(
		address_a => avalon_address_latched(8 downto 0),
		address_b => std_logic_vector(transaction_byte_counter(8 downto 0)),
		clock	 => clock,
		data_a => avalon_writedata,
		data_b => X"0000",
		wren_a => writebuffer_write1,
		wren_b => '0', --read-only port
		q_a    => avalon_readdata_writebuf1,
		q_b	 => transaction_data_write1
	);
write2_buf: buff_spi_ram 
	port map
	(
		address_a => avalon_address_latched(8 downto 0),
		address_b => std_logic_vector(transaction_byte_counter(8 downto 0)),
		clock	 => clock,
		data_a => avalon_writedata,
		data_b => X"0000",
		wren_a => writebuffer_write2,
		wren_b => '0', --read-only port
		q_a    => avalon_readdata_writebuf2,
		q_b	 => transaction_data_write2
	);


	--Avalon interface is only regs, so always ready to write.
	avalon_waitrequest <= '0';	

    --transaction bit counter
	process (clock)
    begin
       if rising_edge(clock) then
          if (transaction_start = '1') then
             transaction_bit_counter <= to_unsigned(0,16);
          elsif (transaction_clkdiv_counter = "1000") and transaction_active = '1' then
            if transaction_bit_counter < 16 + unsigned(delay_register) then
                 transaction_bit_counter <= transaction_bit_counter + 1;
            else
                 transaction_bit_counter <= to_unsigned(0,16);
            end if;          
          end if;
       end if;
    end process;
    
    --transaction byte counter
	process (clock)
    begin
       if rising_edge(clock) then
          if (transaction_start = '1') then
             transaction_byte_counter <= to_unsigned(0,12);
          elsif transaction_clkdiv_counter = "1001"  and transaction_active = '1' then
            if transaction_byte_counter <= unsigned(length_register) then
                 if transaction_bit_counter = to_unsigned(16,16) then  --16 bits per frame
                    transaction_byte_counter <= transaction_byte_counter + 1;
                 end if;
              end if;
          end if;
       end if;
    end process;
 
    --transaction active flag
	process (clock)
    begin
       if rising_edge(clock) then
          if (transaction_start = '1') then
             transaction_active <= '1';
          elsif transaction_byte_counter = unsigned(length_register) then
             transaction_active <= '0';
          end if;
       end if;
    end process;
	 
	 --transaction active flag for nios to read
	 process (clock)
    begin
       if rising_edge(clock) then
          if (transaction_prestart_1 = '1') then
             transaction_active_readreg <= '1';
          elsif transaction_byte_counter = unsigned(length_register) then
             transaction_active_readreg <= '0';
          end if;
       end if;
    end process;
    
    --transaction clock divider (test clockspeed is 1/16, 7.25 Mhz for 116Mhz base clock)
    process (clock)
    begin
       if rising_edge(clock) then
          if (transaction_prestart_1 = '1') then
              transaction_clkdiv_counter <= "1100";
          else
              transaction_clkdiv_counter <= std_logic_vector(unsigned(transaction_clkdiv_counter) + 1);  
          end if;
       end if;
    end process;
    
    -- SPI CLK output
    process (clock)
    begin
       if rising_edge(clock) then
          if (transaction_active = '1') and  transaction_bit_counter <= to_unsigned(15,16) then
              if (transaction_clkdiv_counter = "0001") and (transaction_start = '0') then
                 spi_clk <= '1';
              elsif (transaction_clkdiv_counter = "1001") then
                 spi_clk <= '0';
              end if;
          else
              spi_clk <= '0';
          end if;
       end if;
    end process;

    -- SPI MOSI output
    process (clock)
    begin
       if rising_edge(clock) then
          if (transaction_active = '0') then
              spi_mosi <= '0';
          elsif (buffer_select_register = '0') then
              spi_mosi <= transaction_data_write1(15-to_integer(transaction_bit_counter(3 downto 0)));
          else
              spi_mosi <= transaction_data_write2(15-to_integer(transaction_bit_counter(3 downto 0)));
          end if;
       end if;
    end process;
    
    -- SPI CS output
    transaction_active_p1 <= transaction_active when rising_edge(clock);
    
    process (clock)
    begin
       if rising_edge(clock) then
          if transaction_prestart_1 = '1' then
              spi_cs_gappy <= '0';
          elsif (transaction_bit_counter = to_unsigned(16,16)) then
              spi_cs_gappy <= '1';
          elsif (transaction_bit_counter = to_unsigned(0,16)) then
              spi_cs_gappy <= '0';
          elsif transaction_active = '0' and transaction_active_p1 = '1' then 
              spi_cs_gappy <= '1';
          end if;
       end if;
    end process;
    
    process (clock)
    begin
       if rising_edge(clock) then
          if transaction_prestart_1 = '1' then
              spi_cs_constant <= '0';
          elsif transaction_active = '0' and transaction_active_p1 = '1' then 
              spi_cs_constant <= '1';
          end if;
       end if;
    end process;
    
    spi_cs <= spi_cs_gappy when cs_mode_register = '1' else
             spi_cs_constant;
             
    -- SPI MISO input
    process (clock)
    begin
       if rising_edge(clock) then
          if (transaction_active = '1') and transaction_bit_counter <= to_unsigned(15,16) then
              transaction_data_read(15-to_integer(transaction_bit_counter(3 downto 0))) <= spi_miso;
          end if;
       end if;
    end process;
    
    transaction_bit_counter_p1 <= transaction_bit_counter when rising_edge(clock);
    
    process (clock)
    begin
       if rising_edge(clock) then
          readbuffer_transaction_write1 <= '0';
          readbuffer_transaction_write2 <= '0';
          if (transaction_active = '1') and transaction_bit_counter = to_unsigned(16,16) and transaction_bit_counter_p1 = to_unsigned(15,16) then
              if (buffer_select_register = '0') then
                    readbuffer_transaction_write1 <= '1';
              else
                    readbuffer_transaction_write2 <= '1';
              end if;
          end if;
       end if;
    end process;
    
    
end Behavioral;
