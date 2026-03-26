`timescale 1ns / 1ps

module sd_fake_rom(
    input clk,
    input [39:0] addr,
    output reg [15:0] dout);
    
   reg [15:0] rom [0:1048575];
   integer i;
      
   initial dout = 0;

   //initial $readmemh("D:/Saturn/Wasca/vivado/lattice_sim/hdl/bootstrap.hex", rom);
    initial begin
        for (i = 0; i < 1048575; i = i + 1) begin
            rom[i] = 0;
        end
    end
  
   always @(posedge clk)
      dout <= rom[addr[19:0]];

endmodule