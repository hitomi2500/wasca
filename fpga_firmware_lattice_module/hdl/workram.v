`include "timescale.v"

module workram_part (dina, write_ena, addra, clka, douta, 
  dinb, write_enb, addrb, clkb, doutb);
  parameter addr_width = 15;
  parameter data_width = 8;
  parameter data_depth = 24576;
  input [addr_width-1:0] addra, addrb;
  input [data_width-1:0] dina, dinb;
  input write_ena, clka, write_enb, clkb;
  output [data_width-1:0] douta, doutb;
  reg [data_width-1:0] douta, doutb;
  reg [data_width-1:0] mem [data_depth-1:0] /* synthesis syn_ramstyle = "no_rw_check" */ ; 
  
  always @(posedge clka) // Using port a.
  begin
    if (write_ena)
      mem[addra] <= dina; // Using address bus a.
    douta <= mem[addra];
  end

  always @(posedge clkb) // Using port b.
  begin
    if (write_enb)
      mem[addrb] <= dinb; // Using address bus b.
    doutb <= mem[addrb];
  end

endmodule


module workram (dina, write_ena, addra, clka, douta, 
  dinb, write_enb, addrb, clkb, doutb);
  parameter addr_width = 15;
  parameter data_width = 32;
  parameter data_depth = 24576;
  input wire [addr_width-1:0] addra, addrb;
  input wire [data_width-1:0] dina, dinb;
  input wire clka, clkb;
  input wire [3:0] write_ena;
  input wire [3:0] write_enb;
  output reg [data_width-1:0] douta, doutb;
  
  /*genvar i;

  for (i = 0; i < 4; i = i + 1)
	workram_part part_n (
	  	.clka(clka),
		.write_ena(write_ena[i]),
		.addra(addra),
		.dina(dina[i*8 +: 8]),
		.douta(douta[i*8 +: 8]),
	  	.clkb(clkb),
		.write_enb(write_enb[i]),
		.addrb(addrb),
		.dinb(dinb[i*8 +: 8]),
		.doutb(doutb[i*8 +: 8])
	);*/
	
  reg [data_width-1:0] mem [data_depth-1:0] /* synthesis syn_ramstyle = "no_rw_check" */ ; 
  initial $readmemh("bootstrap.hex", mem);

  always @(posedge clka) // Using port a.
  begin
    if (write_ena[0]) mem[addra][7:0] <= dina[7:0];
    if (write_ena[1]) mem[addra][15:8] <= dina[15:8];
    if (write_ena[2]) mem[addra][23:16] <= dina[23:16];
    if (write_ena[3]) mem[addra][31:24] <= dina[31:24];
    douta <= mem[addra];
  end

  always @(posedge clkb) // Using port b.
  begin
    if (write_enb[0]) mem[addrb][7:0] <= dinb[7:0];
    if (write_enb[1]) mem[addrb][15:8] <= dinb[15:8];
    if (write_enb[2]) mem[addrb][23:16] <= dinb[23:16];
    if (write_enb[3]) mem[addrb][31:24] <= dinb[31:24];
    doutb <= mem[addrb];
  end
  
  
  //using 16 + 8 dual mem architecture
  
  /*reg [data_width-1:0] mem16 [16384-1:0] /* synthesis syn_ramstyle = "no_rw_check" */ ; 
  /*reg [data_width-1:0] mem8 [4096-1:0] /* synthesis syn_ramstyle = "no_rw_check" */ ; 

  /*always @(posedge clka) // Using port a.
  begin
    if (write_ena[0] && ~addra[14]) mem16[addra[13:0]][7:0] <= dina[7:0];
    if (write_ena[1] && ~addra[14]) mem16[addra[13:0]][15:8] <= dina[15:8];
    if (write_ena[2] && ~addra[14]) mem16[addra[13:0]][23:16] <= dina[23:16];
    if (write_ena[3] && ~addra[14]) mem16[addra[13:0]][31:24] <= dina[31:24];
    if (write_ena[0] && addra[14]) mem8[addra[11:0]][7:0] <= dina[7:0];
    if (write_ena[1] && addra[14]) mem8[addra[11:0]][15:8] <= dina[15:8];
    if (write_ena[2] && addra[14]) mem8[addra[11:0]][23:16] <= dina[23:16];
    if (write_ena[3] && addra[14]) mem8[addra[11:0]][31:24] <= dina[31:24];
    douta <= (addra[14]) ?  mem8[addra[12:0]] : mem16[addra[13:0]];
  end

  always @(posedge clkb) // Using port b.
  begin
    if (write_enb[0] && ~addrb[14]) mem16[addrb[13:0]][7:0] <= dinb[7:0];
    if (write_enb[1] && ~addrb[14]) mem16[addrb[13:0]][15:8] <= dinb[15:8];
    if (write_enb[2] && ~addrb[14]) mem16[addrb[13:0]][23:16] <= dinb[23:16];
    if (write_enb[3] && ~addrb[14]) mem16[addrb[13:0]][31:24] <= dinb[31:24];
    if (write_enb[0] && addrb[14]) mem8[addrb[11:0]][7:0] <= dinb[7:0];
    if (write_enb[1] && addrb[14]) mem8[addrb[11:0]][15:8] <= dinb[15:8];
    if (write_enb[2] && addrb[14]) mem8[addrb[11:0]][23:16] <= dinb[23:16];
    if (write_enb[3] && addrb[14]) mem8[addrb[11:0]][31:24] <= dinb[31:24];
    doutb <= (addrb[14]) ?  mem8[addrb[12:0]] : mem16[addrb[13:0]];
  end*/

endmodule
