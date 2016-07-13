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
 * This module reads data to the RS232 UART Port.                             *
 *                                                                            *
 ******************************************************************************/

module altera_up_rs232_in_deserializer (
	// Inputs
	clk,
	reset,
	
	serial_data_in,

	receive_data_en,

	// Bidirectionals

	// Outputs
	fifo_read_available,

	received_data_valid,
	received_data
);

/*****************************************************************************
 *                           Parameter Declarations                          *
 *****************************************************************************/

parameter CW							= 9;		// Baud counter width
parameter BAUD_TICK_COUNT			= 433;
parameter HALF_BAUD_TICK_COUNT	= 216;

parameter TDW							= 11;		// Total data width
parameter DW							= 9;		// Data width

/*****************************************************************************
 *                             Port Declarations                             *
 *****************************************************************************/
// Inputs
input						clk;
input						reset;

input						serial_data_in;

input						receive_data_en;

// Bidirectionals

// Outputs
output reg	[ 7: 0]	fifo_read_available;

output					received_data_valid;
output		[DW: 0]	received_data;

/*****************************************************************************
 *                           Constant Declarations                           *
 *****************************************************************************/

/*****************************************************************************
 *                 Internal Wires and Registers Declarations                 *
 *****************************************************************************/

// Internal Wires
wire						shift_data_reg_en;
wire						all_bits_received;

wire						fifo_is_empty;
wire						fifo_is_full;
wire			[ 6: 0]	fifo_used;

// Internal Registers
reg						receiving_data;

reg		[(TDW-1):0]	data_in_shift_reg;

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
		fifo_read_available <= 8'h00;
	else
		fifo_read_available <= {fifo_is_full, fifo_used};
end

always @(posedge clk)
begin
	if (reset)
		receiving_data <= 1'b0;
	else if (all_bits_received)
		receiving_data <= 1'b0;
	else if (serial_data_in == 1'b0)
		receiving_data <= 1'b1;
end

always @(posedge clk)
begin
	if (reset)
		data_in_shift_reg	<= {TDW{1'b0}};
	else if (shift_data_reg_en)
		data_in_shift_reg	<= 
			{serial_data_in, data_in_shift_reg[(TDW - 1):1]};
end

/*****************************************************************************
 *                            Combinational Logic                            *
 *****************************************************************************/

// Output assignments
assign received_data_valid = ~fifo_is_empty;

// Input assignments


/*****************************************************************************
 *                              Internal Modules                             *
 *****************************************************************************/

altera_up_rs232_counters RS232_In_Counters (
	// Inputs
	.clk								(clk),
	.reset							(reset),
	
	.reset_counters				(~receiving_data),

	// Bidirectionals

	// Outputs
	.baud_clock_rising_edge		(),
	.baud_clock_falling_edge	(shift_data_reg_en),
	.all_bits_transmitted		(all_bits_received)
);
defparam 
	RS232_In_Counters.CW							= CW,
	RS232_In_Counters.BAUD_TICK_COUNT		= BAUD_TICK_COUNT,
	RS232_In_Counters.HALF_BAUD_TICK_COUNT	= HALF_BAUD_TICK_COUNT,
	RS232_In_Counters.TDW						= TDW;

altera_up_sync_fifo RS232_In_FIFO (
	// Inputs
	.clk				(clk),
	.reset			(reset),

	.write_en		(all_bits_received & ~fifo_is_full),
	.write_data		(data_in_shift_reg[(DW + 1):1]),

	.read_en			(receive_data_en & ~fifo_is_empty),
	
	// Bidirectionals

	// Outputs
	.fifo_is_empty	(fifo_is_empty),
	.fifo_is_full	(fifo_is_full),
	.words_used		(fifo_used),

	.read_data		(received_data)
);
defparam 
	RS232_In_FIFO.DW				= DW,
	RS232_In_FIFO.DATA_DEPTH	= 128,
	RS232_In_FIFO.AW				= 6;

endmodule

