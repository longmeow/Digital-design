module minutes (
    input rst_n,
    input inc_min,
    output [5:0] o_min,
    output o_inc_hour
);
  // Internal logic
  reg [5:0] minutes_cnt;  // 0-59 minutes
  reg inc_hour;

  always @(posedge inc_min or negedge rst_n) begin
    if (!rst_n) begin
      minutes_cnt <= 0;

    end else begin
      if (minutes_cnt == 6'd59) begin
        minutes_cnt <= 0;
        inc_hour <= 1;

      end else begin
        minutes_cnt <= minutes_cnt + 1'b1;
        inc_hour <= 0;
      end
    end
  end

  assign o_inc_hour = inc_hour;
  assign o_min = minutes_cnt;

endmodule
