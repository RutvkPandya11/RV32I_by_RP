//PC + 4 
//For jumping to next instruction in the instruction memory 
//as in a 32bit processor each instruction is 4bytes wide

module PCplus4(fromPC, NextoPC);

    input [31:0]  fromPC;
    output [31:0] NextoPC;

    assign NextoPC = fromPC + 4;

endmodule