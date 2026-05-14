--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:46:37 02/13/2017
-- Design Name:   
-- Module Name:   C:/Xilinx/__testbecher/testbencher/a_tb.vhd
-- Project Name:  testbencher
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ABus2AXI4Lite
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY a_tb IS
	generic (
    -- Users to add parameters here

    -- User parameters ends
    -- Do not modify the parameters beyond this line


    -- Parameters of Axi Master Bus Interface M00_AXI
    C_MASTER_AXI_TARGET_SLAVE_BASE_ADDR    : std_logic_vector    := x"00000000";
    C_MASTER_AXI_ADDR_WIDTH    : integer    := 32;
    C_MASTER_AXI_DATA_WIDTH    : integer    := 32;
    C_SLAVE_AXI_ADDR_WIDTH : integer    := 32;
    C_SLAVE_AXI_DATA_WIDTH : integer    := 32;
    C_FILESYS_AXI_ADDR_WIDTH : integer    := 32;
    C_FILESYS_AXI_DATA_WIDTH : integer    := 32
);
END a_tb;
 
ARCHITECTURE behavior OF a_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ABus2AXI4Lite
    PORT(
		-- abus ports
    abus_address         : in    std_logic_vector(25 downto 0) := (others => '0'); --          abus.address
    abus_data_in         : in std_logic_vector(15 downto 0) := (others => '0'); --          abus.addressdata
    abus_data_out        : out std_logic_vector(15 downto 0) := (others => '0'); --          abus.addressdata
    abus_data_direction  : out   std_logic                     := '0';             --              .direction
    abus_chipselect      : in    std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
    abus_read            : in    std_logic                     := '0';             --              .read
    abus_write           : in    std_logic_vector(1 downto 0)  := (others => '0'); --              .write
    abus_wait            : out   std_logic                              := '1';                                        --              .waitrequest
    abus_wait_direction  : out   std_logic                     := '0';             --              .direction
    abus_irq             : out   std_logic                     := '0';             --              .interrupt
    abus_irq_direction   : out   std_logic                     := '0';             --              .direction
    abus_reset           : in    std_logic                     := '0';             --               .saturn_reset

    -- Ports of Axi Master Bus Interface
    master_axi_aclk    : in std_logic;
    master_axi_aresetn    : in std_logic;
    master_axi_awaddr    : out std_logic_vector(C_MASTER_AXI_ADDR_WIDTH-1 downto 0);
    master_axi_awprot    : out std_logic_vector(2 downto 0);
    master_axi_awvalid    : out std_logic;
    master_axi_awready    : in std_logic;
    master_axi_wdata    : out std_logic_vector(C_MASTER_AXI_DATA_WIDTH-1 downto 0);
    master_axi_wstrb    : out std_logic_vector(C_MASTER_AXI_DATA_WIDTH/8-1 downto 0);
    master_axi_wvalid    : out std_logic;
    master_axi_wready    : in std_logic;
    master_axi_bresp    : in std_logic_vector(1 downto 0);
    master_axi_bvalid    : in std_logic;
    master_axi_bready    : out std_logic;
    master_axi_araddr    : out std_logic_vector(C_MASTER_AXI_ADDR_WIDTH-1 downto 0);
    master_axi_arprot    : out std_logic_vector(2 downto 0);
    master_axi_arvalid    : out std_logic;
    master_axi_arready    : in std_logic;
    master_axi_rdata    : in std_logic_vector(C_MASTER_AXI_DATA_WIDTH-1 downto 0);
    master_axi_rresp    : in std_logic_vector(1 downto 0);
    master_axi_rvalid    : in std_logic;
    master_axi_rready    : out std_logic;

    -- Ports of Slave Bus Interface
    slave_axi_aclk    : in std_logic;
    slave_axi_aresetn    : in std_logic;
    slave_axi_awaddr    : in std_logic_vector(C_SLAVE_AXI_ADDR_WIDTH-1 downto 0);
    slave_axi_awprot    : in std_logic_vector(2 downto 0);
    slave_axi_awvalid    : in std_logic;
    slave_axi_awready    : out std_logic;
    slave_axi_wdata    : in std_logic_vector(C_SLAVE_AXI_DATA_WIDTH-1 downto 0);
    slave_axi_wstrb    : in std_logic_vector(C_SLAVE_AXI_DATA_WIDTH/8-1 downto 0);
    slave_axi_wvalid    : in std_logic;
    slave_axi_wready    : out std_logic;
    slave_axi_bresp    : out std_logic_vector(1 downto 0);
    slave_axi_bvalid    : out std_logic;
    slave_axi_bready    : in std_logic;
    slave_axi_araddr    : in std_logic_vector(C_SLAVE_AXI_ADDR_WIDTH-1 downto 0);
    slave_axi_arprot    : in std_logic_vector(2 downto 0);
    slave_axi_arvalid    : in std_logic;
    slave_axi_arready    : out std_logic;
    slave_axi_rdata    : out std_logic_vector(C_SLAVE_AXI_DATA_WIDTH-1 downto 0);
    slave_axi_rresp    : out std_logic_vector(1 downto 0);
    slave_axi_rvalid    : out std_logic;
    slave_axi_rready    : in std_logic

        );
    END COMPONENT;
    
    COMPONENT test_mem
    PORT(
         s_aclk : IN  std_logic;
         s_aresetn : IN  std_logic;
         s_axi_awaddr : in  std_logic_vector(31 downto 0);
         s_axi_awvalid : in  std_logic;
         s_axi_awready : out  std_logic;
         s_axi_wdata : in  std_logic_vector(31 downto 0);
         s_axi_wstrb : in  std_logic_vector(3 downto 0);
         s_axi_wvalid : in  std_logic;
         s_axi_wready : out  std_logic;
         s_axi_bresp : out  std_logic_vector(1 downto 0);
         s_axi_bvalid : out  std_logic;
         s_axi_bready : in  std_logic;
         s_axi_araddr : in  std_logic_vector(31 downto 0);
         s_axi_arvalid : in  std_logic;
         s_axi_arready : out  std_logic;
         s_axi_rdata : out  std_logic_vector(31 downto 0);
         s_axi_rresp : out  std_logic_vector(1 downto 0);
         s_axi_rvalid : out  std_logic;
         s_axi_rready : in  std_logic
        );
    END COMPONENT;

   --Inputs
   signal abus_address : std_logic_vector(25 downto 0) := (others => '0');
   signal abus_data_in : std_logic_vector(15 downto 0) := (others => '0');
   signal abus_chipselect : std_logic_vector(2 downto 0) := (others => '0');
   signal abus_read : std_logic := '0';
   signal abus_write : std_logic_vector(1 downto 0) := (others => '0');
   signal abus_reset : std_logic := '0';
   signal master_axi_init_axi_txn : std_logic := '0';
   signal master_axi_aclk : std_logic := '0';
   signal master_axi_aresetn : std_logic := '0';
   signal master_axi_awready : std_logic := '0';
   signal master_axi_wready : std_logic := '0';
   signal master_axi_bresp : std_logic_vector(1 downto 0) := (others => '0');
   signal master_axi_bvalid : std_logic := '0';
   signal master_axi_arready : std_logic := '0';
   signal master_axi_rdata : std_logic_vector(31 downto 0) := (others => '0');
   signal master_axi_rresp : std_logic_vector(1 downto 0) := (others => '0');
   signal master_axi_rvalid : std_logic := '0';
   signal slave_axi_awaddr : std_logic_vector(31 downto 0) := (others => '0');
   signal slave_axi_awprot : std_logic_vector(2 downto 0) := (others => '0');
   signal slave_axi_awvalid : std_logic := '0';
   signal slave_axi_wdata : std_logic_vector(31 downto 0) := (others => '0');
   signal slave_axi_wstrb : std_logic_vector(3 downto 0) := (others => '0');
   signal slave_axi_wvalid : std_logic := '0';
   signal slave_axi_bready : std_logic := '0';
   signal slave_axi_araddr : std_logic_vector(31 downto 0) := (others => '0');
   signal slave_axi_arprot : std_logic_vector(2 downto 0) := (others => '0');
   signal slave_axi_arvalid : std_logic := '0';
   signal slave_axi_rready : std_logic := '0';

 	--Outputs
   signal abus_data_out : std_logic_vector(15 downto 0);
   signal abus_data_direction : std_logic := '0';
   signal abus_wait : std_logic := '0';
   signal abus_wait_direction : std_logic := '0';
   signal abus_irq : std_logic := '0';
   signal abus_irq_direction : std_logic := '0';
   signal master_axi_error : std_logic := '0';
   signal master_axi_txn_done : std_logic := '0';
   signal master_axi_awaddr : std_logic_vector(31 downto 0) := (others => '0');
   signal master_axi_awprot : std_logic_vector(2 downto 0) := (others => '0');
   signal master_axi_awvalid : std_logic := '0';
   signal master_axi_wdata : std_logic_vector(31 downto 0) := (others => '0');
   signal master_axi_wstrb : std_logic_vector(3 downto 0) := (others => '0');
   signal master_axi_wvalid : std_logic := '0';
   signal master_axi_bready : std_logic := '0';
   signal master_axi_araddr : std_logic_vector(31 downto 0) := (others => '0');
   signal master_axi_arprot : std_logic_vector(2 downto 0) := (others => '0');
   signal master_axi_arvalid : std_logic := '0';
   signal master_axi_rready : std_logic := '0';
   signal slave_axi_aclk : std_logic := '0';
   signal slave_axi_aresetn : std_logic := '0';
   signal slave_axi_awready : std_logic := '0';
   signal slave_axi_wready : std_logic := '0';
   signal slave_axi_bresp : std_logic_vector(1 downto 0) := (others => '0');
   signal slave_axi_bvalid : std_logic := '0';
   signal slave_axi_arready : std_logic := '0';
   signal slave_axi_rdata : std_logic_vector(31 downto 0) := (others => '0');
   signal slave_axi_rresp : std_logic_vector(1 downto 0) := (others => '0');
   signal slave_axi_rvalid : std_logic := '0';

   -- Clock period definitions
   constant master_axi_aclk_period : time := 10 ns;
   
   	procedure abus_write_proc (addr : in std_logic_vector(25 downto 0);
                                data : in std_logic_vector(15 downto 0);
                                chipselect : in std_logic_vector(2 downto 0);
                                signal ABus_Ad : out std_logic_vector(25 downto 0);
                                signal ABus_Da : out std_logic_vector(15 downto 0);
                                signal ABus_CS : out std_logic_vector(2 downto 0);
                                signal ABus_Wr : out std_logic_vector(1 downto 0)
                                ) is
   begin
           --set quantizer 25mhz
           ABus_Ad <= addr;
           ABus_Da <= data;
           wait for 100ns;
           ABus_CS <= chipselect;
           wait for 100ns;
           ABus_Wr <= "00";
           wait for 1000ns;
           ABus_Wr <= "11";
           wait for 100ns;
           ABus_CS <= "111";
           ABus_Da <= (others => 'Z');
           wait for 100ns;
   end abus_write_proc;

   	procedure abus_read_proc (addr : in std_logic_vector(25 downto 0);
                                chipselect : in std_logic_vector(2 downto 0);
                                signal ABus_Ad : out std_logic_vector(25 downto 0);
                                signal ABus_CS : out std_logic_vector(2 downto 0);
                                signal ABus_Re : out std_logic
                                ) is
   begin
           --set quantizer 25mhz
           ABus_Ad <= addr;
           wait for 100ns;
           ABus_CS <= chipselect;
           wait for 100ns;
           ABus_Re <= '0';
           wait for 1000ns;
           ABus_Re <= '1';
           wait for 100ns;
           ABus_CS <= "111";
           wait for 100ns;
   end abus_read_proc;

 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ABus2AXI4Lite PORT MAP (
          abus_address => abus_address,
          abus_data_in => abus_data_in,
          abus_data_out => abus_data_out,
          abus_data_direction => abus_data_direction,
          abus_chipselect => abus_chipselect,
          abus_read => abus_read,
          abus_write => abus_write,
          abus_wait => abus_wait,
          abus_wait_direction => abus_wait_direction,
          abus_irq => abus_irq,
          abus_irq_direction => abus_irq_direction,
          abus_reset => abus_reset,
          master_axi_aclk => master_axi_aclk,
          master_axi_aresetn => master_axi_aresetn,
          master_axi_awaddr => master_axi_awaddr,
          master_axi_awprot => master_axi_awprot,
          master_axi_awvalid => master_axi_awvalid,
          master_axi_awready => master_axi_awready,
          master_axi_wdata => master_axi_wdata,
          master_axi_wstrb => master_axi_wstrb,
          master_axi_wvalid => master_axi_wvalid,
          master_axi_wready => master_axi_wready,
          master_axi_bresp => master_axi_bresp,
          master_axi_bvalid => master_axi_bvalid,
          master_axi_bready => master_axi_bready,
          master_axi_araddr => master_axi_araddr,
          master_axi_arprot => master_axi_arprot,
          master_axi_arvalid => master_axi_arvalid,
          master_axi_arready => master_axi_arready,
          master_axi_rdata => master_axi_rdata,
          master_axi_rresp => master_axi_rresp,
          master_axi_rvalid => master_axi_rvalid,
          master_axi_rready => master_axi_rready,
          slave_axi_aclk => slave_axi_aclk,
          slave_axi_aresetn => slave_axi_aresetn,
          slave_axi_awaddr => slave_axi_awaddr,
          slave_axi_awprot => slave_axi_awprot,
          slave_axi_awvalid => slave_axi_awvalid,
          slave_axi_awready => slave_axi_awready,
          slave_axi_wdata => slave_axi_wdata,
          slave_axi_wstrb => slave_axi_wstrb,
          slave_axi_wvalid => slave_axi_wvalid,
          slave_axi_wready => slave_axi_wready,
          slave_axi_bresp => slave_axi_bresp,
          slave_axi_bvalid => slave_axi_bvalid,
          slave_axi_bready => slave_axi_bready,
          slave_axi_araddr => slave_axi_araddr,
          slave_axi_arprot => slave_axi_arprot,
          slave_axi_arvalid => slave_axi_arvalid,
          slave_axi_arready => slave_axi_arready,
          slave_axi_rdata => slave_axi_rdata,
          slave_axi_rresp => slave_axi_rresp,
          slave_axi_rvalid => slave_axi_rvalid,
          slave_axi_rready => slave_axi_rready
        );

   das_mem: test_mem PORT MAP (
          s_aclk => master_axi_aclk,
          s_aresetn => master_axi_aresetn,
          s_axi_awaddr => master_axi_awaddr,
          s_axi_awvalid => master_axi_awvalid,
          s_axi_awready => master_axi_awready,
          s_axi_wdata => master_axi_wdata,
          s_axi_wstrb => master_axi_wstrb,
          s_axi_wvalid => master_axi_wvalid,
          s_axi_wready => master_axi_wready,
          s_axi_bresp => master_axi_bresp,
          s_axi_bvalid => master_axi_bvalid,
          s_axi_bready => master_axi_bready,
          s_axi_araddr => master_axi_araddr,
          s_axi_arvalid => master_axi_arvalid,
          s_axi_arready => master_axi_arready,
          s_axi_rdata => master_axi_rdata,
          s_axi_rresp => master_axi_rresp,
          s_axi_rvalid => master_axi_rvalid,
          s_axi_rready => master_axi_rready
          );

 
   -- Clock process definitions
   master_axi_aclk_process :process
   begin
		master_axi_aclk <= '0';
		wait for master_axi_aclk_period/2;
		master_axi_aclk <= '1';
		wait for master_axi_aclk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin
      abus_write <= "11";
      abus_read <= '1';
      abus_chipselect <= "111";		
      master_axi_aresetn <= '0';
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for master_axi_aclk_period*10;
      master_axi_aresetn <= '1';

      -- insert stimulus here
      --abus read transaction
      wait for 1000 ns;	
      abus_write_proc("00"&X"000000",X"FADE","101",abus_address,abus_data_in,abus_chipselect,abus_write);
      abus_write_proc("00"&X"000002",X"1193","101",abus_address,abus_data_in,abus_chipselect,abus_write);
      abus_write_proc("00"&X"000004",X"0003","101",abus_address,abus_data_in,abus_chipselect,abus_write);
      abus_write_proc("00"&X"000006",X"FACE","101",abus_address,abus_data_in,abus_chipselect,abus_write);
      abus_read_proc("00"&X"000000","101",abus_address,abus_chipselect,abus_read);
      abus_read_proc("00"&X"000002","101",abus_address,abus_chipselect,abus_read);
      abus_read_proc("00"&X"000004","101",abus_address,abus_chipselect,abus_read);
      abus_read_proc("00"&X"000006","101",abus_address,abus_chipselect,abus_read);

      --wasca system regs write and read
      wait for 1000 ns;	
      abus_write_proc("11"&X"FFFFF4",X"ACBD","110",abus_address,abus_data_in,abus_chipselect,abus_write); --mode
      abus_read_proc("11"&X"FFFFF0","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFFFF2","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFFFF4","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFFFF8","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFFFFA","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFFFFC","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFFFFE","110",abus_address,abus_chipselect,abus_read);

      --wasca filesystem regs write and read
      wait for 1000 ns;	
      abus_write_proc("11"&X"FFEFF0",X"FADE","110",abus_address,abus_data_in,abus_chipselect,abus_write); --lock
      abus_write_proc("11"&X"FFEFF2",X"0001","110",abus_address,abus_data_in,abus_chipselect,abus_write); --cmd
      abus_read_proc("11"&X"FFFFF4","110",abus_address,abus_chipselect,abus_read);--status
      abus_write_proc("11"&X"FFE000",X"DADA","110",abus_address,abus_data_in,abus_chipselect,abus_write); --data buf
      abus_write_proc("11"&X"FFE002",X"DADA","110",abus_address,abus_data_in,abus_chipselect,abus_write); --data buf
      abus_write_proc("11"&X"FFE7FC",X"DADA","110",abus_address,abus_data_in,abus_chipselect,abus_write); --data buf
      abus_write_proc("11"&X"FFE7FE",X"DADA","110",abus_address,abus_data_in,abus_chipselect,abus_write); --data buf
      abus_write_proc("11"&X"FFE800",X"CDCD","110",abus_address,abus_data_in,abus_chipselect,abus_write); --data buf
      abus_write_proc("11"&X"FFE802",X"CDCD","110",abus_address,abus_data_in,abus_chipselect,abus_write); --data buf
      abus_write_proc("11"&X"FFEFEC",X"CDCD","110",abus_address,abus_data_in,abus_chipselect,abus_write); --data buf
      abus_write_proc("11"&X"FFEFEE",X"CDCD","110",abus_address,abus_data_in,abus_chipselect,abus_write); --data buf
      abus_read_proc("11"&X"FFF000","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFF002","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFF7FC","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFF7FE","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFF800","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFF802","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFFFEC","110",abus_address,abus_chipselect,abus_read);
      abus_read_proc("11"&X"FFFFEE","110",abus_address,abus_chipselect,abus_read);
            

      wait;
   end process;

END;
