library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ABus2AXI4Lite_Filesys_regs_AXI is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of S_AXI data bus
		C_FILESYS_AXI_DATA_WIDTH	: integer	:= 32;
		-- Width of S_AXI address bus
		C_FILESYS_AXI_ADDR_WIDTH	: integer	:= 12
	);
	port (
		-- Users to add ports here
        abus_we : in std_logic_vector(1 downto 0);
        abus_we_cmd : in std_logic_vector(1 downto 0);
        abus_we_data : in std_logic_vector(1 downto 0);
        abus_we_regs : in std_logic_vector(1 downto 0);
        abus_addr : in std_logic_vector(12 downto 0);
        abus_data_in : in std_logic_vector(15 downto 0);
        abus_data_out : out std_logic_vector(15 downto 0);
        abus_data_out_data : out std_logic_vector(15 downto 0);
        abus_data_out_cmd : out std_logic_vector(15 downto 0);
        abus_data_out_regs : out std_logic_vector(15 downto 0);

		-- User ports ends
		-- Do not modify the ports beyond this line

		-- Global Clock Signal
		FILESYS_AXI_ACLK	: in std_logic;
		-- Global Reset Signal. This Signal is Active LOW
		FILESYS_AXI_ARESETN	: in std_logic;
		-- Write address (issued by master, acceped by Slave)
		FILESYS_AXI_AWADDR	: in std_logic_vector(C_FILESYS_AXI_ADDR_WIDTH-1 downto 0);
		-- Write channel Protection type. This signal indicates the
    		-- privilege and security level of the transaction, and whether
    		-- the transaction is a data access or an instruction access.
		FILESYS_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		-- Write address valid. This signal indicates that the master signaling
    		-- valid write address and control information.
		FILESYS_AXI_AWVALID	: in std_logic;
		-- Write address ready. This signal indicates that the slave is ready
    		-- to accept an address and associated control signals.
		FILESYS_AXI_AWREADY	: out std_logic;
		-- Write data (issued by master, acceped by Slave) 
		FILESYS_AXI_WDATA	: in std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
		-- Write strobes. This signal indicates which byte lanes hold
    		-- valid data. There is one write strobe bit for each eight
    		-- bits of the write data bus.    
		FILESYS_AXI_WSTRB	: in std_logic_vector((C_FILESYS_AXI_DATA_WIDTH/8)-1 downto 0);
		-- Write valid. This signal indicates that valid write
    		-- data and strobes are available.
		FILESYS_AXI_WVALID	: in std_logic;
		-- Write ready. This signal indicates that the slave
    		-- can accept the write data.
		FILESYS_AXI_WREADY	: out std_logic;
		-- Write response. This signal indicates the status
    		-- of the write transaction.
		FILESYS_AXI_BRESP	: out std_logic_vector(1 downto 0);
		-- Write response valid. This signal indicates that the channel
    		-- is signaling a valid write response.
		FILESYS_AXI_BVALID	: out std_logic;
		-- Response ready. This signal indicates that the master
    		-- can accept a write response.
		FILESYS_AXI_BREADY	: in std_logic;
		-- Read address (issued by master, acceped by Slave)
		FILESYS_AXI_ARADDR	: in std_logic_vector(C_FILESYS_AXI_ADDR_WIDTH-1 downto 0);
		-- Protection type. This signal indicates the privilege
    		-- and security level of the transaction, and whether the
    		-- transaction is a data access or an instruction access.
		FILESYS_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		-- Read address valid. This signal indicates that the channel
    		-- is signaling valid read address and control information.
		FILESYS_AXI_ARVALID	: in std_logic;
		-- Read address ready. This signal indicates that the slave is
    		-- ready to accept an address and associated control signals.
		FILESYS_AXI_ARREADY	: out std_logic;
		-- Read data (issued by slave)
		FILESYS_AXI_RDATA	: out std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
		-- Read response. This signal indicates the status of the
    		-- read transfer.
		FILESYS_AXI_RRESP	: out std_logic_vector(1 downto 0);
		-- Read valid. This signal indicates that the channel is
    		-- signaling the required read data.
		FILESYS_AXI_RVALID	: out std_logic;
		-- Read ready. This signal indicates that the master can
    		-- accept the read data and response information.
		FILESYS_AXI_RREADY	: in std_logic
	);
end ABus2AXI4Lite_Filesys_regs_AXI;

architecture arch_imp of ABus2AXI4Lite_Filesys_regs_AXI is

    component buffer_mem IS
      PORT (
        clka : IN STD_LOGIC;
        ena : IN STD_LOGIC;
        wea : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        addra : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
        dina : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        douta : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        clkb : IN STD_LOGIC;
        enb : IN STD_LOGIC;
        web : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        addrb : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
        dinb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
      );
    END component;

	-- AXI4LITE signals
	signal axi_addr	: std_logic_vector(C_FILESYS_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_awready	: std_logic;
	signal axi_wready	: std_logic;
	signal axi_bresp	: std_logic_vector(1 downto 0);
	signal axi_bvalid	: std_logic;
	signal axi_arready	: std_logic;
	signal axi_rdata	: std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
	signal axi_rresp	: std_logic_vector(1 downto 0);
	signal axi_rvalid	: std_logic;

	-- Example-specific design signals
	-- local parameter for addressing 32 bit / 64 bit C_FILESYS_AXI_DATA_WIDTH
	-- ADDR_LSB is used for addressing 32/64 bit registers/memories
	-- ADDR_LSB = 2 for 32 bits (n downto 2)
	-- ADDR_LSB = 3 for 64 bits (n downto 3)
	constant ADDR_LSB  : integer := (C_FILESYS_AXI_DATA_WIDTH/32)+ 1;
	------------------------------------------------
	---- Signals for user logic register space example
	--------------------------------------------------
	---- Number of Slave Registers 8
	signal slv_reg0	:std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
	signal slv_reg1	:std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
	signal slv_rden	: std_logic;
	signal slv_wren	: std_logic;
	signal reg_data_out	:std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
	signal byte_index	: integer;
	
	signal axi_data_out_data	:std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
    signal axi_data_out_cmd    :std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
--    signal command_buffer_in    :std_logic_vector(C_FILESYS_AXI_DATA_WIDTH-1 downto 0);
    --signal command_buffer_addr    :std_logic_vector(9 downto 0);
    --signal data_buffer_addr    :std_logic_vector(9 downto 0);
	signal axi_we_data	:std_logic_vector((C_FILESYS_AXI_DATA_WIDTH/8)-1 downto 0);
    signal axi_we_cmd    :std_logic_vector((C_FILESYS_AXI_DATA_WIDTH/8)-1 downto 0);

begin
	-- I/O Connections assignments

	FILESYS_AXI_AWREADY	<= axi_awready;
	FILESYS_AXI_WREADY	<= axi_wready;
	FILESYS_AXI_BRESP	<= axi_bresp;
	FILESYS_AXI_BVALID	<= axi_bvalid;
	FILESYS_AXI_ARREADY	<= axi_arready;
	FILESYS_AXI_RDATA	<= axi_rdata;
	FILESYS_AXI_RRESP	<= axi_rresp;
	FILESYS_AXI_RVALID	<= axi_rvalid;
	-- Implement axi_awready generation
	-- axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	-- de-asserted when reset is low.

	process (FILESYS_AXI_ACLK)
	begin
	  if rising_edge(FILESYS_AXI_ACLK) then 
	    if FILESYS_AXI_ARESETN = '0' then
	      axi_awready <= '0';
	    else
	      if (axi_awready = '0' and FILESYS_AXI_AWVALID = '1' and FILESYS_AXI_WVALID = '1') then
	        -- slave is ready to accept write address when
	        -- there is a valid write address and write data
	        -- on the write address and data bus. This design 
	        -- expects no outstanding transactions. 
	        axi_awready <= '1';
	      else
	        axi_awready <= '0';
	      end if;
	    end if;
	  end if;
	end process;

	-- Implement axi_awaddr latching
	-- This process is used to latch the address when both 
	-- S_AXI_AWVALID and S_AXI_WVALID are valid. 

	process (FILESYS_AXI_ACLK)
	begin
	  if rising_edge(FILESYS_AXI_ACLK) then 
	    if FILESYS_AXI_ARESETN = '0' then
	      axi_addr <= (others => '0');
	    else
	      if (axi_awready = '0' and FILESYS_AXI_AWVALID = '1' and FILESYS_AXI_WVALID = '1') then
	        -- Write Address latching
	        axi_addr <= FILESYS_AXI_AWADDR;
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_wready generation
	-- axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	-- de-asserted when reset is low. 

	process (FILESYS_AXI_ACLK)
	begin
	  if rising_edge(FILESYS_AXI_ACLK) then 
	    if FILESYS_AXI_ARESETN = '0' then
	      axi_wready <= '0';
	    else
	      if (axi_wready = '0' and FILESYS_AXI_WVALID = '1' and FILESYS_AXI_AWVALID = '1') then
	          -- slave is ready to accept write data when 
	          -- there is a valid write address and write data
	          -- on the write address and data bus. This design 
	          -- expects no outstanding transactions.           
	          axi_wready <= '1';
	      else
	        axi_wready <= '0';
	      end if;
	    end if;
	  end if;
	end process; 

	-- Implement memory mapped register select and write logic generation
	-- The write data is accepted and written to memory mapped registers when
	-- axi_awready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted. Write strobes are used to
	-- select byte enables of slave registers while writing.
	-- These registers are cleared when reset (active low) is applied.
	-- Slave register write enable is asserted when valid address and data are available
	-- and the slave is ready to accept the write address and write data.
	slv_wren <= axi_wready and FILESYS_AXI_WVALID and axi_awready and FILESYS_AXI_AWVALID ;

	process (FILESYS_AXI_ACLK)
	variable reg_addr :std_logic_vector(2 downto 0); 
	begin
	  if rising_edge(FILESYS_AXI_ACLK) then 
	    if FILESYS_AXI_ARESETN = '0' then
	      slv_reg0 <= (others => '0');
	      slv_reg1 <= (others => '0');
	    else
	      reg_addr := axi_addr(ADDR_LSB + 2 downto ADDR_LSB);
	      axi_we_data <= (others=>'0');
	      axi_we_cmd <= (others=>'0');
	      if (slv_wren = '1') then
	        if axi_addr(C_FILESYS_AXI_ADDR_WIDTH-1) = '0' then --data buffer
	           axi_we_data <= FILESYS_AXI_WSTRB;
	        elsif axi_addr(C_FILESYS_AXI_ADDR_WIDTH-1 downto C_FILESYS_AXI_ADDR_WIDTH-9) = X"FF" then --registers
                case reg_addr is
                  --only reg0 is writable
                  when b"000" =>
                    for byte_index in 0 to (C_FILESYS_AXI_DATA_WIDTH/8-1) loop
                      if ( FILESYS_AXI_WSTRB(byte_index) = '1' ) then
                        -- Respective byte enables are asserted as per write strobes                   
                        -- slave registor 0
                        slv_reg0(byte_index*8+7 downto byte_index*8) <= FILESYS_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                      end if;
                    end loop;
                  when others => null;
                end case;
             else
	           axi_we_cmd <= FILESYS_AXI_WSTRB;
	         end if;
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement write response logic generation
	-- The write response and response valid signals are asserted by the slave 
	-- when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	-- This marks the acceptance of address and indicates the status of 
	-- write transaction.

	process (FILESYS_AXI_ACLK)
	begin
	  if rising_edge(FILESYS_AXI_ACLK) then 
	    if FILESYS_AXI_ARESETN = '0' then
	      axi_bvalid  <= '0';
	      axi_bresp   <= "00"; --need to work more on the responses
	    else
	      if (axi_awready = '1' and FILESYS_AXI_AWVALID = '1' and axi_wready = '1' and FILESYS_AXI_WVALID = '1' and axi_bvalid = '0'  ) then
	        axi_bvalid <= '1';
	        axi_bresp  <= "00"; 
	      elsif (FILESYS_AXI_BREADY = '1' and axi_bvalid = '1') then   --check if bready is asserted while bvalid is high)
	        axi_bvalid <= '0';                                 -- (there is a possibility that bready is always asserted high)
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arready generation
	-- axi_arready is asserted for one S_AXI_ACLK clock cycle when
	-- S_AXI_ARVALID is asserted. axi_awready is 
	-- de-asserted when reset (active low) is asserted. 
	-- The read address is also latched when S_AXI_ARVALID is 
	-- asserted. axi_araddr is reset to zero on reset assertion.

	process (FILESYS_AXI_ACLK)
	begin
	  if rising_edge(FILESYS_AXI_ACLK) then 
	    if FILESYS_AXI_ARESETN = '0' then
	      axi_arready <= '0';
	      axi_addr  <= (others => '1');
	    else
	      if (axi_arready = '0' and FILESYS_AXI_ARVALID = '1') then
	        -- indicates that the slave has acceped the valid read address
	        axi_arready <= '1';
	        -- Read Address latching 
	        axi_addr  <= FILESYS_AXI_ARADDR;           
	      else
	        axi_arready <= '0';
	      end if;
	    end if;
	  end if;                   
	end process; 

	-- Implement axi_arvalid generation
	-- axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	-- S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	-- data are available on the axi_rdata bus at this instance. The 
	-- assertion of axi_rvalid marks the validity of read data on the 
	-- bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	-- is deasserted on reset (active low). axi_rresp and axi_rdata are 
	-- cleared to zero on reset (active low).  
	process (FILESYS_AXI_ACLK)
	begin
	  if rising_edge(FILESYS_AXI_ACLK) then
	    if FILESYS_AXI_ARESETN = '0' then
	      axi_rvalid <= '0';
	      axi_rresp  <= "00";
	    else
	      if (axi_arready = '1' and FILESYS_AXI_ARVALID = '1' and axi_rvalid = '0') then
	        -- Valid read data is available at the read data bus
	        axi_rvalid <= '1';
	        axi_rresp  <= "00"; -- 'OKAY' response
	      elsif (axi_rvalid = '1' and FILESYS_AXI_RREADY = '1') then
	        -- Read data is accepted by the master
	        axi_rvalid <= '0';
	      end if;            
	    end if;
	  end if;
	end process;

	-- Implement memory mapped register select and read logic generation
	-- Slave register read enable is asserted when valid address is available
	-- and the slave is ready to accept the read address.
	slv_rden <= axi_arready and FILESYS_AXI_ARVALID and (not axi_rvalid) ;

	process (slv_reg0, slv_reg1, axi_addr, FILESYS_AXI_ARESETN, slv_rden)
	variable reg_addr :std_logic_vector(2 downto 0);
	begin
	    -- Address decoding for reading registers
	    reg_addr := axi_addr(ADDR_LSB + 2 downto ADDR_LSB);
	    if axi_addr(C_FILESYS_AXI_ADDR_WIDTH-1) = '0' then--data buffer
	       reg_data_out <= axi_data_out_data;
	    elsif axi_addr(C_FILESYS_AXI_ADDR_WIDTH-1 downto C_FILESYS_AXI_ADDR_WIDTH-9) = X"FF" then--registers
            case reg_addr is
              when b"000" =>
                reg_data_out <= slv_reg0;
              when b"001" =>
                reg_data_out <= slv_reg1;
              when others =>
                reg_data_out  <= (others => '0');
            end case;
        else --command buffer
	       reg_data_out <= axi_data_out_cmd;
        end if;
	end process; 

    axi_we_cmd <= FILESYS_AXI_WSTRB when slv_wren = '1' and axi_addr(C_FILESYS_AXI_ADDR_WIDTH-1) = '1' 
                                                       and axi_addr(C_FILESYS_AXI_ADDR_WIDTH-1 downto C_FILESYS_AXI_ADDR_WIDTH-9) /= X"FF"
                 else (others => '0');

	-- Output register or memory read data
	process( FILESYS_AXI_ACLK ) is
	begin
	  if (rising_edge (FILESYS_AXI_ACLK)) then
	    if ( FILESYS_AXI_ARESETN = '0' ) then
	      axi_rdata  <= (others => '0');
	    else
	      if (slv_rden = '1') then
	        -- When there is a valid read address (S_AXI_ARVALID) with 
	        -- acceptance of read address by the slave (axi_arready), 
	        -- output the read dada 
	        -- Read address mux
	          axi_rdata <= reg_data_out;     -- register read data
	      end if;   
	    end if;
	  end if;
	end process;

--command_buffer_addr <= axi_addr(ADDR_LSB+9 downto ADDR_LSB);

    command_buffer: buffer_mem
      PORT map(
        --ABus port
        clka => FILESYS_AXI_ACLK,
        ena => '1',
        wea => abus_we_cmd,
        addra => abus_addr(10 downto 1),
        dina => abus_data_in,
        douta => abus_data_out_cmd,
        --axi port
        clkb => FILESYS_AXI_ACLK,
        enb => '1',
        web => axi_we_cmd,
        addrb => axi_addr(ADDR_LSB+9 downto ADDR_LSB),
        dinb => FILESYS_AXI_WDATA,
        doutb => axi_data_out_cmd
      );

--data_buffer_addr <= axi_addr(ADDR_LSB+9 downto ADDR_LSB);

    data_buffer: buffer_mem
      PORT map(
        --ABus port
        clka => FILESYS_AXI_ACLK,
        ena => '1',
        wea => abus_we_data,
        addra => abus_addr(10 downto 1),
        dina => abus_data_in,
        douta => abus_data_out_data,
        --axi port
        clkb => FILESYS_AXI_ACLK,
        enb => '1',
        web => axi_we_data,
        addrb => axi_addr(ADDR_LSB+9 downto ADDR_LSB),
        dinb => FILESYS_AXI_WDATA,
        doutb => axi_data_out_data
      );


end arch_imp;
