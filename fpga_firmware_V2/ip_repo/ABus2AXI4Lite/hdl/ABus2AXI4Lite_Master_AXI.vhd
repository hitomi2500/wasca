library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ABus2AXI4Lite_Master_AXI is
	generic (
		C_MASTER_TARGET_SLAVE_BASE_ADDR	: std_logic_vector	:= x"40000000";
		C_MASTER_AXI_ADDR_WIDTH	: integer	:= 32;
		C_MASTER_AXI_DATA_WIDTH	: integer	:= 32
	);
	port (
		-- Users to add ports here
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
        -- User ports ends
		-- Do not modify the ports beyond this line

		-- AXI clock signal
		MASTER_AXI_ACLK	: in std_logic;
		-- AXI active low reset signal
		MASTER_AXI_ARESETN	: in std_logic;
		-- Master Interface Write Address Channel ports. Write address (issued by master)
		MASTER_AXI_AWADDR	: out std_logic_vector(C_MASTER_AXI_ADDR_WIDTH-1 downto 0);
		-- Write channel Protection type.
    -- This signal indicates the privilege and security level of the transaction,
    -- and whether the transaction is a data access or an instruction access.
		MASTER_AXI_AWPROT	: out std_logic_vector(2 downto 0);
		-- Write address valid. 
    -- This signal indicates that the master signaling valid write address and control information.
		MASTER_AXI_AWVALID	: out std_logic;
		-- Write address ready. 
    -- This signal indicates that the slave is ready to accept an address and associated control signals.
		MASTER_AXI_AWREADY	: in std_logic;
		-- Master Interface Write Data Channel ports. Write data (issued by master)
		MASTER_AXI_WDATA	: out std_logic_vector(C_MASTER_AXI_DATA_WIDTH-1 downto 0);
		-- Write strobes. 
    -- This signal indicates which byte lanes hold valid data.
    -- There is one write strobe bit for each eight bits of the write data bus.
		MASTER_AXI_WSTRB	: out std_logic_vector(C_MASTER_AXI_DATA_WIDTH/8-1 downto 0);
		-- Write valid. This signal indicates that valid write data and strobes are available.
		MASTER_AXI_WVALID	: out std_logic;
		-- Write ready. This signal indicates that the slave can accept the write data.
		MASTER_AXI_WREADY	: in std_logic;
		-- Master Interface Write Response Channel ports. 
    -- This signal indicates the status of the write transaction.
		MASTER_AXI_BRESP	: in std_logic_vector(1 downto 0);
		-- Write response valid. 
    -- This signal indicates that the channel is signaling a valid write response
		MASTER_AXI_BVALID	: in std_logic;
		-- Response ready. This signal indicates that the master can accept a write response.
		MASTER_AXI_BREADY	: out std_logic;
		-- Master Interface Read Address Channel ports. Read address (issued by master)
		MASTER_AXI_ARADDR	: out std_logic_vector(C_MASTER_AXI_ADDR_WIDTH-1 downto 0);
		-- Protection type. 
    -- This signal indicates the privilege and security level of the transaction, 
    -- and whether the transaction is a data access or an instruction access.
		MASTER_AXI_ARPROT	: out std_logic_vector(2 downto 0);
		-- Read address valid. 
    -- This signal indicates that the channel is signaling valid read address and control information.
		MASTER_AXI_ARVALID	: out std_logic;
		-- Read address ready. 
    -- This signal indicates that the slave is ready to accept an address and associated control signals.
		MASTER_AXI_ARREADY	: in std_logic;
		-- Master Interface Read Data Channel ports. Read data (issued by slave)
		MASTER_AXI_RDATA	: in std_logic_vector(C_MASTER_AXI_DATA_WIDTH-1 downto 0);
		-- Read response. This signal indicates the status of the read transfer.
		MASTER_AXI_RRESP	: in std_logic_vector(1 downto 0);
		-- Read valid. This signal indicates that the channel is signaling the required read data.
		MASTER_AXI_RVALID	: in std_logic;
		-- Read ready. This signal indicates that the master can accept the read data and response information.
		MASTER_AXI_RREADY	: out std_logic
	);
end ABus2AXI4Lite_Master_AXI;

architecture implementation of ABus2AXI4Lite_Master_AXI is

	-- function called clogb2 that returns an integer which has the
	-- value of the ceiling of the log base 2
	function clogb2 (bit_depth : integer) return integer is            
	 	variable depth  : integer := bit_depth;                               
	 	variable count  : integer := 1;                                       
	 begin                                                                   
	 	 for clogb2 in 1 to bit_depth loop  -- Works for up to 32 bit integers
	      if (bit_depth <= 2) then                                           
	        count := 1;                                                      
	      else                                                               
	        if(depth <= 1) then                                              
	 	       count := count;                                                
	 	     else                                                             
	 	       depth := depth / 2;                                            
	          count := count + 1;                                            
	 	     end if;                                                          
	 	   end if;                                                            
	   end loop;                                                             
	   return(count);        	                                              
	 end;                                                                    

	-- AXI4LITE signals
	--write address valid
	signal axi_awvalid	: std_logic:='0';
	--write data valid
	signal axi_wvalid	: std_logic:='0';
	--read address valid
	signal axi_arvalid	: std_logic:='0';
	--read data acceptance
	signal axi_rready	: std_logic:='0';
	--write response acceptance
	signal axi_bready	: std_logic:='0';
	--write address
	signal axi_awaddr	: std_logic_vector(C_MASTER_AXI_ADDR_WIDTH-1 downto 0)  := (others => '0');
	--write data
	signal axi_wdata	: std_logic_vector(C_MASTER_AXI_DATA_WIDTH-1 downto 0)  := (others => '0');
	--read addresss
	signal axi_araddr	: std_logic_vector(C_MASTER_AXI_ADDR_WIDTH-1 downto 0)  := (others => '0');
    --write strobe
    signal axi_wstrb	: std_logic_vector(C_MASTER_AXI_DATA_WIDTH/8-1 downto 0)  := (others => '0');

    signal write_resp_error	: std_logic_vector(2 downto 0) := (others => '0');


    --abus input signals latches are non required,latching is done on upper level
	--signal abus_data_in_p1 : std_logic_vector(15 downto 0) := (others => '0');
	--signal abus_data_in_p2 : std_logic_vector(15 downto 0) := (others => '0');
	signal abus_chipselect_p1 : std_logic_vector(2 downto 0)  := (others => '0'); 
	--signal abus_chipselect_p2 : std_logic_vector(2 downto 0)  := (others => '0'); 
	signal abus_chipselect_pulse : std_logic_vector(2 downto 0)  := (others => '0'); 
	signal abus_chipselect_end_pulse : std_logic_vector(2 downto 0)  := (others => '0'); 
	signal abus_read_p1 : std_logic                     := '0';
	--signal abus_read_p2 : std_logic                     := '0';
	signal abus_read_pulse : std_logic                     := '0';
	signal abus_read_end_pulse : std_logic                     := '0';
	signal abus_write_p1 : std_logic_vector(1 downto 0)  := (others => '0');
	--signal abus_write_p2 : std_logic_vector(1 downto 0)  := (others => '0');
	signal abus_write_pulse : std_logic_vector(1 downto 0)  := (others => '0');
	signal abus_write_end_pulse : std_logic_vector(1 downto 0)  := (others => '0');
	signal abus_reset_p1 : std_logic := '0';
	--signal abus_reset_p2 : std_logic := '0';
	signal abus_reset_pulse : std_logic := '0';

	signal abus_start_pulse : std_logic := '0';
	signal abus_burst_pulse : std_logic := '0';
	signal abus_burst_end_pulse : std_logic := '0';
	signal abus_transaction_active : std_logic := '0';
	signal abus_transaction_write : std_logic := '0';
	signal abus_transaction_read : std_logic := '0';
	
	TYPE write_address_state_type IS (AW_IDLE,AW_WRITE);
    SIGNAL write_address_state : write_address_state_type := AW_IDLE;

	TYPE write_data_state_type IS (W_IDLE,W_WRITE);
    SIGNAL write_data_state : write_data_state_type := W_IDLE;

	TYPE read_address_state_type IS (AR_IDLE,AR_WRITE);
    SIGNAL read_address_state : read_address_state_type := AR_IDLE;

	TYPE read_data_state_type IS (R_IDLE,R_WRITE);
    SIGNAL read_data_state : read_data_state_type := R_IDLE;

	signal abus_write_a1 : std_logic := '0';
	signal abus_read_a1 : std_logic := '0';
	signal abus_read_cache_address : std_logic_vector(23 downto 0)  := (others => '0');
	signal abus_read_cache_data : std_logic_vector(31 downto 0)  := (others => '0');

	signal mode_32M_ROM : std_logic  := '0';
    
    TYPE wasca_mode_type IS (MODE_INIT,
                              MODE_POWER_MEMORY_05M, MODE_POWER_MEMORY_1M, MODE_POWER_MEMORY_2M, MODE_POWER_MEMORY_4M,
                              MODE_RAM_1M, MODE_RAM_4M,
                              MODE_ROM_KOF95,
                              MODE_ROM_ULTRAMAN,
                              MODE_BOOT);
    SIGNAL wasca_mode : wasca_mode_type := MODE_INIT;
    
    TYPE wasca_mem_region_type IS (REGION_ID,REGION_ROM,REGION_RAM,REGION_BOOTCODE,REGION_REGISTERS,REGION_FILESYSTEM);
    SIGNAL wasca_region : wasca_mem_region_type := REGION_BOOTCODE;
    
	signal abus_data_out_regs : std_logic_vector(15 downto 0)  := (others => '0');
	signal abus_data_out_axi : std_logic_vector(15 downto 0)  := (others => '0');
	signal abus_data_out_filesystem : std_logic_vector(15 downto 0)  := (others => '0');
	signal abus_data_out_bootrom : std_logic_vector(15 downto 0)  := (others => '0');
    
	signal abus_data_out_we_regs : std_logic := '0';
    signal abus_data_out_we_axi : std_logic := '0';
    signal abus_data_out_we_filesystem : std_logic := '0';
    signal abus_data_out_we_bootrom : std_logic := '0';
    
    signal REG_PCNTR            : std_logic_vector(15 downto 0) := (others => '0');  
    signal REG_STATUS            : std_logic_vector(15 downto 0) := (others => '0'); 
    signal REG_MODE            : std_logic_vector(15 downto 0) := (others => '0'); 
    signal REG_HWVER            : std_logic_vector(15 downto 0) := X"0002";
    signal REG_SWVER            : std_logic_vector(15 downto 0) := (others => '0'); 


begin
	--some magic - deciding mode from MODE rerister input
	process(MASTER_AXI_ACLK)
    begin
       if (rising_edge (MASTER_AXI_ACLK)) then  
       REG_MODE
       end if;
    end process;	
	
	--Adding the offset address to the base addr of the slave
	MASTER_AXI_AWADDR	<= std_logic_vector (unsigned(C_MASTER_TARGET_SLAVE_BASE_ADDR) + unsigned(axi_awaddr));
	--AXI 4 write data
	MASTER_AXI_WDATA	<= axi_wdata;
	MASTER_AXI_AWPROT	<= "000";
	MASTER_AXI_AWVALID	<= axi_awvalid;
	--Write Data(W)
	MASTER_AXI_WVALID	<= axi_wvalid;
	--Set all byte strobes in this example
	MASTER_AXI_WSTRB	<= axi_wstrb;
	--Write Response (B)
	MASTER_AXI_BREADY	<= axi_bready;
	--Read Address (AR)
	MASTER_AXI_ARADDR	<= std_logic_vector(unsigned(C_MASTER_TARGET_SLAVE_BASE_ADDR) + unsigned(axi_araddr));
	MASTER_AXI_ARVALID	<= axi_arvalid;
	MASTER_AXI_ARPROT	<= "001";
	--Read and Read Response (R)
	MASTER_AXI_RREADY	<= axi_rready;

    --latch abus input signals, pulses are generated on the falling edge
    --abus_data_in_p1 <= abus_data_in when  rising_edge(MASTER_AXI_ACLK);  
    --abus_data_in_p2 <= abus_data_in_p1 when  rising_edge(MASTER_AXI_ACLK);  
    abus_chipselect_p1 <= abus_chipselect when  rising_edge(MASTER_AXI_ACLK);  
    --abus_chipselect_p2 <= abus_chipselect_p1 when  rising_edge(MASTER_AXI_ACLK);
    abus_chipselect_pulse <= abus_chipselect_p1 and not abus_chipselect;
    abus_chipselect_end_pulse <= abus_chipselect and not abus_chipselect_p1;
    abus_read_p1 <= abus_read when  rising_edge(MASTER_AXI_ACLK);  
    --abus_read_p2 <= abus_read_p1 when  rising_edge(MASTER_AXI_ACLK);  
    abus_read_pulse <= abus_read_p1 and not abus_read;
    abus_read_end_pulse <= abus_read and not abus_read_p1;
    abus_write_p1 <= abus_write when  rising_edge(MASTER_AXI_ACLK);  
    --abus_write_p2 <= abus_write_p1 when  rising_edge(MASTER_AXI_ACLK);  
    abus_write_pulse <= abus_write_p1 and not abus_write;
    abus_write_end_pulse <= abus_write and not abus_write_p1;
    abus_reset_p1 <= abus_reset when  rising_edge(MASTER_AXI_ACLK);  
    --abus_reset_p2 <= abus_reset_p1 when  rising_edge(MASTER_AXI_ACLK);  
    abus_reset_pulse <= abus_reset_p1 and not abus_reset;
    
    --transaction state and control signals
    abus_start_pulse <= (not abus_transaction_active) and (abus_read_pulse or abus_write_pulse(0) or abus_write_pulse(1) or abus_chipselect_pulse(0)
                               or abus_chipselect_pulse(1));--  or abus_chipselect_pulse(2) --we don't serve ABus CS2 transactions yet
    abus_burst_pulse <= (abus_transaction_active) and (abus_read_pulse or abus_write_pulse(0) or abus_write_pulse(1) or abus_chipselect_pulse(0)
                               or abus_chipselect_pulse(1)) --  or abus_chipselect_pulse(2) --we don't serve ABus CS2 transactions yet
                               and (abus_transaction_read or abus_transaction_write);
    abus_burst_end_pulse <= ( ((abus_read_end_pulse or abus_write_end_pulse(0) or abus_write_end_pulse(1)) and not 
                                (abus_chipselect_p1(0) and abus_chipselect_p1(1) and abus_chipselect_p1(2)) )
                            or ((abus_chipselect_end_pulse(0) or abus_chipselect_end_pulse(1)) and not(abus_read and abus_write(0) and abus_write(1))) );
                            --  or abus_chipselect_end_pulse(2) --we don't serve ABus CS2 transactions yet
                         
    --detect if current address is applied to registers (not memory)
	process(MASTER_AXI_ACLK)
    begin
       if (rising_edge (MASTER_AXI_ACLK)) then    
           if abus_chipselect_p1(0) = '0' then  
               --cs0 region
               if mode_32M_ROM = '1' then
                    --32M ROM mode, map cs0 completely into ROM space
                    wasca_region <= REGION_ROM;
               else 
                    --other modes
                    if abus_address(25 downto 12) = "11"&X"FFE" then
                        wasca_region <= REGION_FILESYSTEM;
                    elsif abus_address(25 downto 12) = "11"&X"FFF" then
                        wasca_region <= REGION_REGISTERS;
                    elsif abus_address(25 downto 16) = "11"&X"FF" then
                        wasca_region <= REGION_ROM; --this area is reserved, mapping as ROM for now
                    elsif wasca_mode = MODE_RAM_1M or wasca_mode = MODE_RAM_4M then
                        wasca_region <= REGION_RAM; --mapping whole cs0 onto RAM, although only up to 4MB (32MBit) will be used
                    elsif wasca_mode = MODE_INIT then
                       wasca_region <= REGION_BOOTCODE;                   --map all the cs0 range to BRAM with bootcode
                    else
                       wasca_region <= REGION_ROM;                   --everything else is mapped as ROM
                    end if; 
               end if;
           elsif abus_chipselect_p1(1) = '0' then  
               --cs1 region
               if abus_address(25 downto 2) = X"FFFF" then
                    --id register
                    wasca_region <= REGION_ID;
               elsif mode_32M_ROM = '1' then
                    --32M ROM mode, wasca's control is mapped here
                    if abus_address(25 downto 12) = "11"&X"FFE" then
                        wasca_region <= REGION_FILESYSTEM;
                    elsif abus_address(25 downto 12) = "11"&X"FFF" then
                        wasca_region <= REGION_REGISTERS;
                    elsif abus_address(25 downto 16) = "11"&X"FF" then
                        wasca_region <= REGION_ROM; --this area is reserved, mapping as ROM for now
                    end if;
              else
                    wasca_region <= REGION_RAM; --should be used only by power meme emulation
              end if;
           end if;
       end if;                                                                     
    end process;                 
    
	process(MASTER_AXI_ACLK)
	begin
	   if (rising_edge (MASTER_AXI_ACLK)) then    
	       if abus_start_pulse = '1' then  
	           abus_transaction_active <= '1';
	       elsif abus_read_p1 = '1' and abus_write_p1 = "11" and abus_chipselect_p1 = "111" then
	           abus_transaction_active <= '0';	                                                 
           end if;
       end if;                                                                     
    end process;                 
    
	process(MASTER_AXI_ACLK)
    begin
       if (rising_edge (MASTER_AXI_ACLK)) then    
           if abus_read_pulse = '1' then  
               abus_transaction_read <= '1';
           elsif abus_read_p1 = '1' and abus_chipselect_p1 = "111" then
               abus_transaction_read <= '0';                                                     
           end if;
       end if;                                                                     
    end process;                 

	process(MASTER_AXI_ACLK)
    begin
       if (rising_edge (MASTER_AXI_ACLK)) then    
           if abus_write_pulse(0) = '1' or abus_write_pulse(1) = '1' then  
               abus_transaction_write <= '1';
           elsif abus_write_p1 = "11" and abus_chipselect_p1 = "111" then
               abus_transaction_write <= '0';                                                     
           end if;
       end if;                                                                     
    end process;                 

	----------------------
	--Write Address Channel
	----------------------
    --every write access is treated as independent, even within burst
    --for each access we provide new address to axi
    --since axi is 32 bit, and abus is 16 bit, address a1 is latched to provide axi strobe signal 
	process(MASTER_AXI_ACLK)                                                 
	   begin                                                                         
	     if (rising_edge (MASTER_AXI_ACLK)) then                                          
	       if (MASTER_AXI_ARESETN = '0' ) then                                            
	         axi_awvalid <= '0';
	         write_address_state <= AW_IDLE;                                                      
	       else              
	         case write_address_state is
	         when AW_IDLE =>                                               
	           if (abus_write_pulse(0)='1' or abus_write_pulse(1)='1')
	           or (abus_burst_pulse = '1' and abus_transaction_write = '1') then 
	               --axi transactions whould be only issued on RAM and ROM regions
	               if wasca_region = REGION_RAM or wasca_region = REGION_ROM then
                       write_address_state <= AW_WRITE;
                       axi_awvalid <= '1';
                       axi_awaddr <= std_logic_vector(resize(unsigned(abus_address(25 downto 2)&"00"),C_MASTER_AXI_ADDR_WIDTH));
                       abus_write_a1 <= abus_address(1);  
                   end if;                                                        
	           end if;
	         when AW_WRITE =>
	           if MASTER_AXI_AWREADY = '1' then 
	               write_address_state <= AW_IDLE;
                   axi_awvalid <= '0';
               end if;
	         end case;                                                                 
	       end if;                                                                   
	     end if;                                                                     
	end process;                                                                  
                                                                                    
	----------------------
	--Write Data Channel
	----------------------

	--Writes are done independently for every strobe within burst
	--Abus is 16-bit bus with per-byte write latches
	--So we either write 16 of 8 bits onto 32-bit AXI
	--When axi_wvalid arrives, address should be already stable
	--so we can safely assume that abus_registers signal is already multiplexed
	process(MASTER_AXI_ACLK)                                                 
	   begin                                                                         
	     if (rising_edge (MASTER_AXI_ACLK)) then                                          
	       if (MASTER_AXI_ARESETN = '0' ) then                                            
	         axi_wvalid <= '0';
	         write_data_state <= W_IDLE;                                                      
	       else              
	         case write_data_state is
	         when W_IDLE =>                                               
	           if axi_awvalid = '1' then --t's a memory access, not registers 
	               write_data_state <= W_WRITE;
	               axi_wvalid <= '1';
	               axi_wdata <= abus_data_in&abus_data_in;
	               if abus_write_a1='1' then
	                   axi_wstrb <= "00"&not(abus_write_p1(1))&not(abus_write_p1(0));  
	               else                            
	                   axi_wstrb <= not(abus_write_p1(1))&not(abus_write_p1(0))&"00";  
	               end if;
	           end if;
	         when W_WRITE =>
	           if (MASTER_AXI_WREADY = '1' and axi_wvalid = '1') then                    
    	           --Data accepted by interconnect/slave (issue of MASTER_AXI_WREADY by slave)
	               write_data_state <= W_IDLE;
                   axi_wvalid <= '0'; 
	               axi_wstrb <= "0000";                                                   
	         end if;
	         end case;                                                                 
	       end if;                                                                   
	     end if;                                                                     
	end process;                                                                  

	------------------------------
	--Write Response (B) Channel
	------------------------------
    
    --To prevent issuing another write while previous one is not ready, we reset ABUS wait signal only when bresp arrives
	  process(MASTER_AXI_ACLK)                                            
	  begin                                                                
	    if (rising_edge (MASTER_AXI_ACLK)) then                                 
	      if (MASTER_AXI_ARESETN = '0') then                                   
	        axi_bready <= '0';                                             
	      else                                                             
	        if (MASTER_AXI_BVALID = '1' and axi_bready = '0') then              
	          -- accept/acknowledge bresp with axi_bready by the master    
	          -- when MASTER_AXI_BVALID is asserted by slave                    
	           axi_bready <= '1';                                          
	        elsif (axi_bready = '1') then                                  
	          -- deassert after one clock cycle                            
	          axi_bready <= '0'; 
	          write_resp_error <= (axi_bready & MASTER_AXI_BVALID & MASTER_AXI_BRESP(1));                                          
	        end if;                                                        
	      end if;                                                          
	    end if;                                                            
	  end process;                                                         


	------------------------------
	--Read Address Channel
	------------------------------

    --read is a bit tricky
    --to prevent axi over-read we can cache every 32-bit location (further caching is up to axi infrastructure)
    --so basically we remember last accessed 32-bit address, and if if is the same as was before, we do not issue 
    --another read
	process(MASTER_AXI_ACLK)                                                 
	   begin                                                                         
	     if (rising_edge (MASTER_AXI_ACLK)) then                                          
	       if (MASTER_AXI_ARESETN = '0' ) then                                            
	         axi_arvalid <= '0';
	         read_address_state <= AR_IDLE;
	         abus_read_cache_address <= X"FAFAFA";                                                      
	       else              
	         case read_address_state is
	         when AR_IDLE =>                                               
	           if abus_read_pulse='1'
	           or (abus_burst_pulse = '1' and abus_transaction_read = '1') then
	               --axi transactions whould be only issued on RAM and ROM regions
                   if wasca_region = REGION_RAM or wasca_region = REGION_ROM then
                       if ( abus_address(25 downto 2) = abus_read_cache_address) then
                           null; --do nothing on cached access
                       else 
                           read_address_state <= AR_WRITE;
                           axi_arvalid <= '1';
                           axi_araddr <= std_logic_vector(resize(unsigned(abus_address(25 downto 2)&"00"),C_MASTER_AXI_ADDR_WIDTH));
                           abus_read_a1 <= abus_address(1);
                           abus_read_cache_address <= abus_address(25 downto 2);
                       end if;        
                   end if;                                                   
	           end if;
	         when AR_WRITE =>
	           if MASTER_AXI_ARREADY = '1' then 
	               read_address_state <= AR_IDLE;
                   axi_arvalid <= '0';
               end if;
	         end case;                                                                 
	       end if;                                                                   
	     end if;                                                                     
	end process;                                                                  

	----------------------------------
	--Read Data (and Response) Channel
	----------------------------------

	--The Read Data channel returns the results of the read request 
	--The master will accept the read data by asserting axi_rready
	--when there is a valid read data available.
	--While not necessary per spec, it is advisable to reset READY signals in
	--case of differing reset latencies between master/slave.

	  process(MASTER_AXI_ACLK)                                             
	  begin                                                                 
	    if (rising_edge (MASTER_AXI_ACLK)) then                                  
	      if MASTER_AXI_ARESETN = '0' then                                    
	        axi_rready <= '1';                                              
	      else                                                              
	        if (MASTER_AXI_RVALID = '1' and axi_rready = '0') then               
	         -- accept/acknowledge rdata/rresp with axi_rready by the master
	         -- when MASTER_AXI_RVALID is asserted by slave                      
	          axi_rready <= '1';                                            
	        elsif (axi_rready = '1') then
	          abus_read_cache_data <= MASTER_AXI_RDATA;                                   
	          -- deassert after one clock cycle                             
	          axi_rready <= '0';                                            
	        end if;                                                         
	      end if;                                                           
	    end if;                                                             
	  end process;                               
	  
	----------------------------------
    --Registers write
    ----------------------------------
	process(MASTER_AXI_ACLK)                                             
    begin                                                                 
      if (rising_edge (MASTER_AXI_ACLK)) then
        if (abus_write_pulse(0)='1' or abus_write_pulse(1)='1')
        or (abus_burst_pulse = '1' and abus_transaction_write = '1') then 
            if wasca_region = REGION_REGISTERS then
                case abus_address(11 downto 0) is
                when X"FF4" =>
                    REG_MODE <= abus_data_in;
                when others =>
                    null;
                end case;
            end if;                                  
        end if;                                                           
      end if;                                                             
    end process;                               

	----------------------------------
    --Registers read
    ----------------------------------
	process(MASTER_AXI_ACLK)                                             
    begin                                                                 
      if (rising_edge (MASTER_AXI_ACLK)) then
        if abus_read_pulse='1' or (abus_burst_pulse = '1' and abus_transaction_write = '1') then 
            if wasca_region = REGION_REGISTERS then
                case abus_address(11 downto 0) is
                when X"FF0" =>
                    abus_data_out_regs <= REG_PCNTR;
                when X"FF2" =>
                    abus_data_out_regs <= REG_STATUS;
                when X"FF4" =>
                    abus_data_out_regs <= REG_MODE;
                when X"FF6" =>
                    abus_data_out_regs <= REG_HWVER;
                when X"FF8" =>
                    abus_data_out_regs <= REG_SWVER;
                when X"FFA" =>
                    abus_data_out_regs <= X"646f";
                when X"FFC" =>
                    abus_data_out_regs <= X"6F64";
                when X"FFE" =>
                    abus_data_out_regs <= X"6C5C";
                when others =>
                    abus_data_out_regs <= X"DEAF";
                end case;
            end if;                                  
        end if;                                                           
      end if;                                                             
    end process;                               



	  --output cached data to abus according to abus address
      abus_data_out_axi <= abus_read_cache_data(15 downto 0) when abus_address(1) = '1' else
      	               abus_read_cache_data(31 downto 16); 
      	               

	----------------------------------
	--Abus data output enable
	----------------------------------
	process(MASTER_AXI_ACLK)                                             
    begin                                                                 
      if (rising_edge (MASTER_AXI_ACLK)) then                                  
        if MASTER_AXI_ARESETN = '0' then                                    
          abus_data_direction <= '0';                                              
        else
           if abus_read_pulse='1'
           or (abus_burst_pulse = '1' and abus_transaction_read = '1') then
                abus_data_direction <= '1';
           elsif abus_burst_end_pulse = '1' then
                abus_data_direction <= '0';                
           end if;                                                         
        end if;                                                           
      end if;                                                             
    end process;                               
	                                                                        

	----------------------------------
	--Address demux for registers and other splecial locations
    
	----------------------------------

	----------------------------------
	--Boot ROM
	----------------------------------


end implementation;
