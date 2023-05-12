// `include "sec/sec.v"
// `include "min/min.v"
// `include "hour/hour.v"
// `include "day/day.v"
// `include "month/month.v"
// `include "year/year.v"
// `include "day_detect/day_detect.v"

module top #(
    parameter CLOCK_FREQ = 32'd5
) (
    input clk,
    input rst_n,
    output [5:0] seconds,
    output [5:0] minutes,
    output [4:0] hours,
    output [4:0] days,
    output [3:0] months,
    output [15:0] years
);

  wire [5:0] o_seconds;
  wire o_inc_min;


  wire [5:0] o_min;
  wire o_inc_hour;


  wire [4:0] o_hour;
  wire o_inc_day;


  wire [4:0] o_days;
  wire o_inc_month;


  wire [3:0] o_month;
  wire o_inc_year;


  wire [15:0] o_year;


  wire [1:0] o_rst_day;
  // Internal wire for Sec output

  // Instantiate Second Block
  seconds #(
      .CLOCK_FREQ(CLOCK_FREQ)
  ) Sec (
      .clk(clk),
      .rst_n(rst_n),
      .o_seconds(o_seconds),
      .o_inc_min(o_inc_min)
  );

  // Internal wire for Min output

  // Instantiate Minute Block
  minutes Min (
      .rst_n(rst_n),
      .inc_min(o_inc_min),
      .o_min(o_min),
      .o_inc_hour(o_inc_hour)
  );

  // Internal wire for Hour output

  // Instantiate Hour Block
  hours Hour (
      .rst_n(rst_n),
      .inc_hour(o_inc_hour),
      .o_hour(o_hour),
      .o_inc_day(o_inc_day)
  );

  // Internal wire for Day output

  // Instantiate Day Block
  days Day (
      .rst_n(rst_n),
      .inc_day(o_inc_day),
      .rst_day(o_rst_day),
      .o_days(o_days),
      .o_inc_month(o_inc_month)
  );

  // Internal wire for Month output

  // Instantiate Month Block
  months Month (
      .rst_n(rst_n),
      .inc_month(o_inc_month),
      .o_month(o_month),
      .o_inc_year(o_inc_year)
  );

  // Internal wire for Year output

  // Instantiate Year Block
  years Year (
      .rst_n(rst_n),
      .inc_year(o_inc_year),
      .o_year(o_year)
  );

  //  Internal wire for Detect output

  // Instantiate Detect Block
  day_detect Detect (
      .o_month(o_month),
      .o_year(o_year),
      .o_rst_day(o_rst_day)
  );


  assign seconds = o_seconds;
  assign minutes = o_min;
  assign hours = o_hour;
  assign days = o_days;
  assign months = o_month;
  assign years = o_year;

endmodule
