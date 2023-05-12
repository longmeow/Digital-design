module day_detect (
    input  [ 3:0] o_month,
    input  [15:0] o_year,
    output [ 1:0] o_rst_day
);

  //Internal logic
  reg [1:0] rst_day;

  // 00:28; 01:29; 10:30; 11:31
  always @(*) begin
    if ((o_month == 4'd4) || (o_month == 4'd6) || (o_month == 4'd9) || (o_month == 4'd11)) begin
      rst_day <= 2'b10;
    end else if (o_month == 4'd2) begin
      if ((o_year % 4 == 0) && ((o_year % 400 == 0) || (o_year % 100 != 0))) begin
        rst_day <= 2'b01;
      end else begin
        rst_day <= 2'b00;
      end
    end else begin
      rst_day <= 2'b11;
    end
  end

  assign o_rst_day = rst_day;
endmodule

