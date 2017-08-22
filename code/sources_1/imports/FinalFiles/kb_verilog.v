`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:46 10/19/2016 
// Design Name: 
// Module Name:    kb_verilog 
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
module mouse(
	input wire clk, // Clock pin form keyboard
	input wire data, //Data pin form keyboard
	output reg [1:0] d
);

reg [7:0] data_curr;
reg [3:0] b;
reg [1:0] c1;
reg flag;

initial
begin
	c1 <= 0;
	flag<=1'b0;
	data_curr<=8'hf0;
end

always @(negedge clk) //Activating at negative edge of clock from keyboard
begin
case(b)
	1:; //first bit
	2:data_curr[0]<=data;
	3:data_curr[1]<=data;
	4:data_curr[2]<=data;
	5:data_curr[3]<=data;
	6:data_curr[4]<=data;
	7:data_curr[5]<=data;
	8:data_curr[6]<=data;
	9:data_curr[7]<=data;
	10:flag<=1'b1; //Parity bit
	11:flag<=1'b0; //Ending bit
endcase
 if(b<=10)
	b <= b+1;
 else if(b==11)
	b <= 1;
end

always@(posedge flag) // Printing data obtained to led
begin
	if(c1 == 2)
		c1 <= 0;
	else	
		c1 <= c1+1;	
	if(c1 == 0)	
		if(data_curr[1] == 1) 
			if(d == 2)
				d <= 0;
			else	
				d <= d+1;	
end 	

endmodule
