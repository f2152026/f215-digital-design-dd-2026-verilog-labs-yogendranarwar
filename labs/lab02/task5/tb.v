`timescale 1ns/1ps

module tb;

  reg  [3:0] t_a;
  reg  [3:0] t_b;
  reg        t_op;
  wire [3:0] t_result;

  reg  [3:0] exp_result;
  integer errors = 0;

  // Instantiate the ALU
  alu DUT (
    .a     (t_a),
    .b     (t_b),
    .op    (t_op),
    .result(t_result)
  );

  // Waveform dump setup for workspace script
  string vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, tb);
    end
  end

  initial begin
    $display("=== Starting ALU Verification ===");

    // -------------------------------------------------------------
    // Test 1: Sensitivity List Bug Check
    // (Hold operands fixed, switch op -- output must respond)
    // -------------------------------------------------------------
    t_a  = 4'd7;
    t_b  = 4'd3;
    t_op = 1'b0; // Add: 7 + 3 = 10
    #5;
    exp_result = 4'd10;
    if (t_result !== exp_result) begin
      $display("FAIL [Add]: op=0 got %0d, expected %0d", t_result, exp_result);
      errors = errors + 1;
    end

    t_op = 1'b1; // Subtract: 7 - 3 = 4 (Tests if op change triggers always block)
    #5;
    exp_result = 4'd4;
    if (t_result !== exp_result) begin
      $display("FAIL [Sub - Sensitivity Bug]: op=1 got %0d, expected %0d", t_result, exp_result);
      errors = errors + 1;
    end

    // -------------------------------------------------------------
    // Test 2: Blocking vs Non-Blocking Bug Check
    // (Tests multi-step subtraction chain)
    // -------------------------------------------------------------
    t_a  = 4'd12;
    t_b  = 4'd5;
    t_op = 1'b1; // Subtract: 12 - 5 = 7
    #5;
    exp_result = 4'd7;
    if (t_result !== exp_result) begin
      $display("FAIL [Sub Chain - Non-blocking Bug]: got %0d, expected %0d", t_result, exp_result);
      errors = errors + 1;
    end

    // Additional subtraction test
    t_a  = 4'd15;
    t_b  = 4'd6;
    t_op = 1'b1; // Subtract: 15 - 6 = 9
    #5;
    exp_result = 4'd9;
    if (t_result !== exp_result) begin
      $display("FAIL [Sub Chain Test 2]: got %0d, expected %0d", t_result, exp_result);
      errors = errors + 1;
    end

    // -------------------------------------------------------------
    // Summary Output
    // -------------------------------------------------------------
    $write("TEST RESULT: ");
    if (errors == 0)
      $display("ALL TESTS PASSED CLEANLY!");
    else
      $display("%0d ERRORS FOUND.", errors);

    $finish;
  end

endmodule