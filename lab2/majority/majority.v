module majority #(
    parameter N = 32
) (
    input [N-1:0] seq,
    output out
);
  reg major;
  assign out = major;

  integer i;
  integer ones = 0;
  integer zeros = 0;

  always @(*) begin
    for (i = 0; i < N; i = i + 1) begin
      if (seq[i] == 1'b1) begin
        ones = ones + 1;
      end else begin
        zeros = zeros + 1;
      end
    end

    if (ones > zeros) begin
      major = 1'b1;
    end else if (ones < zeros) begin
      major = 1'b0;
    end else begin
      major = 1'b0;
    end
  end

endmodule
