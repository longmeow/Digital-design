
/*
	Project name: 
		Binary Coded Decimal Timer to 7Segment display
		
	Description:
		Testbench for Binary Coded Decimal Timer to 7Segment display
		
	Author: 
		Ovidiu Plugariu / www.ovisign.com
		
    Disclaimer: 
		Please note that all the source codes are provided "as-is" with no warranty for further usage.
		For further support or modification, please send an email to ovidiu@ovisign.com
*/


`timescale 1ns/1ps

module tb_timer();	
	
	parameter BUS_WIDTH = 4; // Testbench variables
	
    reg  clk = 0;
	reg  rst_n;
	
	wire [6:0] o_HEX0, o_HEX1;  // seconds
	wire [6:0] o_HEX2, o_HEX3;  // minutes
	wire [6:0] o_HEX4, o_HEX5;  // hours
	
	parameter CLK_HALF_PERIOD = 10;        // 20ns/2 = 50 MHz
	parameter CLK_1ns         = 1 * 10**6; // 10**9 is the real value but we compress simulation time at least 10**6x     
	
	timer_top #(.CLOCK_FREQ(CLK_1ns/(2*CLK_HALF_PERIOD))) // 50MHz frequency	
        TMR0
    (   .clk   (clk   ),
        .rst_n (rst_n ),
	    .o_HEX0(o_HEX0),  // seconds
        .o_HEX1(o_HEX1),	
	    .o_HEX2(o_HEX2),  // minutes
        .o_HEX3(o_HEX3),
	    .o_HEX4(o_HEX4),  // hours
        .o_HEX5(o_HEX5)
	);
	
	always begin #(CLK_HALF_PERIOD); clk = ~clk; end   // Create the clock signal
  
    
    initial begin  // Test scenario
		rst_n = 0;
        #1; 
		rst_n = 1;
		
		repeat(60) @(posedge o_HEX0); // 61 seconds
		#100;
		$stop;
    end
  
endmodule