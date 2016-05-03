`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:48:55 04/02/2016 
// Design Name: 
// Module Name:    AU 
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
module AU(
    output reg [3:0] out,
	 output reg cout, 
	 output z,
    input [3:0] a,
    input [3:0] b,
    input [2:0] sel
    );
	assign z = (out == 0)? 1: 0;
	 
	always @(sel,a,b) begin
		case(sel)
			1:{cout,out} = a + b; //add
			2:{cout,out} = a - b; //minus
			5:{cout,out} = a + b + cout; //add w/ c
			6:{cout,out} = a - b - cout; //minus w/ c
			default: out = 'bx; 
		endcase
	end

endmodule
