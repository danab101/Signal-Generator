`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2016 12:47:31 PM
// Design Name: 
// Module Name: DAC_clock
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module DAC_clock(
    input CLOCK,
    output reg DAC_CLOCK
    );
    
    reg [31:0] COUNT = 0;
	 reg [31:0] MAX_COUNT = 0;
	 
	 initial
		DAC_CLOCK = 0;
    
    always @ (posedge CLOCK) begin
        MAX_COUNT <= 1000; 
        DAC_CLOCK <= (COUNT == MAX_COUNT/2) ? ~DAC_CLOCK : DAC_CLOCK;
		  COUNT <= (COUNT == MAX_COUNT/2) ? 0 : (COUNT + 1);
    end
endmodule
