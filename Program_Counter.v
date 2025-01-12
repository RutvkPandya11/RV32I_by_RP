//Program Counter for a 32bit Processor i.e. 4bytes

module Program_Counter (clk, rst, PC_in, PC_out);

input             clk, rst;
input [31:0]      PC_in; // 32bit is the width of each instruction
output reg [31:0] PC_out;

always @(posedge clk or posedge rst)begin
    if (rst) begin
    PC_out <= 32'b00;
    end else begin
    PC_out <= PC_in;
    end
    end
endmodule