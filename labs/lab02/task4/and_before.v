`timescale 1ns/1ps

module and_beh_before (
  input  wire a,
  input  wire b,
  output reg  y
);
  always @(*) begin
    #3 y = a & b;
  end
endmodule