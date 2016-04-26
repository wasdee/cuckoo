`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:39:06 03/29/2016 
// Design Name: 
// Module Name:    BCDcounter 
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
module BCDcounter(
    output reg [3:0] q, 
	 output reg clk_10,
	 input clk,
    input not_reset
    );
	 initial clk_10=0;
	 
	 always @(posedge clk, negedge not_reset) begin
	 if(not_reset==0) q<=0;
		else begin
			if(q!=9) begin
				q<=q+1;
				clk_10<=0;
			end
			else begin
				q<=0;
				clk_10<=1;
			end
		end
		end

endmodule
