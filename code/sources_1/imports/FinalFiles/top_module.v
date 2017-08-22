`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:57:08 10/19/2016 
// Design Name: 
// Module Name:    kb_seg7 
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
module top_module(
	input CLOCK,
	input reset,
	input PS2Clk, // Clock pin form keyboard
	input PS2Data, //Data pin form keyboard
	input [15:1] SW,
	input PB1,PB2,
	output [6:0] seg, //the individual LED output for the seven segment 
	output [3:0] an,   // the 4 bit enable signal
	output [3:0] JA,
	output LED
    );

	reg [11:0] Freq,Amp;
	reg [11:0] Freq1,Amp1;
	reg [3:0] d0,d1,d2,d3;
	wire show_freq;
	wire slow_clock;
	wire [1:0] sel;
	reg set_sqr,set_tri,set_sine;
	
sevenseg seg7(CLOCK,reset,d0,d1,d2,d3,seg,an);	
clock_2s clock_2second(CLOCK,show_freq);
my_DAC dac(CLOCK,reset,Freq,Amp,set_sqr,set_tri,set_sine,JA,LED);
half_clock hc(CLOCK,slow_clock);
mouse mouse1(PS2Clk,PS2Data,sel);

	initial begin
		Freq <= 1;
		Amp <= 1;
	end	
	
	always@(sel,SW[15:13])	
	begin
		if(SW[15] == 1) begin
			if(sel == 0) begin
				set_sqr = 1;
				set_tri = 0;
				set_sine = 0;
			end else if(sel == 1) begin	
				set_sqr = 0;
				set_tri = 1;
				set_sine = 0;
			end else if(sel == 2) begin	
				set_sqr = 0;
				set_tri = 0;
				set_sine = 1;
			end 
		end else begin
			if(SW[14:13] == 0) begin
				set_sqr = 1;
				set_tri = 0;
				set_sine = 0;
			end else if(SW[14:13] == 1) begin
				set_sqr = 1;
				set_tri = 0;
				set_sine = 0;	
			end else if(SW[14:13] == 2) begin
				set_sqr = 0;
				set_tri = 1;
				set_sine = 0;
			end else if(SW[14:13] == 3) begin
				set_sqr = 0;
				set_tri = 0;
				set_sine = 1;	
			end 
		end	
	end 	
	 
	always@(posedge CLOCK or posedge reset)
        begin
            if(reset) begin
                Freq <= 1;
					 Amp <= 1;
            end else begin
					 if(PB1 == 1) begin
						Freq <= SW[12:1];
					 end else if(PB2 == 1) begin
						Amp <= SW[12:1];
					 end 	
				end 	 	
		end   

	always@(posedge slow_clock)
	begin
		Freq1 = Freq;
		Amp1 = Amp;
		if(show_freq == 1) begin
			d3 = Freq1 / 1000;
			Freq1 = Freq1 - d3*1000;
			d2 = Freq1 / 100;
			Freq1 = Freq1 - d2*100;
			d1 = Freq1 / 10;
			Freq1 = Freq1 - d1*10;
			d0 = Freq1;
		end else begin
			d3 = Amp1 / 1000;
			Amp1 = Amp1 - d3*1000;
			d2 = Amp1 / 100;
			Amp1 = Amp1 - d2*100;
			d1 = Amp1 / 10;
			Amp1 = Amp1 - d1*10;
			d0 = Amp1;
		end	
	end
	
endmodule
