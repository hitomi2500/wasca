`timescale 1ns / 1ps

module sd_fake_rom(
    input clk,
    input [39:0] addr,
    output reg [15:0] dout);
    
   reg [15:0] rom [0:1048575];
   integer i;
      
   initial dout = 0;

   initial $readmemh("bootstrap.hex", rom);
  
   always @(posedge clk)
      dout <= rom[addr[19:0]];

endmodule