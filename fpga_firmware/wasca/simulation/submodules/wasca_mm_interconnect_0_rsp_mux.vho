--IP Functional Simulation Model
--VERSION_BEGIN 15.0 cbx_mgl 2015:04:22:18:06:50:SJ cbx_simgen 2015:04:22:18:04:08:SJ  VERSION_END


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

-- You may only use these simulation model output files for simulation
-- purposes and expressly not for synthesis or any other purposes (in which
-- event Altera disclaims all warranties of any kind).


--synopsys translate_off

--synthesis_resources = 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  wasca_mm_interconnect_0_rsp_mux IS 
	 PORT 
	 ( 
		 clk	:	IN  STD_LOGIC;
		 reset	:	IN  STD_LOGIC;
		 sink0_channel	:	IN  STD_LOGIC_VECTOR (6 DOWNTO 0);
		 sink0_data	:	IN  STD_LOGIC_VECTOR (87 DOWNTO 0);
		 sink0_endofpacket	:	IN  STD_LOGIC;
		 sink0_ready	:	OUT  STD_LOGIC;
		 sink0_startofpacket	:	IN  STD_LOGIC;
		 sink0_valid	:	IN  STD_LOGIC;
		 src_channel	:	OUT  STD_LOGIC_VECTOR (6 DOWNTO 0);
		 src_data	:	OUT  STD_LOGIC_VECTOR (87 DOWNTO 0);
		 src_endofpacket	:	OUT  STD_LOGIC;
		 src_ready	:	IN  STD_LOGIC;
		 src_startofpacket	:	OUT  STD_LOGIC;
		 src_valid	:	OUT  STD_LOGIC
	 ); 
 END wasca_mm_interconnect_0_rsp_mux;

 ARCHITECTURE RTL OF wasca_mm_interconnect_0_rsp_mux IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
 BEGIN

	sink0_ready <= src_ready;
	src_channel <= ( sink0_channel(6 DOWNTO 0));
	src_data <= ( sink0_data(87 DOWNTO 0));
	src_endofpacket <= sink0_endofpacket;
	src_startofpacket <= sink0_startofpacket;
	src_valid <= sink0_valid;

 END RTL; --wasca_mm_interconnect_0_rsp_mux
--synopsys translate_on
--VALID FILE
