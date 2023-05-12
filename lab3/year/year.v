module years (
    input rst_n,
    input inc_year,
    output [15:0] o_year
);

  // Internal logic
  reg [15:0] years_cnt;

  always @(posedge inc_year or negedge rst_n) begin
    if (!rst_n) begin
      years_cnt <= 0;

    end else begin
      years_cnt <= years_cnt + 1'b1;
    end
  end

  assign o_year = years_cnt;

endmodule
