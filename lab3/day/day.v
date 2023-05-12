module days (
    input rst_n,
    input inc_day,
    input [1:0] rst_day,
    output [4:0] o_days,
    output o_inc_month
);
  // Internal logic
  reg [4:0] days_cnt;
  reg inc_month;

  always @(posedge inc_day or negedge rst_n or posedge rst_day) begin
    if (!rst_n) begin
      days_cnt <= 1;

    end else begin
      if (days_cnt == 5'd28 && rst_day == 2'b00) begin
        days_cnt  <= 5'd1;
        inc_month <= 1;

      end else if (days_cnt == 5'd29 && rst_day == 2'b01) begin
        days_cnt  <= 5'd1;
        inc_month <= 1;

      end else if (days_cnt == 5'd30 && rst_day == 2'b10) begin
        days_cnt  <= 5'd1;
        inc_month <= 1;

      end else if (days_cnt == 5'd31 && rst_day == 2'b11) begin
        days_cnt  <= 5'd1;
        inc_month <= 1;

      end else begin
        days_cnt  <= days_cnt + 1'b1;
        inc_month <= 0;

      end
    end
  end

  assign o_inc_month = inc_month;
  assign o_days = days_cnt;

endmodule
