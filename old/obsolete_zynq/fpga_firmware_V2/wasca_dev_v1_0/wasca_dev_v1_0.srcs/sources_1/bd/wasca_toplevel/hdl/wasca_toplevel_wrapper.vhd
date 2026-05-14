--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.2 (win64) Build 1577090 Thu Jun  2 16:32:40 MDT 2016
--Date        : Thu Mar 02 22:09:48 2017
--Host        : Tho running 64-bit Service Pack 1  (build 7601)
--Command     : generate_target wasca_toplevel_wrapper.bd
--Design      : wasca_toplevel_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity wasca_toplevel_wrapper is
  port (
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_cas_n : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    abus_address : in STD_LOGIC_VECTOR ( 25 downto 0 );
    abus_chipselect : in STD_LOGIC_VECTOR ( 2 downto 0 );
    abus_data_dir : out STD_LOGIC;
    abus_irq : inout STD_LOGIC_VECTOR ( 0 to 0 );
    abus_irq_dir : out STD_LOGIC;
    abus_read : in STD_LOGIC;
    abus_reset : in STD_LOGIC;
    abus_wait : inout STD_LOGIC;
    abus_wait_dir : out STD_LOGIC;
    abus_write : in STD_LOGIC_VECTOR ( 1 downto 0 );
    data_to_and_from_pins : inout STD_LOGIC_VECTOR ( 15 downto 0 )
  );
end wasca_toplevel_wrapper;

architecture STRUCTURE of wasca_toplevel_wrapper is
  component wasca_toplevel is
  port (
    DDR_cas_n : inout STD_LOGIC;
    DDR_cke : inout STD_LOGIC;
    DDR_ck_n : inout STD_LOGIC;
    DDR_ck_p : inout STD_LOGIC;
    DDR_cs_n : inout STD_LOGIC;
    DDR_reset_n : inout STD_LOGIC;
    DDR_odt : inout STD_LOGIC;
    DDR_ras_n : inout STD_LOGIC;
    DDR_we_n : inout STD_LOGIC;
    DDR_ba : inout STD_LOGIC_VECTOR ( 2 downto 0 );
    DDR_addr : inout STD_LOGIC_VECTOR ( 14 downto 0 );
    DDR_dm : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dq : inout STD_LOGIC_VECTOR ( 31 downto 0 );
    DDR_dqs_n : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    DDR_dqs_p : inout STD_LOGIC_VECTOR ( 3 downto 0 );
    FIXED_IO_mio : inout STD_LOGIC_VECTOR ( 53 downto 0 );
    FIXED_IO_ddr_vrn : inout STD_LOGIC;
    FIXED_IO_ddr_vrp : inout STD_LOGIC;
    FIXED_IO_ps_srstb : inout STD_LOGIC;
    FIXED_IO_ps_clk : inout STD_LOGIC;
    FIXED_IO_ps_porb : inout STD_LOGIC;
    data_to_and_from_pins : inout STD_LOGIC_VECTOR ( 15 downto 0 );
    abus_chipselect : in STD_LOGIC_VECTOR ( 2 downto 0 );
    abus_read : in STD_LOGIC;
    abus_reset : in STD_LOGIC;
    abus_irq : inout STD_LOGIC_VECTOR ( 0 to 0 );
    abus_write : in STD_LOGIC_VECTOR ( 1 downto 0 );
    abus_wait : inout STD_LOGIC;
    abus_address : in STD_LOGIC_VECTOR ( 25 downto 0 );
    abus_data_dir : out STD_LOGIC;
    abus_irq_dir : out STD_LOGIC;
    abus_wait_dir : out STD_LOGIC
  );
  end component wasca_toplevel;
begin
wasca_toplevel_i: component wasca_toplevel
     port map (
      DDR_addr(14 downto 0) => DDR_addr(14 downto 0),
      DDR_ba(2 downto 0) => DDR_ba(2 downto 0),
      DDR_cas_n => DDR_cas_n,
      DDR_ck_n => DDR_ck_n,
      DDR_ck_p => DDR_ck_p,
      DDR_cke => DDR_cke,
      DDR_cs_n => DDR_cs_n,
      DDR_dm(3 downto 0) => DDR_dm(3 downto 0),
      DDR_dq(31 downto 0) => DDR_dq(31 downto 0),
      DDR_dqs_n(3 downto 0) => DDR_dqs_n(3 downto 0),
      DDR_dqs_p(3 downto 0) => DDR_dqs_p(3 downto 0),
      DDR_odt => DDR_odt,
      DDR_ras_n => DDR_ras_n,
      DDR_reset_n => DDR_reset_n,
      DDR_we_n => DDR_we_n,
      FIXED_IO_ddr_vrn => FIXED_IO_ddr_vrn,
      FIXED_IO_ddr_vrp => FIXED_IO_ddr_vrp,
      FIXED_IO_mio(53 downto 0) => FIXED_IO_mio(53 downto 0),
      FIXED_IO_ps_clk => FIXED_IO_ps_clk,
      FIXED_IO_ps_porb => FIXED_IO_ps_porb,
      FIXED_IO_ps_srstb => FIXED_IO_ps_srstb,
      abus_address(25 downto 0) => abus_address(25 downto 0),
      abus_chipselect(2 downto 0) => abus_chipselect(2 downto 0),
      abus_data_dir => abus_data_dir,
      abus_irq(0) => abus_irq(0),
      abus_irq_dir => abus_irq_dir,
      abus_read => abus_read,
      abus_reset => abus_reset,
      abus_wait => abus_wait,
      abus_wait_dir => abus_wait_dir,
      abus_write(1 downto 0) => abus_write(1 downto 0),
      data_to_and_from_pins(15 downto 0) => data_to_and_from_pins(15 downto 0)
    );
end STRUCTURE;
