`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:40:30 03/29/2016 
// Design Name: 
// Module Name:    divider 
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
module divider(
    output reg clk,
    input sysclk
    );
	 reg [23:0] counter;
	 always @(negedge sysclk)
		if(counter !=12500000)
			counter <= counter+1;
		else begin
			counter <=0;
			clk<=~clk;
		end

endmodule
