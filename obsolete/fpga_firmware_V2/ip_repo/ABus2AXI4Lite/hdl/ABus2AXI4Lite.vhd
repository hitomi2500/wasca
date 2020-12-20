library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ABus2AXI4Lite is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Master Bus Interface M00_AXI
		C_MASTER_AXI_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"00000000";
		C_MASTER_AXI_ADDR_WIDTH	: integer	:= 32;
		C_MASTER_AXI_DATA_WIDTH	: integer	:= 32;
        C_SLAVE_AXI_ADDR_WIDTH : integer	:= 32;
        C_SLAVE_AXI_DATA_WIDTH : integer    := 32;
        C_FILESYS_AXI_ADDR_WIDTH : integer	:= 32;
        C_FILESYS_AXI_DATA_WIDTH : integer    := 32
	);
	port (
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
		master_axi_aclk	: in std_logic;
		master_axi_aresetn	: in std_logic;
		master_axi_awaddr	: out std_logic_vector(C_MASTER_AXI_ADDR_WIDTH-1 downto 0);
		master_axi_awprot	: out std_logic_vector(2 downto 0);
		master_axi_awvalid	: out std_logic;
		master_axi_awready	: in std_logic;
		master_axi_wdata	: out std_logic_vector(C_MASTER_AXI_DATA_WIDTH-1 downto 0);
		master_axi_wstrb	: out std_logic_vector(C_MASTER_AXI_DATA_WIDTH/8-1 downto 0);
		master_axi_wvalid	: out std_logic;
		master_axi_wready	: in std_logic;
		master_axi_bresp	: in std_logic_vector(1 downto 0);
		master_axi_bvalid	: in std_logic;
		master_axi_bready	: out std_logic;
		master_axi_araddr	: out std_logic_vector(C_MASTER_AXI_ADDR_WIDTH-1 downto 0);
		master_axi_arprot	: out std_logic_vector(2 downto 0);
		master_axi_arvalid	: out std_logic;
		master_axi_arready	: in std_logic;
		master_axi_rdata	: in std_logic_vector(C_MASTER_AXI_DATA_WIDTH-1 downto 0);
		master_axi_rresp	: in std_logic_vector(1 downto 0);
		master_axi_rvalid	: in std_logic;
		master_axi_rready	: out std_logic;

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

--		-- Ports of Filesys Bus Interface
--        filesys_axi_aclk    : in std_logic;
--        filesys_axi_aresetn    : in std_logic;
--        filesys_axi_awaddr    : in std_logic_vector(C_FILESYS_AXI_ADDR_WIDTH-1 downto 0);
--        filesys_axi_awprot    : in std_logic_vector(2 downto 0);
--        filesys_axi_awvalid    : in std_logic;
--        filesys_axi_awready    : out std_logic;
--        filesys_axi_wdata    : in std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
--        filesys_axi_wstrb    : in std_logic_vector(C_FILESYS_AXI_DATA_WIDTH/8-1 downto 0);
--        filesys_axi_wvalid    : in std_logic;
--        filesys_axi_wready    : out std_logic;
--        filesys_axi_bresp    : out std_logic_vector(1 downto 0);
--        filesys_axi_bvalid    : out std_logic;
--        filesys_axi_bready    : in std_logic;
--        filesys_axi_araddr    : in std_logic_vector(C_FILESYS_AXI_ADDR_WIDTH-1 downto 0);
--        filesys_axi_arprot    : in std_logic_vector(2 downto 0);
--        filesys_axi_arvalid    : in std_logic;
--        filesys_axi_arready    : out std_logic;
--        filesys_axi_rdata    : out std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
--        filesys_axi_rresp    : out std_logic_vector(1 downto 0);
--        filesys_axi_rvalid    : out std_logic;
--        filesys_axi_rready    : in std_logic

	);
end ABus2AXI4Lite;

architecture arch_imp of ABus2AXI4Lite is

	-- component declaration
	component ABus2AXI4Lite_Master_AXI is
		generic (
		C_MASTER_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_MASTER_AXI_ADDR_WIDTH	: integer	:= 32;
		C_MASTER_AXI_DATA_WIDTH	: integer	:= 32
		);
		port (
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
        MASTER_AXI_ACLK	: in std_logic;
		MASTER_AXI_ARESETN	: in std_logic;
		MASTER_AXI_AWADDR	: out std_logic_vector(C_MASTER_AXI_ADDR_WIDTH-1 downto 0);
		MASTER_AXI_AWPROT	: out std_logic_vector(2 downto 0);
		MASTER_AXI_AWVALID	: out std_logic;
		MASTER_AXI_AWREADY	: in std_logic;
		MASTER_AXI_WDATA	: out std_logic_vector(C_MASTER_AXI_DATA_WIDTH-1 downto 0);
		MASTER_AXI_WSTRB	: out std_logic_vector(C_MASTER_AXI_DATA_WIDTH/8-1 downto 0);
		MASTER_AXI_WVALID	: out std_logic;
		MASTER_AXI_WREADY	: in std_logic;
		MASTER_AXI_BRESP	: in std_logic_vector(1 downto 0);
		MASTER_AXI_BVALID	: in std_logic;
		MASTER_AXI_BREADY	: out std_logic;
		MASTER_AXI_ARADDR	: out std_logic_vector(C_MASTER_AXI_ADDR_WIDTH-1 downto 0);
		MASTER_AXI_ARPROT	: out std_logic_vector(2 downto 0);
		MASTER_AXI_ARVALID	: out std_logic;
		MASTER_AXI_ARREADY	: in std_logic;
		MASTER_AXI_RDATA	: in std_logic_vector(C_MASTER_AXI_DATA_WIDTH-1 downto 0);
		MASTER_AXI_RRESP	: in std_logic_vector(1 downto 0);
		MASTER_AXI_RVALID	: in std_logic;
		MASTER_AXI_RREADY	: out std_logic
		);
	end component ABus2AXI4Lite_Master_AXI;

	component ABus2AXI4Lite_Slave_AXI is
		generic (
		C_SLAVE_AXI_ADDR_WIDTH	: integer	:= 32;
		C_SLAVE_AXI_DATA_WIDTH	: integer	:= 32
		);
		port (
        PCNTR : out  std_logic_vector(15 downto 0);
        STATUS : out  std_logic_vector(15 downto 0);
        MODE : in  std_logic_vector(15 downto 0);
        HWVER : in  std_logic_vector(15 downto 0);
        SWVER : out  std_logic_vector(15 downto 0);
		SLAVE_AXI_ACLK	: in std_logic;
		SLAVE_AXI_ARESETN	: in std_logic;
		SLAVE_AXI_AWADDR	: in std_logic_vector(C_SLAVE_AXI_ADDR_WIDTH-1 downto 0);
		SLAVE_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		SLAVE_AXI_AWVALID	: in std_logic;
		SLAVE_AXI_AWREADY	: out std_logic;
		SLAVE_AXI_WDATA	: in std_logic_vector(C_SLAVE_AXI_DATA_WIDTH-1 downto 0);
		SLAVE_AXI_WSTRB	: in std_logic_vector((C_SLAVE_AXI_DATA_WIDTH/8)-1 downto 0);
		SLAVE_AXI_WVALID	: in std_logic;
		SLAVE_AXI_WREADY	: out std_logic;
		SLAVE_AXI_BRESP	: out std_logic_vector(1 downto 0);
		SLAVE_AXI_BVALID	: out std_logic;
		SLAVE_AXI_BREADY	: in std_logic;
		SLAVE_AXI_ARADDR	: in std_logic_vector(C_SLAVE_AXI_ADDR_WIDTH-1 downto 0);
		SLAVE_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		SLAVE_AXI_ARVALID	: in std_logic;
		SLAVE_AXI_ARREADY	: out std_logic;
		SLAVE_AXI_RDATA	: out std_logic_vector(C_SLAVE_AXI_DATA_WIDTH-1 downto 0);
		SLAVE_AXI_RRESP	: out std_logic_vector(1 downto 0);
		SLAVE_AXI_RVALID	: out std_logic;
		SLAVE_AXI_RREADY	: in std_logic
	);
    end component;

    component ABus2AXI4Lite_Filesys_regs_AXI is
	generic (
		C_FILESYS_AXI_DATA_WIDTH	: integer	:= 32;
		C_FILESYS_AXI_ADDR_WIDTH	: integer	:= 5
	);
	port (
		FILESYS_AXI_ACLK	: in std_logic;
		FILESYS_AXI_ARESETN	: in std_logic;
		FILESYS_AXI_AWADDR	: in std_logic_vector(C_FILESYS_AXI_ADDR_WIDTH-1 downto 0);
		FILESYS_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		FILESYS_AXI_AWVALID	: in std_logic;
		FILESYS_AXI_AWREADY	: out std_logic;
		FILESYS_AXI_WDATA	: in std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
		FILESYS_AXI_WSTRB	: in std_logic_vector((C_FILESYS_AXI_DATA_WIDTH/8)-1 downto 0);
		FILESYS_AXI_WVALID	: in std_logic;
		FILESYS_AXI_WREADY	: out std_logic;
		FILESYS_AXI_BRESP	: out std_logic_vector(1 downto 0);
		FILESYS_AXI_BVALID	: out std_logic;
		FILESYS_AXI_BREADY	: in std_logic;
		FILESYS_AXI_ARADDR	: in std_logic_vector(C_FILESYS_AXI_ADDR_WIDTH-1 downto 0);
		FILESYS_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		FILESYS_AXI_ARVALID	: in std_logic;
		FILESYS_AXI_ARREADY	: out std_logic;
		FILESYS_AXI_RDATA	: out std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
		FILESYS_AXI_RRESP	: out std_logic_vector(1 downto 0);
		FILESYS_AXI_RVALID	: out std_logic;
		FILESYS_AXI_RREADY	: in std_logic
	);
    end component;

    signal PCNTR : std_logic_vector(15 downto 0) := X"0000";
    signal STATUS : std_logic_vector(15 downto 0) := X"0000";
    signal MODE : std_logic_vector(15 downto 0) := X"0000";
    signal HWVER : std_logic_vector(15 downto 0) := X"0100";
    signal SWVER : std_logic_vector(15 downto 0) := X"0000";


begin

--the master interface goes to DDR3 memory
--it needs mode signal to disable reading or writing memory in certain modes
ABus2AXI4Lite_Master_AXI_inst : ABus2AXI4Lite_Master_AXI
	generic map (
		C_MASTER_TARGET_SLAVE_BASE_ADDR	=> C_MASTER_AXI_TARGET_SLAVE_BASE_ADDR,
		C_MASTER_AXI_ADDR_WIDTH	=> C_MASTER_AXI_ADDR_WIDTH,
		C_MASTER_AXI_DATA_WIDTH	=> C_MASTER_AXI_DATA_WIDTH
	)
	port map (
		abus_address	=> abus_address,
		abus_data_in	=> abus_data_in,
		abus_data_out	=> abus_data_out,
		abus_data_direction	=> abus_data_direction,
		abus_chipselect	=> abus_chipselect,
		abus_read	=> abus_read,
		abus_write	=> abus_write,
		abus_wait	=> abus_wait,
		abus_wait_direction	=> abus_wait_direction,
		abus_irq	=> abus_irq,
		abus_irq_direction	=> abus_irq_direction,
		abus_reset => abus_reset,
		MASTER_AXI_ACLK	=> master_axi_aclk,
		MASTER_AXI_ARESETN	=> master_axi_aresetn,
		MASTER_AXI_AWADDR	=> master_axi_awaddr,
		MASTER_AXI_AWPROT	=> master_axi_awprot,
		MASTER_AXI_AWVALID	=> master_axi_awvalid,
		MASTER_AXI_AWREADY	=> master_axi_awready,
		MASTER_AXI_WDATA	=> master_axi_wdata,
		MASTER_AXI_WSTRB	=> master_axi_wstrb,
		MASTER_AXI_WVALID	=> master_axi_wvalid,
		MASTER_AXI_WREADY	=> master_axi_wready,
		MASTER_AXI_BRESP	=> master_axi_bresp,
		MASTER_AXI_BVALID	=> master_axi_bvalid,
		MASTER_AXI_BREADY	=> master_axi_bready,
		MASTER_AXI_ARADDR	=> master_axi_araddr,
		MASTER_AXI_ARPROT	=> master_axi_arprot,
		MASTER_AXI_ARVALID	=> master_axi_arvalid,
		MASTER_AXI_ARREADY	=> master_axi_arready,
		MASTER_AXI_RDATA	=> master_axi_rdata,
		MASTER_AXI_RRESP	=> master_axi_rresp,
		MASTER_AXI_RVALID	=> master_axi_rvalid,
		MASTER_AXI_RREADY	=> master_axi_rready
	);

ABus2AXI4Lite_Slave_AXI_inst : ABus2AXI4Lite_Slave_AXI
	generic map (
		C_SLAVE_AXI_ADDR_WIDTH	=> C_SLAVE_AXI_ADDR_WIDTH,
		C_SLAVE_AXI_DATA_WIDTH	=> C_SLAVE_AXI_DATA_WIDTH
		)
    port map(
        PCNTR => PCNTR,
        STATUS => STATUS,
        MODE => MODE,
        HWVER => HWVER,
        SWVER => SWVER,
		SLAVE_AXI_ACLK => slave_axi_aclk,
		SLAVE_AXI_ARESETN => slave_axi_aresetn,
		SLAVE_AXI_AWADDR => slave_axi_awaddr,
		SLAVE_AXI_AWPROT => slave_axi_awprot,
		SLAVE_AXI_AWVALID => slave_axi_awvalid,
		SLAVE_AXI_AWREADY => slave_axi_awready,
		SLAVE_AXI_WDATA => slave_axi_wdata,
		SLAVE_AXI_WSTRB => slave_axi_wstrb,
		SLAVE_AXI_WVALID => slave_axi_wvalid,
		SLAVE_AXI_WREADY => slave_axi_wready,
		SLAVE_AXI_BRESP => slave_axi_bresp,
		SLAVE_AXI_BVALID => slave_axi_bvalid,
		SLAVE_AXI_BREADY => slave_axi_bready,
		SLAVE_AXI_ARADDR => slave_axi_araddr,
		SLAVE_AXI_ARPROT => slave_axi_arprot,
		SLAVE_AXI_ARVALID => slave_axi_arvalid,
		SLAVE_AXI_ARREADY => slave_axi_arready,
		SLAVE_AXI_RDATA => slave_axi_rdata,
		SLAVE_AXI_RRESP => slave_axi_rresp,
		SLAVE_AXI_RVALID => slave_axi_rvalid,
		SLAVE_AXI_RREADY => slave_axi_rready
	);

--ABus2AXI4Lite_Filesys_AXI_inst : ABus2AXI4Lite_Filesys_regs_AXI
--	generic map (
--		C_FILESYS_AXI_ADDR_WIDTH	=> C_FILESYS_AXI_ADDR_WIDTH,
--		C_FILESYS_AXI_DATA_WIDTH	=> C_FILESYS_AXI_DATA_WIDTH
--		)
--    port map(
--        FILESYS_AXI_ACLK => filesys_axi_aclk,
--		FILESYS_AXI_ARESETN => filesys_axi_aresetn,
--		FILESYS_AXI_AWADDR => filesys_axi_awaddr,
--		FILESYS_AXI_AWPROT => filesys_axi_awprot,
--		FILESYS_AXI_AWVALID => filesys_axi_awvalid,
--		FILESYS_AXI_AWREADY => filesys_axi_awready,
--		FILESYS_AXI_WDATA => filesys_axi_wdata,
--		FILESYS_AXI_WSTRB => filesys_axi_wstrb,
--		FILESYS_AXI_WVALID => filesys_axi_wvalid,
--		FILESYS_AXI_WREADY => filesys_axi_wready,
--		FILESYS_AXI_BRESP => filesys_axi_bresp,
--		FILESYS_AXI_BVALID => filesys_axi_bvalid,
--		FILESYS_AXI_BREADY => filesys_axi_bready,
--		FILESYS_AXI_ARADDR => filesys_axi_araddr,
--		FILESYS_AXI_ARPROT => filesys_axi_arprot,
--		FILESYS_AXI_ARVALID => filesys_axi_arvalid,
--		FILESYS_AXI_ARREADY => filesys_axi_arready,
--		FILESYS_AXI_RDATA => filesys_axi_rdata,
--		FILESYS_AXI_RRESP => filesys_axi_rresp,
--		FILESYS_AXI_RVALID => filesys_axi_rvalid,
--		FILESYS_AXI_RREADY => filesys_axi_rready
--	);
	-- Add user logic here

	-- User logic ends

end arch_imp;
