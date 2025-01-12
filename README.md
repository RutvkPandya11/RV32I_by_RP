# RV32I_by_RP
Verilog Implementation of RISCV ISA for 32bit (big endian) processor supporting immediate, branch, load and store instructions

Steps:

1) Install Iverilog and GTKwave incase you don't have simulation tools like Xilinx.
2) Download all the files in your system.
3) Open "terminal" at the location where you stored these files.
4) Type "iverilog -o SingleCycle Adder.v ALU_Control.v ALU_unit.v AND_logic.v Control_unit.v Data_Memory.v ImmGen.v Instruction_Mem.v Mux.v PCplus4.v Program_Counter.v Reg_File.v top.v tb_top.v" and hit enter it should compile without any errors.
5) Then type "vvp SingleCycle" and hit enter should run without errors
6) Then finally type "gtkwave waveform.vcd" to see the simulation output.
