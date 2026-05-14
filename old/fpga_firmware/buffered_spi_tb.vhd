----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.09.2020 23:17:28
-- Design Name: 
-- Module Name: buffered_spi_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity buffered_spi_tb is
--  Port ( );
end buffered_spi_tb;

architecture Behavioral of buffered_spi_tb is

component buffered_spi is
    Port ( clock : in STD_LOGIC;
           reset : in STD_LOGIC;
           avalon_read : in STD_LOGIC;
           avalon_write : in STD_LOGIC;
           avalon_address : in STD_LOGIC_VECTOR (13 downto 0);
           avalon_waitrequest : out    std_logic  := '0'; 
           avalon_writedata : in STD_LOGIC_VECTOR (15 downto 0);
           avalon_readdata : out STD_LOGIC_VECTOR (15 downto 0);
           avalon_readdatavalid : out std_logic := '0';
           spi_mosi : out STD_LOGIC;
           spi_clk : out STD_LOGIC;
           spi_miso : in STD_LOGIC;
           spi_cs : out STD_LOGIC);
end component;

signal	clock                :     std_logic                     := '0';  
signal	reset                :     std_logic                     := '0';  
signal	avalon_read          :    std_logic := '0';  
signal	avalon_write         :    std_logic := '0'; 
signal	avalon_waitrequest         :    std_logic := '0';
signal	avalon_address       :    std_logic_vector(13 downto 0) := (others => '0');  
signal	avalon_writedata     :    std_logic_vector(15 downto 0) := (others => '0');  
signal	avalon_readdata     :    std_logic_vector(15 downto 0) := (others => '0'); 
signal	avalon_readdatavalid         :    std_logic := '0';
signal	spi_mosi         :    std_logic := '0';
signal	spi_clk         :    std_logic := '0';
signal	spi_miso         :    std_logic := '0';
signal	spi_cs         :    std_logic := '0';

	procedure write_avalon_16 (addry : in std_logic_vector(13 downto 0);
                              datty : in std_logic_vector(15 downto 0);
                              signal Ava_Ad : out std_logic_vector(13 downto 0);
                              signal Ava_Da : out std_logic_vector(15 downto 0);
                              signal Ava_Wri : out std_logic
                              ) is
        begin
                Ava_Ad <= addry;
                Ava_Da <= datty;
                wait for 10 ns;
                Ava_Wri <= '1';
                wait for 10 ns;
                Ava_Wri <= '0';
                wait for 10 ns;
        end write_avalon_16;


	procedure read_avalon_16 (addry : in std_logic_vector(13 downto 0);
                              signal Ava_Ad : out std_logic_vector(13 downto 0);
                              signal Ava_Re : out std_logic
                              ) is
        begin
                Ava_Ad <= addry;
                wait for 10 ns;
                Ava_Re <= '1';
                wait for 10 ns;
                Ava_Re <= '0';
                wait for 10 ns;
        end read_avalon_16;

begin

--clock <= not clock after 4310 ps; --116 MHz clock
clock <= not clock after 5000 ps; --100 MHz clock

UUT: buffered_spi 
	port map(
		clock => clock,
		reset => reset,
		avalon_read => avalon_read,
		avalon_write => avalon_write,
		avalon_address => avalon_address,
		avalon_waitrequest => avalon_waitrequest,
		avalon_writedata => avalon_writedata,
		avalon_readdata => avalon_readdata,
		avalon_readdatavalid => avalon_readdatavalid,
		spi_mosi => spi_mosi,
		spi_clk => spi_clk,
		spi_miso => spi_miso,
		spi_cs => spi_cs
	);
	
process
    begin
		  reset <= '1';
        wait for 100 ns;
		  reset <= '0';
        wait for 300 ns;
		  reset <= '1';
        wait for 300 ns;
        --write
        write_avalon_16("10"&X"001",X"0200",avalon_address,avalon_writedata,avalon_write); --len
        wait for 100 ns;
        --write_avalon_16("10"&X"003",X"0000",avalon_address,avalon_writedata,avalon_write); --cs
        --write_avalon_16("10"&X"003",X"0010",avalon_address,avalon_writedata,avalon_write); --cs, /10 clock
        --write_avalon_16("10"&X"003",X"0020",avalon_address,avalon_writedata,avalon_write); --cs, /12 clock
        write_avalon_16("10"&X"003",X"0030",avalon_address,avalon_writedata,avalon_write); --cs, /16 clock
        wait for 100 ns;
        write_avalon_16("10"&X"004",X"0000",avalon_address,avalon_writedata,avalon_write); --delay
        wait for 100 ns;
        write_avalon_16("10"&X"005",X"0000",avalon_address,avalon_writedata,avalon_write); --bufselect
        wait for 100 ns;
        for i in 0 to 511 loop
            write_avalon_16(std_logic_vector(to_unsigned(i,14)),std_logic_vector(to_unsigned(i*3,16)),avalon_address,avalon_writedata,avalon_write);
            write_avalon_16(std_logic_vector(to_unsigned(i+2048,14)),std_logic_vector(to_unsigned(0,16)),avalon_address,avalon_writedata,avalon_write);
            write_avalon_16(std_logic_vector(to_unsigned(i+4096,14)),std_logic_vector(to_unsigned(0,16)),avalon_address,avalon_writedata,avalon_write);
            write_avalon_16(std_logic_vector(to_unsigned(i+6144,14)),std_logic_vector(to_unsigned(0,16)),avalon_address,avalon_writedata,avalon_write);
        end loop;
        wait for 100 ns;
        --read
        wait for 500 ns;
        read_avalon_16("00"&X"312",avalon_address,avalon_read);
        wait for 500 ns;
        --start spi
        write_avalon_16("10"&X"000",X"0001",avalon_address,avalon_writedata,avalon_write);
        --toggle miso
        for i in 0 to 5000 loop
            spi_miso <= not spi_miso;
            --wait for 320 ns;
            wait for 160 ns;
        end loop;
        --switch to buf2
        write_avalon_16("10"&X"005",X"0001",avalon_address,avalon_writedata,avalon_write); --bufselect
        --start spi
        write_avalon_16("10"&X"000",X"0001",avalon_address,avalon_writedata,avalon_write);
                
        
        wait;
    end process;


end Behavioral;
