// mux_df.v
// 2-to-1 multiplexer, DATAFLOW style.
//
// This file does not compile as-is. Find the bug and fix it before moving on.
// Hint: think carefully about which port should be a net and which should be
// a variable in dataflow modeling.

module mux_df (
  input  wire I0,
  input  wire I1,
  input  wire S,
  output wire Y  
);

  assign Y = S ? I1 : I0;

endmodule