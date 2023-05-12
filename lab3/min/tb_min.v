`timescale 1ns / 1ps
// `include "min/min.v"

module tb_min ();

  reg rst_n;
  reg inc_min;
  wire [5:0] o_min;
  wire o_inc_hour;

  minutes DUT (
      .rst_n(rst_n),
      .inc_min(inc_min),
      .o_min(o_min),
      .o_inc_hour(o_inc_hour)
  );

  integer i;
  initial begin
    rst_n   = 1;
    inc_min = 0;
    $stop;
  end

  always @(*) begin
    for (i = 0; i < 300; i = i + 1) begin
      #5 inc_min = ~inc_min;
      if (i == 0) begin
        rst_n = 0;
        #5;
        rst_n = 1;
      end
      if (i==130) begin
        rst_n = 0;
        #5;
        rst_n = 1;
      end
      end
    end

endmodule
