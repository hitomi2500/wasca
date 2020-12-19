library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity heartbeat is
	port (
		clock       : in    std_logic                     := '0';
		reset       : in    std_logic                     := '0';
		heartbeat_out  	: out   std_logic                     := '0';

		avalon_regs_read          : in   std_logic := '0';                                        -- avalon_master.read
		avalon_regs_write         : in   std_logic := '0';                                        --              .write
		avalon_regs_waitrequest   : out    std_logic                     := '0';             --              .waitrequest
		avalon_regs_address       : in   std_logic_vector(7 downto 0) := (others => '0');                    --              .address
		avalon_regs_writedata     : in   std_logic_vector(15 downto 0) := (others => '0');                    --              .writedata
		avalon_regs_readdata      : out    std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
		avalon_regs_readdatavalid : out    std_logic                     := '0'           --              .readdatavalid
	);
end entity heartbeat;

architecture rtl of heartbeat is

signal heartbeat_counter         : unsigned(31 downto 0) := (others => '0'); 
signal heartbeat_counter_logic         : std_logic_vector(31 downto 0) := (others => '0'); 

signal heartbeat_divider         : unsigned(4 downto 0) := to_unsigned(27,5); --initial division is 2^27 = 0.86Hz
signal heartbeat_divider_16         : std_logic_vector(15 downto 0) := (others => '0');  
signal heartbeat_divider_int         : integer range 31 downto 0 := 27; 

begin

	heartbeat_divider_16 <= std_logic_vector(resize(heartbeat_divider,16));
	heartbeat_divider_int <= to_integer(heartbeat_divider);
	heartbeat_counter_logic <= std_logic_vector(heartbeat_counter);
	
	--Avalon regs read interface
	process (clock)
	begin
		if rising_edge(clock) then
			avalon_regs_readdatavalid <= '0';
			if avalon_regs_read = '1' then
				avalon_regs_readdatavalid <= '1';
				case avalon_regs_address(7 downto 0) is 
					when X"00" => 
						avalon_regs_readdata <= heartbeat_divider_16;					
					when X"04" => 
						avalon_regs_readdata <= std_logic_vector(heartbeat_counter(15 downto 0));					
					when X"06" => 
						avalon_regs_readdata <= std_logic_vector(heartbeat_counter(31 downto 16));					
					when others =>
						avalon_regs_readdata <= X"0000";
				end case;
			end if;
		end if;
	end process;
	
	--Avalon regs write interface
	process (clock)
	begin
		if rising_edge(clock) then
			if avalon_regs_write= '1' then
				case avalon_regs_address(7 downto 0) is 
					when X"00" => 
						heartbeat_divider <= unsigned(avalon_regs_writedata(4 downto 0));
					when others =>
						null;
				end case;
			end if;
		end if;
	end process;

	--Avalon regs interface is only regs, so always ready to write.
	avalon_regs_waitrequest <= '0';	

	--Counter
	heartbeat_counter <= heartbeat_counter + 1 when rising_edge(clock);
	
	--Heartbeat selector
	process (clock)
	begin
		if rising_edge(clock) then
			case heartbeat_divider_int is 
				when 21 => 
					heartbeat_out <= heartbeat_counter_logic(20);	-- 54 Hz				
				when 22 => 
					heartbeat_out <= heartbeat_counter_logic(21);	-- 28 Hz 				
				when 23 => 
					heartbeat_out <= heartbeat_counter_logic(22);	-- 14 Hz				
				when 24 => 
					heartbeat_out <= heartbeat_counter_logic(23);	-- 7 Hz				
				when 25 => 
					heartbeat_out <= heartbeat_counter_logic(24);	--3.2 Hz				
				when 26 => 
					heartbeat_out <= heartbeat_counter_logic(25);	--1.6 Hz				
				when 27 => 
					heartbeat_out <= heartbeat_counter_logic(26);	--0.8 Hz				
				when 28 => 
					heartbeat_out <= heartbeat_counter_logic(27);					
				when 29 => 
					heartbeat_out <= heartbeat_counter_logic(28);					
				when 30 => 
					heartbeat_out <= heartbeat_counter_logic(29);					
				when 31 => 
					heartbeat_out <= heartbeat_counter_logic(30);									
				when others =>
					heartbeat_out <= heartbeat_counter_logic(26);	
			end case;
		end if;
	end process;	
	
end architecture rtl; 