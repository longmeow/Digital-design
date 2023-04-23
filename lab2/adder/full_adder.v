module FullAdder (
    input  a,
    input  b,
    input  ci,
    output r,
    output co
);
  assign r  = a ^ b ^ ci;
  assign co = a & ci + a & b + b & ci;
endmodule
