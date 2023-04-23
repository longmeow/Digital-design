`include "lab2/adder/full_adder.v"

module Adder #(
    parameter N = 32
) (
    input  [N-1:0] A,
    B,
    output [  N:0] R
);
  wire [N:0] C;

  genvar i;
  generate
    for (i = 0; i < N; i = i + 1) begin
      FullAdder add (
          .a (A[i]),
          .b (B[i]),
          .ci(C[i]),
          .r (R[i]),
          .co(C[i+1])
      );
    end
  endgenerate

  assign C[0] = 1'b0;
  assign R[N] = C[N];
endmodule
