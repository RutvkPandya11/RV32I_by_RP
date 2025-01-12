// ALU Control Unit
//Refer  page 352 of file:///C:/Users/rutvi/Downloads/Computer%20Organization%20and%20Design%20RISC-V%20Edition%20%20The%20Hardware%20Software%20Interface%20David%20A%20Patterson,%20John%20L%20Hennessy%20zhelper-search%20(1)%20-%20PDF%20Room.pdf

module ALU_Control (ALUOp, fun7, fun3, Control_out);

input [1:0] ALUOp;
input fun7; //mapped with instruction[30]
input [2:0] fun3;
output reg [3:0] Control_out;

always@(*) begin

    casex({ALUOp, fun7, fun3})
    6'b00_0_000: Control_out <= 4'b0010; // Addition in ALU for Opcode "lw" or "sw" i.e. in I-type & S-type instruction formats respectively 
    6'b00_0_010: Control_out <= 4'b0010; // Added condition by me to run lw x8, 15(x2) type of instructions 
    6'b00_x_110: Control_out <= 4'b0001; // OR immediate for I-type instruction (e.g., ori) 
    //6'b00_1_110: Control_out <= 4'b0001; // OR immediate for I-type instruction (e.g., ori) 
    6'b00_0_111: Control_out <= 4'b0000; // AND immediate for I-type instruction (e.g., andi) 
    6'b00_1_000: Control_out <= 4'b0110; // Subtract immediate for I-type instruction (e.g., subi) 
    6'b01_0_000: Control_out <= 4'b0110; // Subtraction for Opcode "beq" i.e. branch when equal 
    6'b10_0_000: Control_out <= 4'b0010; // Addition for R-type instruction 
    6'b10_1_000: Control_out <= 4'b0110; // Subtraction for R-type instruction 
    6'b10_0_111: Control_out <= 4'b0000; // AND operation 
    6'b10_0_110: Control_out <= 4'b0001; // OR operation
    default: Control_out <= 4'b1111;
    endcase
end

endmodule
