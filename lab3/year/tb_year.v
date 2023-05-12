`timescale 1ns / 1ps
// `include "year/year.v"

module tb_year ();

  reg rst_n;
  reg inc_year;
  wire [15:0] o_year;

  years DUT (
      .rst_n(rst_n),
      .inc_year(inc_year),
      .o_year(o_year)
  );

  integer i;
  initial begin
    rst_n = 1;
    inc_year = 0;
    $stop;
  end

  initial begin
    // start
    rst_n = 0;
    #5;
    rst_n = 1;
    #5;

    for (i = 0; i < 3000; i = i + 1) begin
      #5 inc_year = ~inc_year;
      if (i == 150) begin
        rst_n = 0;
        #5;
        rst_n = 1;
      end
    end
  end

endmodule
