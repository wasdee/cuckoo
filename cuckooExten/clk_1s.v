`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:59:29 04/19/2016 
// Design Name: 
// Module Name:    clk_1s 
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
module clk_1s(
    output reg sigClk,
    input sysclk
    );
	 initial sigClk = 0;
	reg [23:0] counter;
	 always @(negedge sysclk)
	 
		if(counter !=1250000)//should time ten
			counter <= counter+1;
		else begin
			counter <=0;
			sigClk<=~sigClk;
		end
endmodule
