//Testbench

module tp_top;

reg clk, rst;

// Instantiate the top module
top uut (
  .clk(clk),
  .rst(rst)
);

initial begin
  // Initialize signals
  clk = 0;
  rst = 1;

  // Release reset after 5 time units
  #5 rst = 0;

  // Run simulation for 400 time units
  #400;

  // End simulation
  $finish;
end

// Clock generation
always begin
  #5 clk = ~clk;
end

// Generate waveform file for GTKWave
initial begin
  $dumpfile("waveform.vcd");
  $dumpvars(0, tp_top);
end

endmodule
