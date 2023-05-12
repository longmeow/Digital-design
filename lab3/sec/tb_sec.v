`timescale 1ns / 1ps
// `include "sec/sec.v"

module tb_sec ();

  reg clk = 0;
  reg rst_n;
  wire [5:0] o_seconds;
  wire o_inc_min;

  parameter CLK_HALF_PERIOD = 100_000_000;  // 5Hz
  parameter CLK_1ns = 1 * 10 ** 9;  //  10**9 / (2*100_000_000) = 5Hz  

  always begin
    #(CLK_HALF_PERIOD);
    clk = ~clk;
  end

  seconds #(
      .CLOCK_FREQ(CLK_1ns / (2 * CLK_HALF_PERIOD))
  ) DUT (
      .clk(clk),
      .rst_n(rst_n),
      .o_seconds(o_seconds),
      .o_inc_min(o_inc_min)
  );

  initial begin  // Test scenario
    rst_n = 0;
    #10;
    rst_n = 1;

    rst_n_sec = 0;
    #10;
    rst_n_sec = 1;

    repeat (2) @(posedge o_inc_min);
    #10;
    $stop;
  end

endmodule
