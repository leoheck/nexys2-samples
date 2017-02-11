
`default_nettype none
`include "baudgen.vh"

module txchar (
	input wire clk,   //-- System clock
	// input wire rstn,  //-- Reset (active low)
	output wire tx    //-- Serial data output
);

reg rstn;

always @(posedge clk) begin
	rstn <= 1;
end

uart_tx #(.BAUDRATE(`B9600)) TX0 (
	.clk(clk),
	.rstn(rstn),
	.data("A"),    //-- Fixed character to transmit (always the same)
	.start(1'b1),  //-- Start signal always set to 1
	.tx(tx)
);

endmodule