//Legal Notice: (C)2020 Altera Corporation. All rights reserved.  Your
//use of Altera Corporation's design tools, logic functions and other
//software and tools, and its AMPP partner logic functions, and any
//output files any of the foregoing (including device programming or
//simulation files), and any associated documentation or information are
//expressly subject to the terms and conditions of the Altera Program
//License Subscription Agreement or other applicable license agreement,
//including, without limitation, that your use is for the sole purpose
//of programming logic devices manufactured by Altera and sold by Altera
//or its authorized distributors.  Please refer to the applicable
//agreement for further details.

// synthesis translate_off
`timescale 1ns / 1ps
// synthesis translate_on

// turn off superfluous verilog processor warnings 
// altera message_level Level1 
// altera message_off 10034 10035 10036 10037 10230 10240 10030 

//Register map:
//addr      register      type
//0         read data     r
//1         write data    w
//2         status        r/w
//3         control       r/w
//6         end-of-packet-value r/w
//INPUT_CLOCK: 116000000
//ISMASTER: 0
//DATABITS: 8
//TARGETCLOCK: 128000
//NUMSLAVES: 1
//CPOL: 0
//CPHA: 0
//LSBFIRST: 0
//EXTRADELAY: 0
//TARGETSSDELAY: 0

module wasca_spi_stm32 (
                         // inputs:
                          MOSI,
                          SCLK,
                          SS_n,
                          clk,
                          data_from_cpu,
                          mem_addr,
                          read_n,
                          reset_n,
                          spi_select,
                          write_n,

                         // outputs:
                          MISO,
                          data_to_cpu,
                          dataavailable,
                          endofpacket,
                          irq,
                          readyfordata
                       )
;

  output           MISO;
  output  [ 15: 0] data_to_cpu;
  output           dataavailable;
  output           endofpacket;
  output           irq;
  output           readyfordata;
  input            MOSI;
  input            SCLK;
  input            SS_n;
  input            clk;
  input   [ 15: 0] data_from_cpu;
  input   [  2: 0] mem_addr;
  input            read_n;
  input            reset_n;
  input            spi_select;
  input            write_n;

  wire             E;
  reg              EOP;
  wire             MISO;
  reg              MOSI_reg;
  reg              ROE;
  reg              RRDY;
  wire             TMT;
  reg              TOE;
  reg              TRDY;
  wire             control_wr_strobe;
  reg              d1_tx_holding_emptied;
  reg              data_rd_strobe;
  reg     [ 15: 0] data_to_cpu;
  reg              data_wr_strobe;
  wire             dataavailable;
  wire             ds1_SCLK;
  wire             ds1_SS_n;
  reg              ds2_SCLK;
  reg              ds2_SS_n;
  reg              ds3_SS_n;
  wire             ds_MOSI;
  wire             endofpacket;
  reg     [ 15: 0] endofpacketvalue_reg;
  wire             endofpacketvalue_wr_strobe;
  wire             forced_shift;
  reg              iEOP_reg;
  reg              iE_reg;
  reg              iROE_reg;
  reg              iRRDY_reg;
  reg              iTMT_reg;
  reg              iTOE_reg;
  reg              iTRDY_reg;
  wire             irq;
  reg              irq_reg;
  wire             p1_data_rd_strobe;
  wire    [ 15: 0] p1_data_to_cpu;
  wire             p1_data_wr_strobe;
  wire             p1_rd_strobe;
  wire             p1_wr_strobe;
  reg              rd_strobe;
  wire             readyfordata;
  wire             resetShiftSample;
  reg     [  7: 0] rx_holding_reg;
  wire             sample_clock;
  reg              shiftStateZero;
  wire             shift_clock;
  reg     [  7: 0] shift_reg;
  wire    [ 10: 0] spi_control;
  wire    [ 10: 0] spi_status;
  reg     [  3: 0] state;
  wire             status_wr_strobe;
  reg              transactionEnded;
  reg              tx_holding_emptied;
  reg     [  7: 0] tx_holding_reg;
  reg              wr_strobe;
  //spi_control_port, which is an e_avalon_slave
  assign p1_rd_strobe = ~rd_strobe & spi_select & ~read_n;
  // Read is a two-cycle event.
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          rd_strobe <= 0;
      else 
        rd_strobe <= p1_rd_strobe;
    end


  assign p1_data_rd_strobe = p1_rd_strobe & (mem_addr == 0);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_rd_strobe <= 0;
      else 
        data_rd_strobe <= p1_data_rd_strobe;
    end


  assign p1_wr_strobe = ~wr_strobe & spi_select & ~write_n;
  // Write is a two-cycle event.
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          wr_strobe <= 0;
      else 
        wr_strobe <= p1_wr_strobe;
    end


  assign p1_data_wr_strobe = p1_wr_strobe & (mem_addr == 1);
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_wr_strobe <= 0;
      else 
        data_wr_strobe <= p1_data_wr_strobe;
    end


  assign control_wr_strobe = wr_strobe & (mem_addr == 3);
  assign status_wr_strobe = wr_strobe & (mem_addr == 2);
  assign endofpacketvalue_wr_strobe = wr_strobe & (mem_addr == 6);
  assign TMT = SS_n & TRDY;
  assign E = ROE | TOE;
  assign spi_status = {EOP, E, RRDY, TRDY, TMT, TOE, ROE, 3'b0};
  // Streaming data ready for pickup.
  assign dataavailable = RRDY;

  // Ready to accept streaming data.
  assign readyfordata = TRDY;

  // Endofpacket condition detected.
  assign endofpacket = EOP;

  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
        begin
          iEOP_reg <= 0;
          iE_reg <= 0;
          iRRDY_reg <= 0;
          iTRDY_reg <= 0;
          iTMT_reg <= 0;
          iTOE_reg <= 0;
          iROE_reg <= 0;
        end
      else if (control_wr_strobe)
        begin
          iEOP_reg <= data_from_cpu[9];
          iE_reg <= data_from_cpu[8];
          iRRDY_reg <= data_from_cpu[7];
          iTRDY_reg <= data_from_cpu[6];
          iTMT_reg <= data_from_cpu[5];
          iTOE_reg <= data_from_cpu[4];
          iROE_reg <= data_from_cpu[3];
        end
    end


  assign spi_control = {iEOP_reg, iE_reg, iRRDY_reg, iTRDY_reg, 1'b0, iTOE_reg, iROE_reg, 3'b0};
  // IRQ output.
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          irq_reg <= 0;
      else 
        irq_reg <= (EOP & iEOP_reg) | ((TOE | ROE) & iE_reg) | (RRDY & iRRDY_reg) | (TRDY & iTRDY_reg) | (TOE & iTOE_reg) | (ROE & iROE_reg);
    end


  assign irq = irq_reg;
  // End-of-packet value register.
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          endofpacketvalue_reg <= 0;
      else if (endofpacketvalue_wr_strobe)
          endofpacketvalue_reg <= data_from_cpu;
    end


  assign p1_data_to_cpu = ((mem_addr == 2))? spi_status :
    ((mem_addr == 3))? spi_control :
    ((mem_addr == 6))? endofpacketvalue_reg :
    rx_holding_reg;

  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          data_to_cpu <= 0;
      else 
        // Data to cpu.
        data_to_cpu <= p1_data_to_cpu;

    end


  assign forced_shift = ds2_SS_n & ~ds3_SS_n;
  assign ds1_SS_n = SS_n;
  // System clock domain events.
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
        begin
          ds2_SS_n <= 1;
          ds3_SS_n <= 1;
          transactionEnded <= 0;
          EOP <= 0;
          RRDY <= 0;
          TRDY <= 1;
          TOE <= 0;
          ROE <= 0;
          tx_holding_reg <= 0;
          rx_holding_reg <= 0;
          d1_tx_holding_emptied <= 0;
        end
      else 
        begin
          ds2_SS_n <= ds1_SS_n;
          ds3_SS_n <= ds2_SS_n;
          transactionEnded <= forced_shift;
          d1_tx_holding_emptied <= tx_holding_emptied;
          if (tx_holding_emptied & ~d1_tx_holding_emptied)
              TRDY <= 1;
          // EOP must be updated by the last (2nd) cycle of access.
          if ((p1_data_rd_strobe && (rx_holding_reg == endofpacketvalue_reg)) || (p1_data_wr_strobe && (data_from_cpu[7 : 0] == endofpacketvalue_reg)))
              EOP <= 1;
          if (forced_shift)
            begin
              if (RRDY)
                  ROE <= 1;
              else 
                rx_holding_reg <= shift_reg;
              RRDY <= 1;
            end
          // On data read, clear the RRDY bit. 
          if (data_rd_strobe)
              RRDY <= 0;
          // On status write, clear all status bits (ignore the data).
          if (status_wr_strobe)
            begin
              EOP <= 0;
              RRDY <= 0;
              ROE <= 0;
              TOE <= 0;
            end
          // On data write, load the transmit holding register and prepare to execute.
          //Safety feature: if tx_holding_reg is already occupied, ignore this write, and generate
          //the write-overrun error.
          if (data_wr_strobe)
            begin
              if (TRDY)
                  tx_holding_reg <= data_from_cpu;
              if (~TRDY)
                  TOE <= 1;
              TRDY <= 0;
            end
        end
    end


  assign resetShiftSample = ~reset_n | transactionEnded;
  assign MISO = ~SS_n & shift_reg[7];
  assign ds1_SCLK = SCLK;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          ds2_SCLK <= 0;
      else 
        ds2_SCLK <= ds1_SCLK;
    end


  assign shift_clock = ((~ds1_SS_n & ~ds1_SCLK)) & ~((~ds2_SS_n & ~ds2_SCLK));
  assign sample_clock = (~(~ds1_SS_n & ~ds1_SCLK)) & ~(~(~ds2_SS_n & ~ds2_SCLK));
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          state <= 0;
      else 
        state <= resetShiftSample ? 0 : (sample_clock & (state != 8)) ? (state + 1) : state;
    end


  assign ds_MOSI = MOSI;
  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          MOSI_reg <= 0;
      else 
        MOSI_reg <= resetShiftSample ? 0 : sample_clock ? ds_MOSI : MOSI_reg;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          shift_reg <= 0;
      else 
        shift_reg <= resetShiftSample ? 0 : shift_clock ? (shiftStateZero ? tx_holding_reg : {shift_reg[6 : 0], MOSI_reg}) : shift_reg;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          shiftStateZero <= 1;
      else 
        shiftStateZero <= resetShiftSample ? 1 : shift_clock? 0 : shiftStateZero;
    end


  always @(posedge clk or negedge reset_n)
    begin
      if (reset_n == 0)
          tx_holding_emptied <= 0;
      else 
        tx_holding_emptied <= resetShiftSample ? 0 : shift_clock ? (shiftStateZero ? 1 : 0) : tx_holding_emptied;
    end



endmodule

