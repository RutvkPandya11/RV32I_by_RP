//Instruction Memory
//The instructions are loaded here, and Program Counter decides
//which instruction to be executed next

module Instruction_Mem( clk, rst, read_address, instruction_out);

    input clk, rst;
    input [31:0] read_address;
    output [31:0] instruction_out;

    reg [31:0] I_Mem[63:0]; //64 memory locations, each 32bits wide which means there can be upto 64 RISCV instructions
    integer k;

    assign instruction_out = I_Mem[read_address]; //// Continuously assign the instruction at the read_address to instruction_out

    always @(posedge clk or posedge rst) begin

    if(rst) begin
        for (k=0; k<64; k++) begin
            I_Mem[k] <= 32'b00;
        end;
    end else begin
        //instruction_out <= I_Mem[read_address];

        //R-type
        I_Mem[0] = 32'b0 ; //No operation
        I_Mem[4] = 32'b0000000_11001_10000_000_01101_0110011; //add x13, x16, x25
        I_Mem[8] = 32'b0100000_00011_01000_000_00101_0110011 ; //sub x5, x8, x3
        I_Mem[12] = 32'b0000000_00011_00010_111_00001_0110011 ; //and x1, x2, x3
        I_Mem[16] = 32'b0000000_00101_00011_110_00100_0110011 ; //or x4,x3,x5

        //I-type
        I_Mem[20] = 32'b000000000011_10101_000_10110_0010011 ; //addi x22, x21, 3
        I_Mem[24] = 32'b000000000001_01000_110_01001_0010011 ; //ori x9, x8, 1

        //I-type load instructions
        I_Mem[28] = 32'b000000001111_00010_010_01000_0000011 ; //lw x8, 15(x2)
        I_Mem[32] = 32'b000000000011_00011_010_01001_0000011 ; //lw x9, 3(x3)

        //S-type
        I_Mem[36] = 32'b0000000_01111_00011_010_01100_0100011 ; //sw x15, 12(x3)
        I_Mem[40] = 32'b0000000_01110_00110_010_01010_0100011 ; //sw x14, 10(x6)

        //SB_type
        I_Mem[44] = 32'h00948663; //beq x9, x9, 12
       
       end
    end

endmodule