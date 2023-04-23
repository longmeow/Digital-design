//Lam's testbench after minor modified
`include "lab2/majority/majority.v"

module majority_tb;
  reg [31:0] seq;
  wire out;

  majority dut (
      .seq(seq),
      .out(out)
  );

  initial begin
    // Initialize Inputs
    seq = 32'h00000000;

    // Wait 100 ns for global reset to finish
    #100;

    // Test case 1: All zeros
    seq = 32'h00000000;
    #100;
    if (out === 1'b0) begin
      $display("Test case 1 passed");
    end else begin
      $display("Test case 1 failed");
    end

    // Test case 2: All ones
    seq = 32'hFFFFFFFF;
    #100;
    if (out === 1'b1) begin
      $display("Test case 2 passed");
    end else begin
      $display("Test case 2 failed");
    end

    // Test case 3: Half ones, half zeros
    seq = 32'hAAAAAAAA;
    #100;
    if (out === 1'b1) begin
      $display("Test case 3 passed");
    end else begin
      $display("Test case 3 failed");
    end

    // Test case 4: More ones than zeros
    seq = 32'hFFFFF000;
    #100;
    if (out === 1'b1) begin
      $display("Test case 4 passed");
    end else begin
      $display("Test case 4 failed");
    end

    // Test case 5: More zeros than ones
    seq = 32'h0000FFFF;
    #100;
    if (out === 1'b0) begin
      $display("Test case 5 passed");
    end else begin
      $display("Test case 5 failed");
    end

    // End testbench
    $finish;
  end

  initial begin
    $display("seq \t out");
    $monitor("%b \t %b", seq, out);
  end

endmodule
