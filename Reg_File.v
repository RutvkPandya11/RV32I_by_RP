//Register File
//Uses two 5bits inputs(Rs1, Rs2) which acts address to access corresponding registers mentioned in the instruction under execution
// Has 2 outputs to support reading 2 registers at once for improved processor performance

module Reg_File (clk, rst, RegWrite, Rs1, Rs2, Rd, Write_data, read_data1, read_data2);

input clk, rst, RegWrite;
input [4:0] Rs1, Rs2, Rd; 
input [31:0] Write_data;
output [31:0] read_data1, read_data2; //2 outputs of 32bits each

reg [31:0] Registers[31:0]; //32 registers, each with 32bits width

initial begin

Registers[0] = 0;
Registers[1] = 4;
Registers[2] = 2;
Registers[3] = 12;
Registers[4] = 4;
Registers[5] = 1;
Registers[6] = 44;
Registers[7] = 4;
Registers[8] = 2;
Registers[9] = 1;
Registers[10] = 23;
Registers[11] = 4;
Registers[12] = 90;
Registers[13] = 10;
Registers[14] = 20;
Registers[15] = 30;
Registers[16] = 40;
Registers[17] = 50;
Registers[18] = 60;
Registers[19] = 70;
Registers[20] = 80;
Registers[21] = 80;
Registers[22] = 90;
Registers[23] = 70;
Registers[24] = 60;
Registers[25] = 65;
Registers[26] = 4;
Registers[27] = 32;
Registers[28] = 12;
Registers[29] = 34;
Registers[30] = 5;
Registers[31] = 10;

end

integer k;

always @(posedge clk or posedge rst) begin

if (rst) begin
    //for(k=0; k<32; k++) begin
        Registers[31] <= 32'b00;

end else if (RegWrite) begin
    Registers[Rd] <= Write_data; //If RegisterWrite is high then Write data to the destination register
    end
end

assign read_data1 = Registers[Rs1];
assign read_data2 = Registers[Rs2];


endmodule