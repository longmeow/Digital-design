`include "lab2/alu/alu.v"

module alu_tb ();
  reg [31:0] a, b;  //32-bit input
  reg [2:0] alu_sel;  // 3-bit selection
  wire [31:0] alu_out;  // 32-bit output
  wire carry_out;

  alu dut (
      .a(a),
      .b(b),
      .alu_sel(alu_sel),
      .alu_out(alu_out),
      .carry_out(carry_out)
  );
  integer i;
  initial begin
    a = 8'hff;
    b = 8'h0f;
    alu_sel = 3'b0;

    for (i = 0; i < 8; i = i + 1) begin
      alu_sel = alu_sel + 3'b1;
      #10;
    end
  end

  initial begin
    $display("alu_sel  a b alu_out carry_out");
    $monitor("%b %b %b %b %b", alu_sel, a, b, alu_out, carry_out);
  end
endmodule
