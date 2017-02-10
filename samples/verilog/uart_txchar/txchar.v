
`default_nettype none
`include "baudgen.vh"

//-- Top entity
module txchar (
          input wire clk,   //-- System clock
          // input wire rstn,  //-- Reset (active low)
          output wire tx    //-- Serial data output
);

reg rstn;

//-- Initialization
always @(posedge clk)
  rstn <= 1;

//-- Serial Unit instantation
uart_tx #(
    .BAUDRATE(`B9600)  //-- Set the baudrate

  ) TX0 (
    .clk(clk),
    .rstn(rstn),
    .data("A"),    //-- Fixed character to transmit (always the same)
    .start(1'b1),  //-- Start signal always set to 1
    .tx(tx)
);                 //-- Port ready not used


endmodule