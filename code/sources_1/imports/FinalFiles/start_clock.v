`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:42:08 10/24/2016 
// Design Name: 
// Module Name:    start_clock 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module start_clock(
    input CLOCK,reset,
	 input [11:0] Freq_Req,   //in hz ( max value allowed is 2828 Hz and min is 1 Hz).
	 input [7:0] step,
    output START_CLOCK
    );
    
    reg [31:0] COUNT = 0;
	 reg [31:0] MAX_COUNT = 0;
	 reg START_CLOCK;
	 
	 initial begin
		START_CLOCK = 0;
		MAX_COUNT = 0;
	 end	
    
    always@(posedge CLOCK or posedge reset) begin
		if(reset) begin
		  START_CLOCK <= 0;
		  MAX_COUNT <= 0;
		  COUNT <= 0;		
		end else begin	
		  MAX_COUNT <= (100000000*step) / (Freq_Req *8192);
        START_CLOCK <= (COUNT == MAX_COUNT/2) ? ~START_CLOCK : START_CLOCK;
		  COUNT <= (COUNT == MAX_COUNT/2) ? 0 : (COUNT + 1);
		end  
    end
endmodule
