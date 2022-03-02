library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity abus_avalon_sdram_bridge_tb is
end abus_avalon_sdram_bridge_tb;

architecture Behavioral of abus_avalon_sdram_bridge_tb is

component abus_avalon_sdram_bridge is
	port (
		clock                : in    std_logic                     := '0';             --         clock.clk
		abus_address         : in    std_logic_vector(24 downto 0) := (others => '0'); --          abus.address
		abus_data     : inout std_logic_vector(15 downto 0) := (others => '0'); --          abus.data
		abus_chipselect      : in    std_logic_vector(2 downto 0)  := (others => '0'); --              .chipselect
		abus_read            : in    std_logic                     := '0';             --              .read
		abus_write           : in    std_logic_vector(1 downto 0)  := (others => '0'); --              .write
		abus_interrupt       : out   std_logic                     := '0';             --              .interrupt
		abus_direction       : out   std_logic                     := '0';             --              .direction
		abus_interrupt_disable_out  	: out   std_logic                     := '0';              --             .disableout

		sdram_addr         : out   std_logic_vector(12 downto 0);                    -- external_sdram_controller_wire.addr
		sdram_ba           : out   std_logic_vector(1 downto 0);                                        --                               .ba
		sdram_cas_n        : out   std_logic;                                        --                               .cas_n
		sdram_cke          : out   std_logic;                                        --                               .cke
		sdram_cs_n         : out   std_logic;                                        --                               .cs_n
		sdram_dq           : inout std_logic_vector(15 downto 0) := (others => '0'); --                               .dq
		sdram_dqm          : out   std_logic_vector(1 downto 0);                     --                               .dqm
		sdram_ras_n        : out   std_logic;                                        --                               .ras_n
		sdram_we_n         : out   std_logic;                                        --                               .we_n
		sdram_clk          : out   std_logic;

		avalon_sdram_read          : in   std_logic := '0';                                        -- avalon_master.read
		avalon_sdram_write         : in   std_logic := '0';                                        --              .write
		avalon_sdram_waitrequest   : out    std_logic                     := '0';             --              .waitrequest
		avalon_sdram_address       : in   std_logic_vector(25 downto 0) := (others => '0');                    --              .address
		avalon_sdram_writedata     : in   std_logic_vector(15 downto 0) := (others => '0');                    --              .writedata
		avalon_sdram_readdata      : out    std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
		avalon_sdram_readdatavalid : out    std_logic                     := '0';             --              .readdatavalid

		avalon_regs_read          : in   std_logic := '0';                                        -- avalon_master.read
		avalon_regs_write         : in   std_logic := '0';                                        --              .write
		avalon_regs_waitrequest   : out    std_logic                     := '0';             --              .waitrequest
		avalon_regs_address       : in   std_logic_vector(7 downto 0) := (others => '0');                    --              .address
		avalon_regs_writedata     : in   std_logic_vector(15 downto 0) := (others => '0');                    --              .writedata
		avalon_regs_readdata      : out    std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
		avalon_regs_readdatavalid : out    std_logic                     := '0';             --              .readdatavalid

		saturn_reset         : in    std_logic                     := '0';             --         	  .saturn_reset
		reset                : in    std_logic                     := '0'              --         reset.reset
	);
end component;

component sdram_controller is
    port(
    -- HOST INTERFACE 
    wr_addr: in   std_logic_vector(23 downto 0);                
    wr_data: in   std_logic_vector(15 downto 0);             
    wr_enable: in   std_logic;             
    rd_addr: in   std_logic_vector(23 downto 0);
    rd_data: out  std_logic_vector(15 downto 0);
    rd_ready: out   std_logic;
    rd_enable: in   std_logic;
    busy: out   std_logic;
    rst_n: in   std_logic;
    clk: in   std_logic;
    -- SDRAM SIDE 
    addr         : out   std_logic_vector(12 downto 0);                    -- external_sdram_controller_wire.addr
	bank_addr           : out   std_logic_vector(1 downto 0);                                        --                               .ba
	cas_n        : out   std_logic;                                        --                               .cas_n
	clock_enable          : out   std_logic;                                        --                               .cke
	cs_n         : out   std_logic;                                        --                               .cs_n
	data           : inout std_logic_vector(15 downto 0) := (others => '0'); --                               .dq
	data_mask_low: out   std_logic;    
	data_mask_high: out   std_logic;    
	ras_n        : out   std_logic;                                        --                               .ras_n
	we_n         : out   std_logic
);
end component;

----------------------ins

signal	clock                :     std_logic                     := '0';             --         clock.clk
signal	abus_address         :     std_logic_vector(24 downto 0) := (others => '0'); --          abus.address
signal	abus_chipselect      :     std_logic_vector(2 downto 0)  := (others => '1'); --              .chipselect
signal	abus_read            :     std_logic                     := '1';             --              .read
signal	abus_write           :     std_logic_vector(1 downto 0)  := (others => '1'); --              .write

signal	avalon_sdram_read          :    std_logic := '0';                                        -- avalon_master.read
signal	avalon_sdram_write         :    std_logic := '0';                                        --              .write
signal	avalon_sdram_address       :    std_logic_vector(25 downto 0) := (others => '0');                    --              .address
signal	avalon_sdram_writedata     :    std_logic_vector(15 downto 0) := (others => '0');                    --              .writedata

signal	avalon_regs_read          :    std_logic := '0';                                        -- avalon_master.read
signal	avalon_regs_write         :    std_logic := '0';                                        --              .write
signal	avalon_regs_address       :    std_logic_vector(7 downto 0) := (others => '0');                    --              .address
signal	avalon_regs_writedata     :    std_logic_vector(15 downto 0) := (others => '0');                    --              .writedata

signal	saturn_reset         :     std_logic                     := '0';             --         	  .saturn_reset
signal	reset                :     std_logic                     := '0';              --         reset.reset

----------------------outs

signal	abus_waitrequest     :    std_logic							  := '1';                                        --              .waitrequest
signal	abus_interrupt       :    std_logic                     := '0';             --              .interrupt
signal	abus_direction       :    std_logic                     := '0';             --              .direction
signal	abus_interrupt_disable_out  	:    std_logic                     := '0';              --             .disableout

signal	sdram_addr         :    std_logic_vector(12 downto 0);                    -- external_sdram_controller_wire.addr
signal	sdram_ba           :    std_logic_vector(1 downto 0);                                        --                               .ba
signal	sdram_cas_n        :    std_logic;                                        --                               .cas_n
signal	sdram_cke          :    std_logic;                                        --                               .cke
signal	sdram_cs_n         :    std_logic;     
signal	sdram_dqm          :    std_logic_vector(1 downto 0);                     --                               .dqm
signal	sdram_ras_n        :    std_logic;                                        --                               .ras_n
signal	sdram_we_n         :    std_logic;                                        --                               .we_n
signal	sdram_clk          :    std_logic;

signal	avalon_sdram_waitrequest   :     std_logic                     := '0';             --              .waitrequest
signal	avalon_sdram_readdata      :     std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
signal	avalon_sdram_readdatavalid :     std_logic                     := '0';             --              .readdatavalid

signal	avalon_regs_waitrequest   :     std_logic                     := '0';             --              .waitrequest
signal	avalon_regs_readdata      :     std_logic_vector(15 downto 0) := (others => '0'); --              .readdata
signal	avalon_regs_readdatavalid :     std_logic                     := '0';             --              .readdatavalid


----------------------inouts

signal	abus_data     : std_logic_vector(15 downto 0) := (others => '0'); --          abus.data
signal	sdram_dq           : std_logic_vector(15 downto 0) := (others => '0'); --                               .dq

signal	abus_full_address     : std_logic_vector(25 downto 0) := (others => '0'); 
signal	abus_data_in    : std_logic_vector(15 downto 0) := (others => '0'); 


------------- reference controller

signal	refer_wr_addr:    std_logic_vector(23 downto 0) := (others => '0');                
signal	refer_wr_data:    std_logic_vector(15 downto 0) := (others => '0');             
signal	refer_wr_enable:    std_logic;             
signal	refer_rd_addr:    std_logic_vector(23 downto 0) := (others => '0');
signal	refer_rd_data:   std_logic_vector(15 downto 0) := (others => '0');
signal	refer_rd_ready:    std_logic;
signal	refer_rd_enable:    std_logic := '0';
signal	refer_busy:    std_logic;
signal	refer_rst_n:   std_logic := '1';



procedure write_abus_16 (addry : in std_logic_vector(25 downto 0);
						  datty : in std_logic_vector(15 downto 0);
						  csy : in std_logic_vector(2 downto 0);
						  wry : in std_logic_vector(1 downto 0);
						  signal Abus_Ad : out std_logic_vector(25 downto 0);
						  signal Abus_Da : out std_logic_vector(15 downto 0);
						  signal Abus_CS : out std_logic_vector(2 downto 0);
						  signal Abus_Wri : out std_logic_vector(1 downto 0);
						  signal Ref_Ad : out std_logic_vector(23 downto 0);
						  signal Ref_Da : out std_logic_vector(15 downto 0);
						  signal Ref_Wri : out std_logic
						  ) is
	begin
			Abus_Ad <= addry;
			Ref_Ad <= addry(24 downto 1);
			Ref_Da <= datty;
			wait for 8620 ps;
			Abus_Da <= datty;
			wait for 8620 ps;
			Abus_CS <= csy;
			wait for 8620 ps;
			Abus_Wri <= wry;
			wait for 4310 ps;
			Ref_Wri <= '1';
			wait for 8620 ps;
			Ref_Wri <= '0';
			wait for 159470 ps;
			Abus_CS <= "111";
			wait for 8620 ps;
			Abus_Wri <= "11";
			wait for 8620 ps;
	end write_abus_16;
	
	procedure read_abus_16 (addry : in std_logic_vector(25 downto 0);
	                        csy : in std_logic_vector(2 downto 0);
						  signal Abus_Ad : out std_logic_vector(25 downto 0);
						  signal Abus_CS : out std_logic_vector(2 downto 0);
						  signal Abus_Re : out std_logic;
						  signal Ref_Ad : out std_logic_vector(23 downto 0);
						  signal Ref_Re : out std_logic
	                        ) is
	begin
			Abus_Ad <= addry;
			Ref_Ad <= addry(24 downto 1);
			Abus_Re <= '0';
			Ref_Re <= '0';
			wait for 8620 ps;
			wait for 8620 ps;
			wait for 8620 ps;
			wait for 8620 ps;
			Abus_CS <= csy;
			wait for 86200 ps;
			wait for 8620 ps;
			wait for 8620 ps;
			Abus_CS <= "111";
			wait for 8620 ps;
			wait for 8620 ps;
			wait for 8620 ps;
			wait for 8620 ps;
			Abus_Re <= '1';
			Ref_Re <= '1';
			wait for 86200 ps;
	end read_abus_16;
	
	procedure write_avalon_16 (addry : in std_logic_vector(25 downto 0);
                              datty : in std_logic_vector(15 downto 0);
                              signal Ava_Ad : out std_logic_vector(24 downto 0);
                              signal Ava_Da : out std_logic_vector(15 downto 0);
                              signal Ava_Wri : out std_logic;
                              signal Ref_Ad : out std_logic_vector(23 downto 0);
                              signal Ref_Da : out std_logic_vector(15 downto 0);
                              signal Ref_Wri : out std_logic
                              ) is
        begin
                Ava_Ad <= addry(24 downto 0);
                Ref_Ad <= addry(24 downto 1);
                Ref_Da <= datty;
                Ava_Da <= datty;
                wait for 8620 ps;
                Ava_Wri <= '1';
                wait for 8620 ps;
                Ref_Wri <= '1';
                Ava_Wri <= '0';
                wait for 8620 ps;
                Ref_Wri <= '0';
        end write_avalon_16;

	procedure write_avalon_16_regs (addry : in std_logic_vector(7 downto 0);
                              datty : in std_logic_vector(15 downto 0);
                              signal Ava_Ad : out std_logic_vector(7 downto 0);
                              signal Ava_Da : out std_logic_vector(15 downto 0);
                              signal Ava_Wri : out std_logic
                              ) is
        begin
                Ava_Ad <= addry;
                Ava_Da <= datty;
                wait for 8620 ps;
                Ava_Wri <= '1';
                wait for 8620 ps;
                Ava_Wri <= '0';
                wait for 8620 ps;
        end write_avalon_16_regs;


	procedure read_avalon_16 (addry : in std_logic_vector(25 downto 0);
                              signal Ava_Ad : out std_logic_vector(24 downto 0);
                              signal Ava_Re : out std_logic;
                              signal Ref_Ad : out std_logic_vector(23 downto 0);
                              signal Ref_Re : out std_logic
                              ) is
        begin
                Ava_Ad <= addry(24 downto 0);
                Ref_Ad <= addry(24 downto 1);
                wait for 8620 ps;
                Ava_Re <= '1';
                wait for 8620 ps;
                Ref_Re <= '1';
                Ava_Re <= '0';
                wait for 8620 ps;
                Ref_Re <= '0';
        end read_avalon_16;

	procedure read_avalon_16_regs (addry : in std_logic_vector(7 downto 0);
                              signal Ava_Ad : out std_logic_vector(7 downto 0);
                              signal Ava_Re : out std_logic
                              ) is
        begin
                Ava_Ad <= addry;
                wait for 8620 ps;
                Ava_Re <= '1';
                wait for 8620 ps;
                Ava_Re <= '0';
                wait for 8620 ps;
        end read_avalon_16_regs;
	
begin

clock <= not clock after 4310 ps; --116 MHz clock

--address/data mux
abus_data <= abus_data_in when abus_direction = '0' else
                    (others => 'Z');

abus_address <= abus_full_address(24 downto 0);

UUT: abus_avalon_sdram_bridge 
	port map(
		clock => clock,
		abus_address => abus_address,
		abus_data => abus_data,
		abus_chipselect => abus_chipselect,
		abus_read => abus_read,
		abus_write => abus_write,
		abus_interrupt => abus_interrupt,
		abus_direction => abus_direction,
		abus_interrupt_disable_out => abus_interrupt_disable_out,
		sdram_addr => sdram_addr,
		sdram_ba => sdram_ba,
		sdram_cas_n => sdram_cas_n,
		sdram_cke => sdram_cke,
		sdram_cs_n => sdram_cs_n,
		sdram_dq => sdram_dq,
		sdram_dqm => sdram_dqm,
		sdram_ras_n => sdram_ras_n,
		sdram_we_n => sdram_we_n,
		sdram_clk => sdram_clk,
		avalon_sdram_read => avalon_sdram_read,
		avalon_sdram_write => avalon_sdram_write,
		avalon_sdram_waitrequest => avalon_sdram_waitrequest,
		avalon_sdram_address => avalon_sdram_address,
		avalon_sdram_writedata => avalon_sdram_writedata,
		avalon_sdram_readdata => avalon_sdram_readdata,
		avalon_sdram_readdatavalid => avalon_sdram_readdatavalid,
		avalon_regs_read => avalon_regs_read,
		avalon_regs_write => avalon_regs_write,
		avalon_regs_waitrequest => avalon_regs_waitrequest,
		avalon_regs_address => avalon_regs_address,
		avalon_regs_writedata => avalon_regs_writedata,
		avalon_regs_readdata => avalon_regs_readdata,
		avalon_regs_readdatavalid => avalon_regs_readdatavalid,
		saturn_reset => saturn_reset,
		reset => reset
	);


--REFER: sdram_controller 
--	port map(
--		clk => clock,
--		rst_n => refer_rst_n,
--		busy => open,
--		wr_addr => refer_wr_addr,
--		wr_data => refer_wr_data,
--		wr_enable => refer_wr_enable,
--		rd_addr => refer_rd_addr,
--		rd_data => refer_rd_data,
--		rd_ready => refer_rd_ready,
--		rd_enable => refer_rd_enable,
--		addr => open,
--		bank_addr => open,
--		cas_n => open,
--		clock_enable => open,
--		cs_n => open,
--		data => open,
--		data_mask_low => open,
--		data_mask_high => open,
--		ras_n => open,
--		we_n => open
--	);

process
begin
    refer_rst_n <= '1';
    wait for 100ns;
    refer_rst_n <= '0';
    wait for 100ns;
    refer_rst_n <= '1';
    wait for 800ns;
    wait for 300us; --sdram init time
    --setup sniff fifo - only writes on cs1
    write_avalon_16_regs(X"E8",X"000A",avalon_regs_address,avalon_regs_writedata,avalon_regs_write); --filter - only write on cs1 
    
    --abus normal read
    read_abus_16("00"&X"EFAFAE","101",abus_full_address,abus_chipselect,abus_read,refer_rd_addr,refer_rd_enable);
    --abus read while autorefresh
    wait for 3150ns;
    read_abus_16("00"&X"EFAFAE","101",abus_full_address,abus_chipselect,abus_read,refer_rd_addr,refer_rd_enable);
    --abus pack write
    for w in 0 to 10 loop
        wait for 10 us;
        write_abus_16(std_logic_vector(to_unsigned(w*512,26)),X"DADA","101","00",abus_full_address,abus_data_in,abus_chipselect,abus_write,refer_wr_addr,refer_wr_data,refer_wr_enable);
    end loop;
    
    wait for 100 us;
    wait for 11 ms;
    
    --avalon normal read
    for w in 0 to 20 loop
        wait for 500 ns;
        read_avalon_16_regs(X"E0",avalon_regs_address,avalon_regs_read);
        wait for 500 ns;
        read_avalon_16_regs(X"EA",avalon_regs_address,avalon_regs_read);
    end loop;
    
    wait;
    
    --pack read fifo
    for w in 0 to 1025 loop
        wait for 1 us;
        read_avalon_16_regs(X"E0",avalon_regs_address,avalon_regs_read);
        --write_avalon_16_regs(X"E6",X"0000",avalon_regs_address,avalon_regs_writedata,avalon_regs_write); --filter - only write on cs1 
    end loop;
    
    wait for 10ms;
    
    --abus pack write
    for w in 0 to 1025 loop
        wait for 10 us;
        write_abus_16(std_logic_vector(to_unsigned(w*512,26)),X"DADA","101","00",abus_full_address,abus_data_in,abus_chipselect,abus_write,refer_wr_addr,refer_wr_data,refer_wr_enable);
    end loop;

    wait for 100 us;
    
    --pack read fifo
    for w in 0 to 1025 loop
        wait for 1 us;
        read_avalon_16_regs(X"E0",avalon_regs_address,avalon_regs_read);
        --write_avalon_16_regs(X"E6",X"0000",avalon_regs_address,avalon_regs_writedata,avalon_regs_write); --filter - only write on cs1 
    end loop;
    

--    --avalon normal write
--    wait for 500ns;
--    write_avalon_16("00"&X"EEE312",X"DADA",avalon_sdram_address,avalon_sdram_writedata,avalon_sdram_write,refer_wr_addr,refer_wr_data,refer_wr_enable);
--    wait for 500ns;
--    --avalon normal read
--    wait for 500ns;
--    read_avalon_16("00"&X"EEE312",avalon_sdram_address,avalon_sdram_read,refer_rd_addr,refer_rd_enable);
--    wait for 500ns;
    wait;
end process;

end Behavioral;
