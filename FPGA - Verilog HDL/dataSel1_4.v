`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:48:12 04/19/2016 
// Design Name: 
// Module Name:    dataSel1_4 
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
module dataSel1_4(
    output reg [3:0] q,
    input [1:0] sel,
    input [3:0] d1,
    input [3:0] d2,
    input [3:0] d3,
    input [3:0] d4
    );
	always @(sel) begin
		case(sel)
		0: q<= d1;
		1: q<= d2;
		2: q<= d3;
		3: q<= d4;
	endcase
	end
endmodule
