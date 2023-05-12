`timescale 1ns / 1ps
//`include "hour/hour.v"

module tb_hour ();

  reg rst_n;
  reg inc_hour;
  wire [4:0] o_hour;
  wire o_inc_day;

  hours DUT (
      .rst_n(rst_n),
      .inc_hour(inc_hour),
      .o_hour(o_hour),
      .o_inc_day(o_inc_day)
  );

  initial begin
    rst_n = 0;
    inc_hour = 0;
    $stop;
  end

  integer i;
  always @(*) begin
    for (i = 0; i < 300; i = i + 1) begin
      #5 inc_hour = ~inc_hour;
      if (i == 5) begin
        rst_n = 1;
      end

      if (i == 60) begin
        rst_n = 0;
        #5;
        rst_n = 1;
      end
    end
  end
endmodule
