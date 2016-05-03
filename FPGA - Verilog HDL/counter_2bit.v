`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:41:36 04/19/2016 
// Design Name: 
// Module Name:    counter_2bit 
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
module counter_2bit(
	output reg [1:0] q,
	 input clk
    );
	 always @(posedge clk) begin
			if(q!=3) q<=q+1;
			else q<=0;
	 end



endmodule
