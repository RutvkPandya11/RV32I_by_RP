//Control Unit
//Determines which control signals to be high and low based on input instruction
module Control_Unit (instruction, Branch, MemRead, MemtoReg, ALUOp, MemWrite, ALUSrc, RegWrite);

input [6:0]instruction;

output reg Branch, MemRead, MemtoReg, MemWrite, ALUSrc, RegWrite;
output reg [1:0] ALUOp;

always @(*) begin

    case(instruction)
    7'b0110011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= 8'b001000_10; // R-type instruction 
    7'b0000011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= 8'b111100_00; // I-type load instruction 
    7'b0010011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= 8'b101000_00; // I-type immediate instruction (e.g., addi) 
    7'b0100011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= 8'b100010_00; // S-type instruction 
    7'b1100011: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= 8'b010001_01; // B-type instruction
    default: {ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp} <= 8'b0;
    endcase
end

endmodule