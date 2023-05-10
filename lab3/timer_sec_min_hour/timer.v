
/*
	Project name: 
		Binary Coded Decimal Timer to 7Segment display

	Description:
		This project will implement a Timer and display the Binary Coded Decimal value on the six DE1-SoC board 7 segment.
		The maximum displayable time is 99h: 59min: 59s .
		The timer uses binary counters and the Double Dabble algorithm to convert between the binary values and Binary Coded Decimals. 
        If your board doesn't have 6x 7Segment displays you can use fewer.
			
    Resources: https://realpars.com/bcd/
	
	Author: 
		Ovidiu Plugariu / www.ovisign.com
		
    Disclaimer: 
		Please note that all the source codes are provided "as-is" with no warranty for further usage.
		For further support or modification, please send an email to ovidiu@ovisign.com
*/


module timer
    // Parameters section
    #( parameter CLOCK_FREQ = 32'd50_000_000 // 50MHz frequency
    ) 
    // Ports section
    (input clk,
    input rst_n,
	output [5:0] o_seconds,      // 0-59 seconds
	output [5:0] o_minutes,      // 0-59 minutes
	output [6:0] o_hours         // 0-99 hours 
	);
	
	localparam ONE_SECOND = CLOCK_FREQ-1; // (0-59 there are 60 clocks)
	
	// Internal logic 
    reg [5:0] seconds_cnt;      // 0-59 seconds
	reg [5:0] minutes_cnt;      // 0-59 minutes
	reg [6:0] hours_cnt;        // 0-99 hours (8'd99 is the maximum value possible on two 7seg digits)
	reg [31:0] counter_1sec;    // counts every clock cycle (max val is 2**32 > 4.2bln)
	
	// Create the code for the Timer
	always @(posedge clk or negedge rst_n)
	begin
	    if(!rst_n) begin
		    counter_1sec <= 0;
			seconds_cnt  <= 0;
			minutes_cnt  <= 0;
			hours_cnt    <= 0;
	    end else begin
		    if (counter_1sec == ONE_SECOND) begin
				counter_1sec <= 0;
				
				if (seconds_cnt == 6'd59) begin     	 // increment the seconds counter
					seconds_cnt <= 0;
					
					if (minutes_cnt == 6'd59) begin 	 // increment the minutes counter
						minutes_cnt <= 0;						
						
						if (hours_cnt == 7'd99) begin    // increment the hours counter (will roll over after 99 hours)						
							hours_cnt <= 0;
						end else begin
						    hours_cnt <= hours_cnt + 1'b1;
					    end
						
					end else begin
						minutes_cnt <= minutes_cnt + 1'b1;
					end
					
				end else begin
					seconds_cnt <= seconds_cnt + 1'b1;
				end
				
			end else begin
				counter_1sec <= counter_1sec + 1'b1;
		    end
		end 
	end
	
	assign o_seconds = seconds_cnt;
	assign o_minutes = minutes_cnt;
	assign o_hours   = hours_cnt;    
	
endmodule