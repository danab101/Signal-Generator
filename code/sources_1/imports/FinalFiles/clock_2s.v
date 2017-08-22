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


module clock_2s(
    input CLOCK,
    output reg show_freq
    );
    
    reg [31:0] COUNT = 0;
	 reg [31:0] MAX_COUNT = 0;
	 
	 initial
		show_freq = 0;
    
    always @ (posedge CLOCK) begin
        MAX_COUNT <= 400000000; //2 second delay
        show_freq <= (COUNT == MAX_COUNT/2) ? ~show_freq : show_freq;
		  COUNT <= (COUNT == MAX_COUNT/2) ? 0 : (COUNT + 1);
    end
endmodule
