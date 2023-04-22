module FullAdder (
    input a, b,
    input ci, r, co
);
    assign r = a^ b ^ ci;
    assign co = a&ci + a&b + b&ci;
endmodule
