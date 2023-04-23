`timescale 10ps/1ps
`include "lab2/adder/ripple_adder.v"

// 32-bit adder
module Adder_tb;
    reg [3:0] A, B; // Input
    wire [4:0] R; // Output

    // Instantiate the DUT 8-bit
    Adder #(.N(4)) adder8_dut(.A(A), .B(B), .R(R));
    // Test
    initial begin
        // #1
        A = 4'b0000; B = 4'b0000;
        if (R != 5'b00000) begin
            $display("FAILED");
        end
        #10;

        // #2
        A = 4'b0010; B = 4'b0001;
        if (R != 5'b00011) begin
            $display("FAILED");
        end
        #10;

        // #3
        A = 4'b1000; B = 4'b1001;
        if (R != 5'b10001) begin
            $display("FAILED");
        end
        #10;

        // #4
        A = 4'b1111; B = 4'b0001;
        if (R != 5'b10000) begin
            $display("FAILED");
        end
        #10;
        // End
        $finish();
    end
endmodule

