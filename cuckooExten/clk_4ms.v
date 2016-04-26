`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:28:59 04/02/2016 
// Design Name: 
// Module Name:    clk_4ms 
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
module clk_4ms(
    output reg clkOut,
    input clkIn
    );
		 reg [15:0] counter;
	 always @(negedge clkIn)
		if(counter !=50000)
			counter <= counter+1;
		else begin
			counter <=0;
			clkOut<=~clkOut;
		end

endmodule
