module seconds #(
    parameter CLOCK_FREQ = 32'd500
) (
    input clk,
    input rst_n,
    output [5:0] o_seconds,
    output o_inc_min
);

  localparam ONE_SECOND = CLOCK_FREQ - 1;  // (0-59 there are 60 clocks)

  // Internal logic 
  reg [5:0] seconds_cnt;  // 0-59 seconds
  reg [31:0] cnt_1sec;  // counts every clock cycle (max val is 2**32 > 4.2bln)
  reg inc_min;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin  // hard reset 
      cnt_1sec <= 0;
      seconds_cnt <= 0;

    end else begin
      if (cnt_1sec == ONE_SECOND) begin
        cnt_1sec <= 0;

        if (seconds_cnt == 6'd59) begin
          seconds_cnt <= 0;
          inc_min <= 1;

        end else begin
          seconds_cnt <= seconds_cnt + 1'b1;
          inc_min <= 0;
        end

      end else begin
        cnt_1sec <= cnt_1sec + 1'b1;
      end
    end
  end

  assign o_inc_min = inc_min;
  assign o_seconds = seconds_cnt;

endmodule
