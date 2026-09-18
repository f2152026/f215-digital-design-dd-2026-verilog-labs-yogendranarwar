`timescale 1ns/1ps

module tb;
  reg  [1:0] t_a, t_b;
  wire       t_gt, t_lt, t_eq;

  reg exp_gt, exp_lt, exp_eq;
  integer i, j;
  integer errors = 0;

  // Instantiate DUT
  comp2 DUT (
    .A (t_a),
    .B (t_b),
    .GT(t_gt),
    .LT(t_lt),
    .EQ(t_eq)
  );

  // Waveform dump configuration
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  initial begin
    $display("=== Starting Self-Checking Comparator Test ===");

    for (i = 0; i < 4; i = i + 1) begin
      for (j = 0; j < 4; j = j + 1) begin
        t_a = i[1:0];
        t_b = j[1:0];
        #5;

        // Independent expected output computation
        exp_gt = (t_a > t_b);
        exp_lt = (t_a < t_b);
        exp_eq = (t_a == t_b);

        if ({t_gt, t_lt, t_eq} !== {exp_gt, exp_lt, exp_eq}) begin
          $display("FAIL at time %0t: A=%b B=%b | got GT=%b LT=%b EQ=%b | expected GT=%b LT=%b EQ=%b",
                   $time, t_a, t_b, t_gt, t_lt, t_eq, exp_gt, exp_lt, exp_eq);
          errors = errors + 1;
        end
      end
    end

    $write("TEST RESULTS: ");
    if (errors == 0)
      $display("16/16 combinations PASSED!");
    else
      $display("%0d/16 combinations FAILED.", errors);

    $finish;
  end
endmodule