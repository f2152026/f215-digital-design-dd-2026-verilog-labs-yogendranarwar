 19
Message notifications are off. Turn on8:25 pm8:22 pm98:22 pm128:14 pm4988:09 pm58:04 pm158:00 pm17:56 pm37:53 pm17:53 pm38:07 pm87:23 pm7:03 pm66:52 pm5:35 pm5:05 pm4:57 pm4:36 pm16:04 pm1
Today
// tb.v
// Testbench for Task 2 (LUT ROM with Parameter Override)

module tb;

  // Parameter configuration for override testing
  parameter TEST_WIDTH = 8;
  parameter TEST_DEPTH = 8;

  // TODO: declare the inputs and outputs
  // Address bus needs $clog2(TEST_DEPTH) bits (3 bits for DEPTH=8)
  reg  [$clog2(TEST_DEPTH)-1:0] t_sel;
  wire [TEST_WIDTH-1:0]         t_dout;

  // TODO: instantiate DUT here with Parameter Overrides
  lut #(
    .WIDTH(TEST_WIDTH),
    .DEPTH(TEST_DEPTH)
  ) DUT (
    .sel (t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration (DO NOT CHANGE)
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb); // Updated scope to 'tb' for full wavefor… Read more
8:22 pm
1 unread message
// Self-checking testbench for 2-bit magnitude comparator (comp2)

module tb;

 
  reg  [1:0] t_a;
  reg  [1:0] t_b;
  wire       t_gt;
  wire       t_lt;
  wire       t_eq;

  
  reg exp_gt;
  reg exp_lt;
  reg exp_eq;

  integer i, j;
  integer errors = 0;
  integer total_tests = 0;

  
  comp2 DUT (
    .A  (t_a),
    .B  (t_b),
    .GT (t_gt),
    .LT (t_lt),
    .EQ (t_eq)
  );

  // Waveform dumping setup
  reg [1024*8-1:0] vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

 
  initial begin
    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i;
        t_b = j;
        #5;

        
        exp_gt = (t_a > t_b);
        exp_lt = (t_a < t_b);
        exp_eq = (t_a == t_b);

        total_tests = total_tests + 1;

        
        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b | Got: GT=%b LT=%b EQ=%b | Expected: GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    $write("\n=========================================\n");
    if (errors == 0) begin
      $write("TEST PASSED: %0d / %0d tests passed.\n", total_tests - errors, total_tests);
    end else begin
      $write("TEST FAILED: %0d / %0d tests passed (%0d errors).\n", total_tests - errors, total_tests, errors);
    end
    $write("=========================================\n\n");

    $finish;
  end

endmodule
8:25 pm


