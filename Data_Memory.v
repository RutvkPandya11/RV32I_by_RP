//Data Memory used to store intermediate register values

module Data_Memory(clk, rst, MemWrite, MemRead, address, Write_data, MemData_out);

input clk, rst, MemWrite, MemRead;
input [31:0] address, Write_data;
output [31:0] MemData_out;

reg [31:0] D_Memory [63:0];
integer k;

assign MemData_out = (MemRead) ? D_Memory[address] : 32'b0;

always @(posedge clk) begin
    D_Memory[15] <= 65;
    D_Memory[17] <= 56;
    D_Memory[27] <= 214;
end

always @(posedge clk or posedge rst) begin

if (rst) begin
    for(k=0;k<64;k++) begin
        D_Memory[k] <= 32'b0;
    end
end else if (MemWrite) begin
    D_Memory[address] = Write_data;
end

end

endmodule