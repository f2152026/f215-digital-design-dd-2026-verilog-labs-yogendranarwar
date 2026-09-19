module tb;

  // Parameter configuration for override testing
  parameter TEST_WIDTH = 8;
  parameter TEST_DEPTH = 8;
  parameter SEL_WIDTH  = 3; // Replacing $clog2(8) for strict Verilog compatibility

  // Declare inputs and outputs
  reg  [SEL_WIDTH-1:0]  t_sel;
  wire [TEST_WIDTH-1:0] t_dout;

  // Instantiate DUT with Parameter Overrides
  lut #(
    .WIDTH(TEST_WIDTH),
    .DEPTH(TEST_DEPTH)
  ) DUT (
    .sel (t_sel),
    .dout(t_dout)
  );

  // Waveform dump configuration
  reg [1024:0] vcd_file;
  initial begin
    if ($value$plusargs("vcd=%s", vcd_file)) begin
      $dumpfile(vcd_file);
      $dumpvars(0, DUT); 
    end
  end

  integer i;

  initial begin
    for (i = 0; i < TEST_DEPTH; i = i + 1) begin
      t_sel = i;
      #5;
    end
    
    $finish;
  end

  initial
    $monitor($time, " sel=%0d (%b) | dout=%0d", t_sel, t_sel, t_dout);

endmodule