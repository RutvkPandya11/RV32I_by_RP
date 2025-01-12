//Immediate Generator
//Generates Immediate values used for offset and branching in R, S and SB - type instructions
//Using OpCode bits viz instruction[6:0] and also to 
//determine the type of instruction under execution i.e. I, S, R and SB - type Instruction

module ImmGen(Opcode, instruction, ImmExt);

input [31:0] instruction;
input [6:0] Opcode;
output reg [31:0] ImmExt;

always @(*) begin //Page 362 of pdf file:///C:/Users/rutvi/Downloads/Computer%20Organization%20and%20Design%20RISC-V%20Edition%20%20The%20Hardware%20Software%20Interface%20David%20A%20Patterson,%20John%20L%20Hennessy%20zhelper-search%20(1)%20-%20PDF%20Room.pdf
    case(Opcode)
    
    7'b0000011: ImmExt <= {{20{instruction[31]}}, instruction[31:20]}; // For I-type load instructions 
    7'b0010011: ImmExt <= {{20{instruction[31]}}, instruction[31:20]}; // For I-type immediate instructions (e.g., addi) 
    7'b0100011: ImmExt <= {{20{instruction[31]}}, instruction[31:25], instruction[11:7]}; // For S-type instructions 
    7'b1100011: ImmExt <= {{19{instruction[31]}}, instruction[31], instruction[30:25], instruction[11:8], 1'b0}; // For B-type instructions  
    // 7'b0110011: ImmExt = {{20{instruction[31]}}, };
    
    default: ImmExt <= 32'b0;
    endcase

end
endmodule


