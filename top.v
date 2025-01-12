//Top Module
//PC_top          -> to connect PC output with the PC_Adder and Inst_Memory input and 1st input to the Adder
//instruction_top -> To connect ouput of Instruction Memory with Rs1, Rs2 and Rd viz inputs to the Register file
//                   fun7, fun3 of ALUControl
//                   input ImmGen block  
//RegWrite_top    -> Connects Regwrite of Register file and Control Unit
//ALUOp_top       -> Connects Control Unit and ALU Control Unit
//read_data1_top  -> Connects read_data1 from Reg file with "input A" of ALU Unit
//read_data2_top  -> Connects read_data2 with the ALU Mux "input A" and "Write_data" of Data Memory block
//ImmExt_top      -> Connects ImmExt the output of ImmGen with the "input B" of ALU Mux and also the 2nd input to Adder
//ALU_mux_out     -> Connect ALU mux output with the "input B" of ALU 
//ALUSrc_top      -> Controls the select line of ALU mux with ALUSrc of Control Unit
//ALU_Control_out -> Connects ALU Control's output with "Control_in" of ALU Unit
//branch_top, 
//zero_top        -> Connects the Branch of Control Unit and Zero from ALU unit as the 2 inputs to the AND Gate
//Sum_out         -> Connects output of adder and 2nd input to the mux
//NextoPC_top     -> Connects PC with the 1st input of the mux
//PCin_top        -> Connect Mux output with the input of the program counter
//and_out_top     -> Connects output of AND gate with the select line of the mux
//             in video, above name is replaced with sel2_top
//address_top     -> Connects output of ALU Result with the input to the read address and the 1st input of the last mux
//Memdata_top     -> Connects the output of the Data Memory block with the 2nd input of the last mux
//MemtoReg_top    -> Connects MemtoReg of Control Unit with the select line of the last mux
//MemWrite_top    -> Connects MemWrite of Control Unit with the MemWrite input of Data Memory
//MemRead_top     -> Connects MemRead of Control Unit with the MemRead input of Data Memory
//WriteBack_top   -> COnnected with the output of last MUX and the Writedata signal of Register File

module top(clk, rst);

input clk, rst;

wire [31:0] PC_top, instruction_top, read_data1_top, read_data2_top, ImmExt_top, ALU_mux_out, Sum_out, NextoPC_top, PCin_top, address_top, Memdata_top, WriteBack_top; 
wire RegWrite_top, ALUSrc_top, branch_top, zero_top, MemtoReg_top, MemRead_top, MemWrite_top;
wire [1:0] ALUOp_top;
wire [3:0] ALU_Control_out;

//Program Counter
Program_Counter PC(.clk(clk), .rst(rst), .PC_in(PCin_top), .PC_out(PC_top));

//PC Adder
PCplus4 PC_Adder(.fromPC(PC_top), .NextoPC(NextoPC_top));

//Instruction Memory
Instruction_Mem Inst_Memory( .clk(clk), .rst(rst), .read_address(PC_top), .instruction_out(instruction_top));

//Register File
Reg_File Reg_File(.clk(clk), .rst(rst), .RegWrite(RegWrite_top), .Rs1(instruction_top[19:15]), .Rs2(instruction_top[24:20]), .Rd(instruction_top[11:7]), .Write_data(WriteBack_top), .read_data1(read_data1_top), .read_data2(read_data2_top));

//Immediate Generator
ImmGen ImmGen(.Opcode(instruction_top[6:0]), .instruction(instruction_top), .ImmExt(ImmExt_top));

//Control Unit
Control_Unit Control_Unit(.instruction(instruction_top[6:0]), .Branch(branch_top), .MemRead(MemRead_top), .MemtoReg(MemtoReg_top), .ALUOp(ALUOp_top), .MemWrite(MemWrite_top), .ALUSrc(ALUSrc_top), .RegWrite(RegWrite_top));

//ALU Control
ALU_Control ALU_Control(.ALUOp(ALUOp_top), .fun7(instruction_top[30]), .fun3(instruction_top[14:12]), .Control_out(ALU_Control_out));

//ALU Unit
ALU_unit ALU(.A(read_data1_top), .B(ALU_mux_out), .Control_in(ALU_Control_out), .ALU_Result(address_top), .zero(zero_top));

//ALU Mux
Mux ALU_mux(.sel1(ALUSrc_top), .A1(read_data2_top), .B1(ImmExt_top), .Mux_out(ALU_mux_out));

//Adder
Adder Adder(.in_1(PC_top), .in_2(ImmExt_top), .Sum_out(Sum_out));

//AND Gate
AND_logic AND(.branch(branch_top), .zero(zero_top), .and_out(and_out_top));

//MUX
Mux Adder_mux(.sel1(and_out_top), .A1(NextoPC_top), .B1(Sum_out), .Mux_out(PCin_top));

//Data Memory
Data_Memory Data_mem(.clk(clk), .rst(rst), .MemWrite(MemWrite_top), .MemRead(MemRead_top), .address(address_top), .Write_data(read_data2_top), .MemData_out(Memdata_top));

//MUX
Mux Memory_mux(.sel1(MemtoReg_top), .A1(address_top), .B1(Memdata_top), .Mux_out(WriteBack_top));



endmodule