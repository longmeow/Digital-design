module alu (
    input [31:0] a,
    input [31:0] b,  //32-bit input
    input [2:0] alu_sel,  // 3-bit selection
    output [31:0] alu_out,  // 32-bit output
    output carry_out  // CarryOut for adder
);
  reg [31:0] alu_result;  // Intermediary 
  assign alu_out = alu_result;

  // Reserse for overflow
  wire [32:0] temp;
  assign temp = {1'b0, a} + {1'b0, b};
  assign carry_out = temp[8];

  always @(*) begin
    case (alu_sel)
      3'b000: alu_result = a + b;  // Add
      3'b001: alu_result = a - b;  // Sub
      3'b010: alu_result = ~a;  // NOT
      3'b011: alu_result = a & b;  // AND 
      3'b100: alu_result = a | b;  // OR
      3'b101: alu_result = a ^ b;  // XOR
      3'b110: alu_result = a << 1;  //SLL
      3'b111: alu_result = a >> 1;  //SRL

      default: alu_result = a + b;
    endcase
  end
endmodule
