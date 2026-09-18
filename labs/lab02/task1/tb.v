// tb.v
// Starter testbench template -- Completed

module tb;

  // Declare DUT inputs as reg types
  reg   t_i0, t_i1, t_s;
  
  // Declare DUT output as wire type
  wire  t_y;

  // Instantiate the DUT wrapper
  DUT uut (
    .I0 (t_i0),
    .I1 (t_i1),
    .S  (t_s),
    .Y  (t_y)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  // Apply all 8 combinations 5 time units apart
  initial begin
    t_s = 0; t_i1 = 0; t_i0 = 0; #5;
    t_s = 0; t_i1 = 0; t_i0 = 1; #5;
    t_s = 0; t_i1 = 1; t_i0 = 0; #5;
    t_s = 0; t_i1 = 1; t_i0 = 1; #5;
    t_s = 1; t_i1 = 0; t_i0 = 0; #5;
    t_s = 1; t_i1 = 0; t_i0 = 1; #5;
    t_s = 1; t_i1 = 1; t_i0 = 0; #5;
    t_s = 1; t_i1 = 1; t_i0 = 1; #5;
    $finish;
  end

  initial
    $monitor($time, " I0=%b I1=%b S=%b | Y=%b", t_i0, t_i1, t_s, t_y);

endmodule