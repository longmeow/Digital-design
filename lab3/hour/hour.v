module hours (
    input rst_n,
    input inc_hour,
    output [4:0] o_hour,
    output o_inc_day
);
  // Internal logic
  reg [4:0] hours_cnt;
  reg inc_day;

  always @(posedge inc_hour or negedge rst_n) begin
    if (!rst_n) begin
      hours_cnt <= 0;

    end else begin
      if (hours_cnt == 5'd24) begin
        hours_cnt <= 0;
        inc_day   <= 1;

      end else begin
        hours_cnt <= hours_cnt + 1'b1;
        inc_day   <= 0;
      end
    end
  end

  assign o_inc_day = inc_day;
  assign o_hour = hours_cnt;

endmodule
