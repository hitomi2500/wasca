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

--synthesis_resources = mux21 43 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  wasca_mm_interconnect_0_router_001 IS 
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
 END wasca_mm_interconnect_0_router_001;

 ARCHITECTURE RTL OF wasca_mm_interconnect_0_router_001 IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_20m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_21m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_28m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_31m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_32m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_39m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_41m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_42m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_43m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_50m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_51m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_52m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_53m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_54m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_59m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_61m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_62m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_63m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_64m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_65m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_69m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_70m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_71m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_72m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_73m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_74m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_channel_75m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_23m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_33m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_34m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_35m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_44m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_45m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_46m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_55m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_56m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_57m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_66m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_67m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_68m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_76m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_77m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_wasca_mm_interconnect_0_router_001_src_data_78m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_w3w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w4w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_wasca_mm_interconnect_0_router_001_always1_0_345_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_wasca_mm_interconnect_0_router_001_always1_3_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_wasca_mm_interconnect_0_router_001_src_channel_0_373_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_wasca_mm_interconnect_0_router_001_src_channel_1_401_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_wasca_mm_interconnect_0_router_001_src_channel_2_429_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_wasca_mm_interconnect_0_router_001_src_channel_3_457_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout :	STD_LOGIC;
 BEGIN

	wire_w3w(0) <= NOT s_wire_wasca_mm_interconnect_0_router_001_always1_3_dataout;
	wire_w4w(0) <= NOT s_wire_wasca_mm_interconnect_0_router_001_src_channel_0_373_dataout;
	s_wire_wasca_mm_interconnect_0_router_001_always1_0_345_dataout <= ((((((((((NOT sink_data(53)) AND (NOT sink_data(54))) AND (NOT sink_data(55))) AND (NOT sink_data(56))) AND (NOT sink_data(57))) AND (NOT sink_data(58))) AND (NOT sink_data(59))) AND (NOT sink_data(60))) AND (NOT sink_data(61))) AND (NOT sink_data(62)));
	s_wire_wasca_mm_interconnect_0_router_001_always1_3_dataout <= (sink_data(66) AND s_wire_wasca_mm_interconnect_0_router_001_always1_0_345_dataout);
	s_wire_wasca_mm_interconnect_0_router_001_src_channel_0_373_dataout <= (((((((((((((((NOT sink_data(48)) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND sink_data(53)) AND (NOT sink_data(54))) AND (NOT sink_data(55))) AND (NOT sink_data(56))) AND (NOT sink_data(57))) AND (NOT sink_data(58))) AND (NOT sink_data(59))) AND (NOT sink_data(60))) AND (NOT sink_data(61))) AND (NOT sink_data(62)));
	s_wire_wasca_mm_interconnect_0_router_001_src_channel_1_401_dataout <= ((((((((((((((((NOT sink_data(47)) AND sink_data(48)) AND (NOT sink_data(49))) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND sink_data(53)) AND (NOT sink_data(54))) AND (NOT sink_data(55))) AND (NOT sink_data(56))) AND (NOT sink_data(57))) AND (NOT sink_data(58))) AND (NOT sink_data(59))) AND (NOT sink_data(60))) AND (NOT sink_data(61))) AND (NOT sink_data(62)));
	s_wire_wasca_mm_interconnect_0_router_001_src_channel_2_429_dataout <= (((((((((((((((((((((((NOT sink_data(40)) AND (NOT sink_data(41))) AND (NOT sink_data(42))) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND (NOT sink_data(48))) AND sink_data(49)) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND sink_data(53)) AND (NOT sink_data(54))) AND (NOT sink_data(55))) AND (NOT sink_data(56))) AND (NOT sink_data(57))) AND (NOT sink_data(58))) AND (NOT sink_data(59))) AND (NOT sink_data(60))) AND (NOT sink_data(61))) AND (NOT sink_data(62)));
	s_wire_wasca_mm_interconnect_0_router_001_src_channel_3_457_dataout <= ((((((((((((((((((((((NOT sink_data(41)) AND (NOT sink_data(42))) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND sink_data(48)) AND sink_data(49)) AND (NOT sink_data(50))) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND sink_data(53)) AND (NOT sink_data(54))) AND (NOT sink_data(55))) AND (NOT sink_data(56))) AND (NOT sink_data(57))) AND (NOT sink_data(58))) AND (NOT sink_data(59))) AND (NOT sink_data(60))) AND (NOT sink_data(61))) AND (NOT sink_data(62)));
	s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout <= (((((((((((((((((((((((NOT sink_data(40)) AND (NOT sink_data(41))) AND (NOT sink_data(42))) AND (NOT sink_data(43))) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND (NOT sink_data(48))) AND (NOT sink_data(49))) AND sink_data(50)) AND (NOT sink_data(51))) AND (NOT sink_data(52))) AND sink_data(53)) AND (NOT sink_data(54))) AND (NOT sink_data(55))) AND (NOT sink_data(56))) AND (NOT sink_data(57))) AND (NOT sink_data(58))) AND (NOT sink_data(59))) AND (NOT sink_data(60))) AND (NOT sink_data(61))) AND (NOT sink_data(62)));
	sink_ready <= src_ready;
	src_channel <= ( wire_wasca_mm_interconnect_0_router_001_src_channel_69m_dataout & wire_wasca_mm_interconnect_0_router_001_src_channel_70m_dataout & wire_wasca_mm_interconnect_0_router_001_src_channel_71m_dataout & wire_wasca_mm_interconnect_0_router_001_src_channel_72m_dataout & wire_wasca_mm_interconnect_0_router_001_src_channel_73m_dataout & wire_wasca_mm_interconnect_0_router_001_src_channel_74m_dataout & wire_wasca_mm_interconnect_0_router_001_src_channel_75m_dataout);
	src_data <= ( sink_data(105 DOWNTO 93) & wire_wasca_mm_interconnect_0_router_001_src_data_76m_dataout & wire_wasca_mm_interconnect_0_router_001_src_data_77m_dataout & wire_wasca_mm_interconnect_0_router_001_src_data_78m_dataout & sink_data(89 DOWNTO 0));
	src_endofpacket <= sink_endofpacket;
	src_startofpacket <= sink_startofpacket;
	src_valid <= sink_valid;
	wire_wasca_mm_interconnect_0_router_001_src_channel_20m_dataout <= s_wire_wasca_mm_interconnect_0_router_001_always1_3_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_0_373_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_21m_dataout <= wire_w3w(0) AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_0_373_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_28m_dataout <= s_wire_wasca_mm_interconnect_0_router_001_src_channel_0_373_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_1_401_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_31m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_20m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_1_401_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_32m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_21m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_1_401_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_39m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_28m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_2_429_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_41m_dataout <= s_wire_wasca_mm_interconnect_0_router_001_src_channel_1_401_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_2_429_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_42m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_31m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_2_429_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_43m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_32m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_2_429_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_50m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_39m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_3_457_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_51m_dataout <= s_wire_wasca_mm_interconnect_0_router_001_src_channel_2_429_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_3_457_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_52m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_41m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_3_457_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_53m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_42m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_3_457_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_54m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_43m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_3_457_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_59m_dataout <= s_wire_wasca_mm_interconnect_0_router_001_src_channel_3_457_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_61m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_50m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_62m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_51m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_63m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_52m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_64m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_53m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_65m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_54m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_channel_69m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_59m_dataout AND NOT(sink_data(62));
	wire_wasca_mm_interconnect_0_router_001_src_channel_70m_dataout <= s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout AND NOT(sink_data(62));
	wire_wasca_mm_interconnect_0_router_001_src_channel_71m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_61m_dataout AND NOT(sink_data(62));
	wire_wasca_mm_interconnect_0_router_001_src_channel_72m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_62m_dataout AND NOT(sink_data(62));
	wire_wasca_mm_interconnect_0_router_001_src_channel_73m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_63m_dataout AND NOT(sink_data(62));
	wire_wasca_mm_interconnect_0_router_001_src_channel_74m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_64m_dataout AND NOT(sink_data(62));
	wire_wasca_mm_interconnect_0_router_001_src_channel_75m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_channel_65m_dataout OR sink_data(62);
	wire_wasca_mm_interconnect_0_router_001_src_data_23m_dataout <= s_wire_wasca_mm_interconnect_0_router_001_always1_3_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_0_373_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_data_33m_dataout <= s_wire_wasca_mm_interconnect_0_router_001_src_channel_0_373_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_1_401_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_data_34m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_23m_dataout OR s_wire_wasca_mm_interconnect_0_router_001_src_channel_1_401_dataout;
	wire_wasca_mm_interconnect_0_router_001_src_data_35m_dataout <= wire_w4w(0) AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_1_401_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_data_44m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_33m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_2_429_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_data_45m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_34m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_2_429_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_data_46m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_35m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_2_429_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_data_55m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_44m_dataout OR s_wire_wasca_mm_interconnect_0_router_001_src_channel_3_457_dataout;
	wire_wasca_mm_interconnect_0_router_001_src_data_56m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_45m_dataout OR s_wire_wasca_mm_interconnect_0_router_001_src_channel_3_457_dataout;
	wire_wasca_mm_interconnect_0_router_001_src_data_57m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_46m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_3_457_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_data_66m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_55m_dataout OR s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout;
	wire_wasca_mm_interconnect_0_router_001_src_data_67m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_56m_dataout AND NOT(s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout);
	wire_wasca_mm_interconnect_0_router_001_src_data_68m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_57m_dataout OR s_wire_wasca_mm_interconnect_0_router_001_src_channel_4_485_dataout;
	wire_wasca_mm_interconnect_0_router_001_src_data_76m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_66m_dataout AND NOT(sink_data(62));
	wire_wasca_mm_interconnect_0_router_001_src_data_77m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_67m_dataout AND NOT(sink_data(62));
	wire_wasca_mm_interconnect_0_router_001_src_data_78m_dataout <= wire_wasca_mm_interconnect_0_router_001_src_data_68m_dataout OR sink_data(62);

 END RTL; --wasca_mm_interconnect_0_router_001
--synopsys translate_on
--VALID FILE
