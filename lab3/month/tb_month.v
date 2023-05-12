`timescale 1ns / 1ps
// `include "month/month.v"

module tb_month ();

  reg rst_n;
  reg inc_month;
  wire [3:0] o_month;
  wire o_inc_year;

  months DUT (
      .rst_n(rst_n),
      .inc_month(inc_month),
      .o_month(o_month),
      .o_inc_year(o_inc_year)
  );

  integer i;
  initial begin
    rst_n = 1;
    inc_month = 0;
    $stop;
  end

  initial begin
    // start
    rst_n = 0;
    #5;
    rst_n = 1;
    #5;

    for (i = 0; i < 100; i = i + 1) begin
      #5 inc_month = ~inc_month;
      if (i == 30) begin
        rst_n = 0;
        #5;
        rst_n = 1;
      end
    end
  end

endmodule
