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

 ENTITY  wasca_mm_interconnect_0_router_004 IS 
	 PORT 
	 ( 
		 clk	:	IN  STD_LOGIC;
		 reset	:	IN  STD_LOGIC;
		 sink_data	:	IN  STD_LOGIC_VECTOR (105 DOWNTO 0);
		 sink_endofpacket	:	IN  STD_LOGIC;
		 sink_ready	:	OUT  STD_LOGIC;
		 sink_startofpacket	:	IN  STD_LOGIC;
		 sink_valid	:	IN  STD_LOGIC;
		 src_channel	:	OUT  STD_LOGIC_VECTOR (6 DOWNTO 0);
		 src_data	:	OUT  STD_LOGIC_VECTOR (105 DOWNTO 0);
		 src_endofpacket	:	OUT  STD_LOGIC;
		 src_ready	:	IN  STD_LOGIC;
		 src_startofpacket	:	OUT  STD_LOGIC;
		 src_valid	:	OUT  STD_LOGIC
	 ); 
 END wasca_mm_interconnect_0_router_004;

 ARCHITECTURE RTL OF wasca_mm_interconnect_0_router_004 IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL  wire_w_lg_w_lg_w_sink_data_range2w5w8w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range1w9w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range2w5w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w324w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range3w4w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range6w7w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_wasca_mm_interconnect_0_router_004_always0_11_dataout :	STD_LOGIC;
	 SIGNAL  wire_w_sink_data_range1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range2w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range3w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range6w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
 BEGIN

	wire_w_lg_w_lg_w_sink_data_range2w5w8w(0) <= wire_w_lg_w_sink_data_range2w5w(0) AND wire_w_lg_w_sink_data_range6w7w(0);
	wire_w_lg_w_sink_data_range1w9w(0) <= wire_w_sink_data_range1w(0) AND wire_w_lg_w_lg_w_sink_data_range2w5w8w(0);
	wire_w_lg_w_sink_data_range2w5w(0) <= wire_w_sink_data_range2w(0) AND wire_w_lg_w_sink_data_range3w4w(0);
	wire_w324w(0) <= NOT s_wire_wasca_mm_interconnect_0_router_004_always0_11_dataout;
	wire_w_lg_w_sink_data_range3w4w(0) <= NOT wire_w_sink_data_range3w(0);
	wire_w_lg_w_sink_data_range6w7w(0) <= NOT wire_w_sink_data_range6w(0);
	s_wire_wasca_mm_interconnect_0_router_004_always0_11_dataout <= wire_w_lg_w_sink_data_range1w9w(0);
	sink_ready <= src_ready;
	src_channel <= ( "0" & "0" & "0" & "0" & "0" & s_wire_wasca_mm_interconnect_0_router_004_always0_11_dataout & wire_w324w);
	src_data <= ( sink_data(105 DOWNTO 0));
	src_endofpacket <= sink_endofpacket;
	src_startofpacket <= sink_startofpacket;
	src_valid <= sink_valid;
	wire_w_sink_data_range1w(0) <= sink_data(66);
	wire_w_sink_data_range2w(0) <= sink_data(90);
	wire_w_sink_data_range3w(0) <= sink_data(91);
	wire_w_sink_data_range6w(0) <= sink_data(92);

 END RTL; --wasca_mm_interconnect_0_router_004
--synopsys translate_on
--VALID FILE
