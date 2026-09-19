`timescale 1ns/1ps

module and_beh_intra (
  input  wire a,
  input  wire b,
  output reg  y
);
  always @(*) begin
    y = #3 a & b;
  end
endmodule