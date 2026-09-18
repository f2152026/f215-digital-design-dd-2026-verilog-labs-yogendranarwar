`timescale 1ns/1ps

module and_df (
  input  wire a,
  input  wire b,
  output wire y
);
  assign #3 y = a & b;
endmodule