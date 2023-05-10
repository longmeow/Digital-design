module timer_top
    // Parameters section
    #( parameter CLOCK_FREQ = 32'd50_000_000 // 50MHz frequency
    ) 
    // Ports section
    (input clk,
    input rst_n,
	output [6:0] o_HEX0,  // seconds
    output [6:0] o_HEX1,	
	output [6:0] o_HEX2,  // minutes
    output [6:0] o_HEX3,
	output [6:0] o_HEX4,  // hours
    output [6:0] o_HEX5
	);
		
	// Internal logic 	
	
	wire [5:0] o_seconds;      // 0-59 seconds in binary
	wire [5:0] o_minutes;      // 0-59 minutes in binary
	wire [6:0] o_hours;        // 0-99 hours (8'd99 is the maximum decimal value possible on two 7seg digits)
	
	wire [11:0] seconds_bcd;   // 0-59 seconds in binary coded decimal
	wire [11:0] minutes_bcd;   // 0-59 minutes in binary coded decimal
    wire [11:0] hours_bcd;     // 0-99 hours   in binary coded decimal

	
	// Instantiate the Timer
	timer #(.CLOCK_FREQ(CLOCK_FREQ)) 
		TMR0
    (  .clk      (clk),
       .rst_n    (rst_n),
	   .o_seconds(o_seconds),
	   .o_minutes(o_minutes),
	   .o_hours  (o_hours)  
	);
	
	
	// Convert from binary values to binary-coded decimals BCD using the double-dabble algorithm
	// small number of gates in computer hardware, but at the expense of high latency
	// Each BCD requires 4 bits
	bin2bcd
		B2D_SEC
    ( .clk(clk),
	  .rst_n(rst_n),
	  .i_bin({2'b0, o_seconds}),  // binary
      .o_bcd(seconds_bcd)	        // BCD
	);  
	
	bin2bcd
		B2D_MIN
    ( .clk(clk),
	  .rst_n(rst_n),
	  .i_bin({2'b0, o_minutes}),  
      .o_bcd(minutes_bcd)	  
	);  
	
	bin2bcd
		B2D_HOUR
    ( .clk(clk),
	  .rst_n(rst_n),
	  .i_bin({1'b0, o_hours}),  
      .o_bcd(hours_bcd)	           
	);
	
	// Instantiate 6x hex_7seg_decoder	
	hex_7seg_decoder
    #(.COMMON_ANODE_CATHODE(0)) // 0 for common Anode / 1 for common cathode
		SEC0
    (
    .in (seconds_bcd[3:0]),
    .o_a(o_HEX0[0]),
	.o_b(o_HEX0[1]),
    .o_c(o_HEX0[2]),
    .o_d(o_HEX0[3]),
    .o_e(o_HEX0[4]),
    .o_f(o_HEX0[5]),
    .o_g(o_HEX0[6])
    );
	
	hex_7seg_decoder
    #(.COMMON_ANODE_CATHODE(0)) // 0 for common Anode / 1 for common cathode
		SEC1
    (
    .in (seconds_bcd[7:4]),
    .o_a(o_HEX1[0]),
	.o_b(o_HEX1[1]),
    .o_c(o_HEX1[2]),
    .o_d(o_HEX1[3]),
    .o_e(o_HEX1[4]),
    .o_f(o_HEX1[5]),
    .o_g(o_HEX1[6])
    );
	
	hex_7seg_decoder
    #(.COMMON_ANODE_CATHODE(0)) // 0 for common Anode / 1 for common cathode
		MIN0
    (
    .in (minutes_bcd[3:0]),
    .o_a(o_HEX2[0]),
	.o_b(o_HEX2[1]),
    .o_c(o_HEX2[2]),
    .o_d(o_HEX2[3]),
    .o_e(o_HEX2[4]),
    .o_f(o_HEX2[5]),
    .o_g(o_HEX2[6])
    );
	
	hex_7seg_decoder
    #(.COMMON_ANODE_CATHODE(0)) // 0 for common Anode / 1 for common cathode
		MIN1
    (
    .in (minutes_bcd[7:4]),
    .o_a(o_HEX3[0]),
	.o_b(o_HEX3[1]),
    .o_c(o_HEX3[2]),
    .o_d(o_HEX3[3]),
    .o_e(o_HEX3[4]),
    .o_f(o_HEX3[5]),
    .o_g(o_HEX3[6])
    );
	
	
	hex_7seg_decoder
    #(.COMMON_ANODE_CATHODE(0)) // 0 for common Anode / 1 for common cathode
		HOUR0
    (
    .in (hours_bcd[3:0]),
    .o_a(o_HEX4[0]),
	.o_b(o_HEX4[1]),
    .o_c(o_HEX4[2]),
    .o_d(o_HEX4[3]),
    .o_e(o_HEX4[4]),
    .o_f(o_HEX4[5]),
    .o_g(o_HEX4[6])
    );
	
	hex_7seg_decoder
    #(.COMMON_ANODE_CATHODE(0)) // 0 for common Anode / 1 for common cathode
		HOUR1
    (
    .in (hours_bcd[7:4]),
    .o_a(o_HEX5[0]),
	.o_b(o_HEX5[1]),
    .o_c(o_HEX5[2]),
    .o_d(o_HEX5[3]),
    .o_e(o_HEX5[4]),
    .o_f(o_HEX5[5]),
    .o_g(o_HEX5[6])
    );

endmodule