// ----------------------------------------------------------------------------
// -- capeta_test.v: CSoC scan chain control and cadence ATPG
// -- All the received characters are echoed
// ----------------------------------------------------------------------------
// -- (C) BQ. Fev 2017. Written by Leandro Heck (leoheck@gmail.com)
// -- GPL license
// ----------------------------------------------------------------------------

`default_nettype none
`include "baudgen.vh"

module capeta_test #(
	parameter BAUDRATE = `B9600
)(
	input  wire clk, // -- System clock

	// UART	
	input  wire rx,  // -- Serial input
	output wire tx,  // -- Serial output

	// DEBUG
	output reg [7:0] leds,  // -- Board leds
	output reg [7:0] sseg,  // -- Board 7Segment Display
	output reg [3:0] an,    // -- 7Segment Display enable

	// CSoC
	input  wire  uart_write,
	output wire  uart_read,
	output wire  reset,
	output wire  test_se,
	output wire  test_tm,
	output wire  clk,
	input  [7:0] data_i,
	output [7:0] data_o,
);

wire rcv;         // -- Received character signal
wire [7:0] data;  // -- Received data
reg rstn = 0;     // -- Reset signal
wire ready;       // -- Transmitter ready signal

// -- Initialization
always @(posedge clk)
	rstn <= 1;

// -- Turn on all the red leds
//assign leds = 4'hF;

// -- Show the 4 less significant bits in the leds
always @(posedge clk)
	leds = data[3:0];

// -- Receiver unit instantation
uart_rx #(.BAUDRATE(BAUDRATE)) RX0 (
	.clk(clk),
	.rstn(rstn),
	.rx(rx),
	.rcv(rcv),
	.data(data)
);

// -- Transmitter unit instantation
uart_tx #(.BAUDRATE(BAUDRATE)) TX0 (
	.clk(clk),
	.rstn(rstn),
	.start(rcv),
	.data(data),
	.tx(tx),
	.ready(ready)
);

// -- Capeta scan chain control
csoc_scanchain_ctrl SCC (
	.clk(clk),
	.rstn(rstn)
);

endmodule