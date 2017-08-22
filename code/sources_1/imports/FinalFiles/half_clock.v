`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2016 12:42:12 PM
// Design Name: 
// Module Name: half_clock
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


module half_clock(
    input CLOCK,
    output reg HALF_CLOCK
    );
    
    reg [2:0] COUNT = 1'b0000;
    //reg HALF_CLOCK;
	 
	 initial 
		HALF_CLOCK = 0;
    
    always @ (posedge CLOCK) begin
        COUNT <= COUNT + 1;
        HALF_CLOCK <= (COUNT == 26'b0000) ? ~HALF_CLOCK : HALF_CLOCK;
    end
endmodule
