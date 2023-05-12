`timescale 1ns / 1ps
// `include "day/day.v"

module tb_days ();

  reg rst_n;
  reg inc_day;
  reg [1:0] rst_day;
  wire [4:0] o_days;
  wire o_inc_month;

  days DUT (
      .rst_n(rst_n),
      .inc_day(inc_day),
      .rst_day(rst_day),
      .o_days(o_days),
      .o_inc_month(o_inc_month)
  );

  initial begin
    rst_n   = 1;
    rst_day = 2'b00;
    inc_day = 0;
    $stop;
  end

  integer i;
  initial begin
    // start
    rst_n = 0;
    #5;
    rst_n = 1;
    #5;

    // 28 days
    rst_day = 2'b00;
    for (i = 0; i < 80; i = i + 1) begin
      #5 inc_day = ~inc_day;
      if (i == 70) begin
        rst_n = 0;
        #5;
        rst_n = 1;
      end
    end

    // 29 days
    #5;
    rst_day = 2'b01;
    i = 0;
    for (i = 0; i < 80; i = i + 1) begin
      #5 inc_day = ~inc_day;
    end

    // 30 days
    #5;
    rst_day = 2'b10;
    i = 0;
    for (i = 0; i < 80; i = i + 1) begin
      #5 inc_day = ~inc_day;
    end

    // 31 days
    #5;
    rst_day = 2'b11;
    i = 0;
    for (i = 0; i < 80; i = i + 1) begin
      #5 inc_day = ~inc_day;
    end

    $finish;
  end

endmodule
