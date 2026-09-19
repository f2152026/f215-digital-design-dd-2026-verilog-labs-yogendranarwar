// comp2.v
// Task 3: 2-bit Magnitude Comparator

module comp2 (
  input  wire [1:0] A,
  input  wire [1:0] B,
  output wire       GT,
  output wire       LT,
  output wire       EQ
);

  // Continuous dataflow comparison logic
  assign GT = (A > B);
  assign LT = (A < B);
  assign EQ = (A == B);

endmodule