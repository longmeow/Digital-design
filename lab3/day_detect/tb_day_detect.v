`timescale 1ns / 1ps
// `include "day_detect/day_detect.v"

module tb_day_detect ();

  reg  [ 3:0] o_month;
  reg  [15:0] o_year;
  wire [ 1:0] o_rst_day;

  day_detect DUT (
      .o_month(o_month),
      .o_year(o_year),
      .o_rst_day(o_rst_day)
  );

  integer i;
  integer j;
  initial begin
    // initiate
    o_month = 1;
    o_year  = 0;

    for (i = 0; i < 500; i = i + 1) begin
      o_year = o_year + 1;
      #5;
      o_month = 1;
      #5;
      for (j = 0; j < 11; j = j + 1) begin
        o_month = o_month + 1;
        #5;
      end

    end
  end
endmodule
