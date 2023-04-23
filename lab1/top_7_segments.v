`include "lab1/7_segments.v"
module top_module (
    input  [15:0] signal,
    output [27:0] out
);
  localparam N = 4;
  // Instantiate
  genvar i;
  generate
    for (i = 0; i < N; i = i + 1) begin
      decode_7_segment led (
          .bcd(signal[4*i+:4]),
          .out(out[7*i+:7])
      );
    end
  endgenerate

endmodule
