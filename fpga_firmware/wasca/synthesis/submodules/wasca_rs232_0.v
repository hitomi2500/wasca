// (C) 2001-2015 Altera Corporation. All rights reserved.
// Your use of Altera Corporation's design tools, logic functions and other 
// software and tools, and its AMPP partner logic functions, and any output 
// files any of the foregoing (including device programming or simulation 
// files), and any associated documentation or information are expressly subject 
// to the terms and conditions of the Altera Program License Subscription 
// Agreement, Altera MegaCore Function License Agreement, or other applicable 
// license agreement, including, without limitation, that your use is for the 
// sole purpose of programming logic devices manufactured by Altera and sold by 
// Altera or its authorized distributors.  Please refer to the applicable 
// agreement for further details.


// THIS FILE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
// THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THIS FILE OR THE USE OR OTHER DEALINGS
// IN THIS FILE.

/******************************************************************************
 *                                                                            *
 * This module reads and writes data to the RS232 connector on Altera's       *
 *  DE-series Development and Education Boards.                               *
 *                                                                            *
 ******************************************************************************/

module wasca_rs232_0 (
	// Inputs
	clk,
	reset,
	
	address,
	chipselect,
	byteenable,
	read,
	write,
	writedata,

	UART_RXD,

	// Bidirectionals

	// Outputs
	irq,
	readdata,

	UART_TXD
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/

parameter CW							= 10;		// Baud counter width
parameter BAUD_TICK_COUNT			= 1006;
parameter HALF_BAUD_TICK_COUNT	= 503;

parameter TDW							= 10;		// Total data width
parameter DW							= 8;		// Data width
parameter ODD_PARITY					= 1'b0;

/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input						clk;
input						reset;

input						address;
input						chipselect;
input			[ 3: 0]	byteenable;
input						read;
input						write;
input			[31: 0]	writedata;

input						UART_RXD;

// Bidirectionals

// Outputs
output reg				irq;
output reg	[31: 0]	readdata;

output					UART_TXD;

/*****************************************************************************
 *                           Constant Declarations                           *
 *****************************************************************************/

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires
wire						read_fifo_read_en;
wire			[ 7: 0]	read_available;
wire						read_data_valid;
wire		[(DW-1):0]	read_data;

wire						parity_error;

wire						write_data_parity;
wire			[ 7: 0]	write_space;

// Internal Registers
reg						read_interrupt_en;
reg						write_interrupt_en;

reg						read_interrupt;
reg						write_interrupt;

reg						write_fifo_write_en;
reg		[(DW-1):0]	data_to_uart;

// State Machine Registers

/*****************************************************************************
 *                         Finite State Machine(s)                           *
 *****************************************************************************/


/*****************************************************************************
 *                             Sequential Logic                              *
 *****************************************************************************/

always @(posedge clk)
begin
	if (reset)
		irq <= 1'b0;
	else
		irq <= write_interrupt | read_interrupt;
end

always @(posedge clk)
begin
	if (reset)
		readdata <= 32'h00000000;
	else if (chipselect)
	begin
		if (address == 1'b0)
			readdata <= 
				{8'h00,
				 read_available,
				 read_data_valid,
				 5'h00,
				 parity_error,
				 1'b0,
				 read_data[(DW - 1):0]};
		else
			readdata <= 
				{8'h00,
				 write_space,
				 6'h00,
				 write_interrupt,
				 read_interrupt,
				 6'h00,
				 write_interrupt_en,
				 read_interrupt_en};
	end
end


always @(posedge clk)
begin
	if (reset)
		read_interrupt_en <= 1'b0;
	else if ((chipselect) && (write) && (address) && (byteenable[0]))
		read_interrupt_en <= writedata[0];
end

always @(posedge clk)
begin
	if (reset)
		write_interrupt_en <= 1'b0;
	else if ((chipselect) && (write) && (address) && (byteenable[0]))
		write_interrupt_en <= writedata[1];
end

always @(posedge clk)
begin
	if (reset)
		read_interrupt <= 1'b0;
	else if (read_interrupt_en == 1'b0)
		read_interrupt <= 1'b0;
	else
		read_interrupt <= (&(read_available[6:5]) | read_available[7]);
end

always @(posedge clk)
begin
	if (reset)
		write_interrupt <= 1'b0;
	else if (write_interrupt_en == 1'b0)
		write_interrupt <= 1'b0;
	else
		write_interrupt <= (&(write_space[6:5]) | write_space[7]);
end


always @(posedge clk)
begin
	if (reset)
		write_fifo_write_en <= 1'b0;
	else
		write_fifo_write_en <= 
			chipselect & write & ~address & byteenable[0];
end

always @(posedge clk)
begin
	if (reset)
		data_to_uart <= 'h0;
	else
		data_to_uart <= writedata[(DW - 1):0];
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

assign parity_error = 1'b0;

assign read_fifo_read_en = chipselect & read & ~address & byteenable[0];

assign write_data_parity = (^(data_to_uart)) ^ ODD_PARITY;

/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

altera_up_rs232_in_deserializer RS232_In_Deserializer (
	// Inputs
	.clk						(clk),
	.reset					(reset),
	
	.serial_data_in		(UART_RXD),

	.receive_data_en		(read_fifo_read_en),

	// Bidirectionals

	// Outputs
	.fifo_read_available	(read_available),

	.received_data_valid	(read_data_valid),
	.received_data			(read_data)
);
defparam 
	RS232_In_Deserializer.CW							= CW,
	RS232_In_Deserializer.BAUD_TICK_COUNT			= BAUD_TICK_COUNT,
	RS232_In_Deserializer.HALF_BAUD_TICK_COUNT	= HALF_BAUD_TICK_COUNT,
	RS232_In_Deserializer.TDW							= TDW,
	RS232_In_Deserializer.DW							= (DW - 1);

altera_up_rs232_out_serializer RS232_Out_Serializer (
	// Inputs
	.clk						(clk),
	.reset					(reset),
	
	.transmit_data			(data_to_uart),
	.transmit_data_en		(write_fifo_write_en),

	// Bidirectionals

	// Outputs
	.fifo_write_space		(write_space),

	.serial_data_out		(UART_TXD)
);
defparam 
	RS232_Out_Serializer.CW							= CW,
	RS232_Out_Serializer.BAUD_TICK_COUNT		= BAUD_TICK_COUNT,
	RS232_Out_Serializer.HALF_BAUD_TICK_COUNT	= HALF_BAUD_TICK_COUNT,
	RS232_Out_Serializer.TDW						= TDW,
	RS232_Out_Serializer.DW							= (DW - 1);

endmodule

