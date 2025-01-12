//2x1 Multiplexers

module Mux(sel1, A1, B1, Mux_out);

input sel1;
input [31:0] A1, B1;
output [31:0] Mux_out;

assign Mux_out = (sel1 == 1'b0) ? A1 : B1;

endmodule