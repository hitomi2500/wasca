-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "06/29/2015 07:58:18"
                                                            
-- Vhdl Test Bench template for design  :  wasca_toplevel
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY wasca_toplevel_vhd_tst IS
END wasca_toplevel_vhd_tst;
ARCHITECTURE wasca_toplevel_arch OF wasca_toplevel_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk_clk : STD_LOGIC := '0';
SIGNAL external_sdram_controller_wire_addr : STD_LOGIC_VECTOR(12 DOWNTO 0) := (others => '0');
SIGNAL external_sdram_controller_wire_ba : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
SIGNAL external_sdram_controller_wire_cas_n : STD_LOGIC := '0';
SIGNAL external_sdram_controller_wire_cke : STD_LOGIC := '0';
SIGNAL external_sdram_controller_wire_cs_n : STD_LOGIC := '0';
SIGNAL external_sdram_controller_wire_dq : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
SIGNAL external_sdram_controller_wire_dqm : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
SIGNAL external_sdram_controller_wire_ras_n : STD_LOGIC := '0';
SIGNAL external_sdram_controller_wire_we_n : STD_LOGIC := '0';
SIGNAL pio_0_external_connection_export : STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');
SIGNAL reset_reset_n : STD_LOGIC := '0';
SIGNAL sd_card_spi_external_MISO : STD_LOGIC := '0';
SIGNAL sd_card_spi_external_MOSI : STD_LOGIC := '0';
SIGNAL sd_card_spi_external_SCLK : STD_LOGIC := '0';
SIGNAL sd_card_spi_external_SS_n : STD_LOGIC := '0';
SIGNAL sega_saturn_abus_slave_0_abus_address : STD_LOGIC_VECTOR(25 DOWNTO 16) := (others => '0');
SIGNAL sega_saturn_abus_slave_0_abus_addressdata : STD_LOGIC_VECTOR(15 DOWNTO 0) := (others => '0');
SIGNAL sega_saturn_abus_slave_0_abus_addressstrobe : STD_LOGIC := '0';
SIGNAL sega_saturn_abus_slave_0_abus_chipselect : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
SIGNAL sega_saturn_abus_slave_0_abus_direction : STD_LOGIC := '0';
SIGNAL sega_saturn_abus_slave_0_abus_functioncode : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
SIGNAL sega_saturn_abus_slave_0_abus_interrupt : STD_LOGIC := '0';
SIGNAL sega_saturn_abus_slave_0_abus_muxing : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
SIGNAL sega_saturn_abus_slave_0_abus_read : STD_LOGIC := '0';
SIGNAL sega_saturn_abus_slave_0_abus_timing : STD_LOGIC_VECTOR(2 DOWNTO 0) := (others => '0');
SIGNAL sega_saturn_abus_slave_0_abus_waitrequest : STD_LOGIC := '0';
SIGNAL sega_saturn_abus_slave_0_abus_write : STD_LOGIC_VECTOR(1 DOWNTO 0) := (others => '0');
COMPONENT wasca_toplevel
	PORT (
	clk_clk : IN STD_LOGIC;
	external_sdram_controller_wire_addr : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
	external_sdram_controller_wire_ba : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	external_sdram_controller_wire_cas_n : OUT STD_LOGIC;
	external_sdram_controller_wire_cke : OUT STD_LOGIC;
	external_sdram_controller_wire_cs_n : OUT STD_LOGIC;
	external_sdram_controller_wire_dq : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	external_sdram_controller_wire_dqm : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	external_sdram_controller_wire_ras_n : OUT STD_LOGIC;
	external_sdram_controller_wire_we_n : OUT STD_LOGIC;
	pio_0_external_connection_export : INOUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	reset_reset_n : IN STD_LOGIC;
	sd_card_spi_external_MISO : IN STD_LOGIC;
	sd_card_spi_external_MOSI : OUT STD_LOGIC;
	sd_card_spi_external_SCLK : OUT STD_LOGIC;
	sd_card_spi_external_SS_n : OUT STD_LOGIC;
	sega_saturn_abus_slave_0_abus_address : IN STD_LOGIC_VECTOR(25 DOWNTO 16);
	sega_saturn_abus_slave_0_abus_addressdata : INOUT STD_LOGIC_VECTOR(15 DOWNTO 0);
	sega_saturn_abus_slave_0_abus_addressstrobe : IN STD_LOGIC;
	sega_saturn_abus_slave_0_abus_chipselect : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	sega_saturn_abus_slave_0_abus_direction : OUT STD_LOGIC;
	sega_saturn_abus_slave_0_abus_functioncode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
	sega_saturn_abus_slave_0_abus_interrupt : OUT STD_LOGIC;
	sega_saturn_abus_slave_0_abus_muxing : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
	sega_saturn_abus_slave_0_abus_read : IN STD_LOGIC;
	sega_saturn_abus_slave_0_abus_timing : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
	sega_saturn_abus_slave_0_abus_waitrequest : OUT STD_LOGIC;
	sega_saturn_abus_slave_0_abus_write : IN STD_LOGIC_VECTOR(1 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : wasca_toplevel
	PORT MAP (
-- list connections between master ports and signals
	clk_clk => clk_clk,
	external_sdram_controller_wire_addr => external_sdram_controller_wire_addr,
	external_sdram_controller_wire_ba => external_sdram_controller_wire_ba,
	external_sdram_controller_wire_cas_n => external_sdram_controller_wire_cas_n,
	external_sdram_controller_wire_cke => external_sdram_controller_wire_cke,
	external_sdram_controller_wire_cs_n => external_sdram_controller_wire_cs_n,
	external_sdram_controller_wire_dq => external_sdram_controller_wire_dq,
	external_sdram_controller_wire_dqm => external_sdram_controller_wire_dqm,
	external_sdram_controller_wire_ras_n => external_sdram_controller_wire_ras_n,
	external_sdram_controller_wire_we_n => external_sdram_controller_wire_we_n,
	pio_0_external_connection_export => pio_0_external_connection_export,
	reset_reset_n => reset_reset_n,
	sd_card_spi_external_MISO => sd_card_spi_external_MISO,
	sd_card_spi_external_MOSI => sd_card_spi_external_MOSI,
	sd_card_spi_external_SCLK => sd_card_spi_external_SCLK,
	sd_card_spi_external_SS_n => sd_card_spi_external_SS_n,
	sega_saturn_abus_slave_0_abus_address(25 downto 16) => sega_saturn_abus_slave_0_abus_address(25 downto 16),
	sega_saturn_abus_slave_0_abus_addressdata => sega_saturn_abus_slave_0_abus_addressdata,
	sega_saturn_abus_slave_0_abus_addressstrobe => sega_saturn_abus_slave_0_abus_addressstrobe,
	sega_saturn_abus_slave_0_abus_chipselect => sega_saturn_abus_slave_0_abus_chipselect,
	sega_saturn_abus_slave_0_abus_direction => sega_saturn_abus_slave_0_abus_direction,
	sega_saturn_abus_slave_0_abus_functioncode => sega_saturn_abus_slave_0_abus_functioncode,
	sega_saturn_abus_slave_0_abus_interrupt => sega_saturn_abus_slave_0_abus_interrupt,
	sega_saturn_abus_slave_0_abus_muxing => sega_saturn_abus_slave_0_abus_muxing,
	sega_saturn_abus_slave_0_abus_read => sega_saturn_abus_slave_0_abus_read,
	sega_saturn_abus_slave_0_abus_timing => sega_saturn_abus_slave_0_abus_timing,
	sega_saturn_abus_slave_0_abus_waitrequest => sega_saturn_abus_slave_0_abus_waitrequest,
	sega_saturn_abus_slave_0_abus_write => sega_saturn_abus_slave_0_abus_write
	);
	
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once  
		  sega_saturn_abus_slave_0_abus_address <= "00"&X"AB";
		  sega_saturn_abus_slave_0_abus_addressdata <= (others => 'Z');
		  sega_saturn_abus_slave_0_abus_addressstrobe <= '0';
		  sega_saturn_abus_slave_0_abus_chipselect <= "111";
		  sega_saturn_abus_slave_0_abus_functioncode <= "00";
		  sega_saturn_abus_slave_0_abus_read <= '1';
		  sega_saturn_abus_slave_0_abus_timing <= "000";
		  sega_saturn_abus_slave_0_abus_write <= "11";
		  
		  wait for 250 ns;
		  sega_saturn_abus_slave_0_abus_write <= "00";
		  wait for 10 ns;
		  sega_saturn_abus_slave_0_abus_chipselect <= "110";
		  wait for 10 ns;
		  sega_saturn_abus_slave_0_abus_addressdata <= X"FADE";
		  wait for 250 ns;
		  sega_saturn_abus_slave_0_abus_addressdata <= (others => 'Z');
		  wait for 10 ns;
		  sega_saturn_abus_slave_0_abus_write <= "11";
		  wait for 10 ns;
		  sega_saturn_abus_slave_0_abus_chipselect <= "111";
		  wait for 10 ns;
		  
		  

		  
WAIT;                                                       
END PROCESS init;   

clk_clk <= not clk_clk after 22 ns;   
                                     
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list
WAIT;                                                        
END PROCESS always;                                          
END wasca_toplevel_arch;
