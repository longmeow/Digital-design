`timescale 1ns / 1ps
//`include "top/top.v"

module tb_top ();

  reg clk = 0;
  reg rst_n;
  wire [5:0] seconds;
  wire [5:0] minutes;
  wire [4:0] hours;
  wire [4:0] days;
  wire [3:0] months;
  wire [15:0] years;

  parameter CLK_HALF_PERIOD = 500_000_000;  // 1Hz
  parameter CLK_1ns = 1 * 10 ** 9;  //  10**9 / (2*500_000_000) = 1Hz  

  always begin
    #(CLK_HALF_PERIOD);
    clk = ~clk;
  end

  top #(
      .CLOCK_FREQ(CLK_1ns / (2 * CLK_HALF_PERIOD))
  ) DUT (
      .clk(clk),
      .rst_n(rst_n),
      .seconds(seconds),
      .minutes(minutes),
      .hours(hours),
      .days(days),
      .months(months),
      .years(years)
  );

  initial begin
    // start
    rst_n = 0;
    #5;
    rst_n = 1;

    repeat (15) @(months);
    #10;
    $stop;
  end
endmodule
