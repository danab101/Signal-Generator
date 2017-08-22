`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/10/2016 12:49:46 PM
// Design Name: 
// Module Name: my_DAC
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


module my_DAC(
    input CLOCK,
    input RESET,
	 input [11:0] Freq,Amp,
	 input set_sqr,set_tri,set_sine,
    output [3:0] JA,
    output LED
    );
    
    reg [11:0] DATA_A = 12'b0;
    reg [10:0] COUNT = 11'b0000;
	 reg [7:0] step = 32;
	 reg [31:0] new_data_a;
	 wire START_CLOCK;
	 
	 reg [11:0] SINE_LUT [0:255];

	initial $readmemh("sine.txt",SINE_LUT);

    half_clock c2(CLOCK, HALF_CLOCK);
    DAC_clock c3(CLOCK,DAC_CLOCK);
	 start_clock c4(CLOCK,RESET,Freq,step,START_CLOCK);
	 
	 always @ (posedge HALF_CLOCK)
		new_data_a <= (DATA_A * Amp) / 3300;   
	

    always @ (posedge START_CLOCK) begin
		 if(set_tri == 1) begin  //triangular wave.
			 if (COUNT == 1'b0)
			 begin
				if (DATA_A >= (12'hFFF-step)) 
				begin
				  COUNT <= 1'b1;
				  DATA_A <= DATA_A - step;
				end
				else 
				  DATA_A <= DATA_A + step;     
			 end
			 else 
			 begin
				if(DATA_A < step) // check for bottom of count
				 begin
				  COUNT <= 1'b0;
				 DATA_A <= DATA_A + step;
				end
				else 
				  DATA_A <= DATA_A - step; 
			 end
		 end else if(set_sqr == 1) begin  //square wave.
        DATA_A <= (COUNT <= (4096/step)) ? 0: 12'hFFF;
		  COUNT <= (COUNT == (8192/step)) ? 0 : (COUNT + 1);
		 end else if(set_sine == 1) begin  //sine wave.
			DATA_A <= SINE_LUT[COUNT];
			COUNT <= (COUNT == ((8192/step)-1)) ? 0 : (COUNT + 1);
		 end
		  	
    end
	 
    DA2RefComp MY_BASIC_DAC(
        .CLK(HALF_CLOCK),
        .START(DAC_CLOCK),
        .RST(RESET),
        .D1(JA[1]),
        .D2(JA[2]),
        .CLK_OUT(JA[3]),
        .nSYNC(JA[0]),
        .DATA1(new_data_a[11:0]),
        .DATA2(),
        .DONE(LED)
        );
        
    
endmodule
