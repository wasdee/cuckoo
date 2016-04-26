`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:34:35 03/29/2016 
// Design Name: 
// Module Name:    BCDto7seg 
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
module BCDto7seg(
    output reg [6:0] seg,
    input [3:0] q
    );
	always @(q)
		case (q)       //abcdefg
			0: seg = 7'b1111110 ;
	   	1: seg = 7'b0110000;
			2: seg = 7'b1101101;
			3: seg = 7'b1111001;
			4: seg = 7'b0110011;
			5: seg = 7'b1011011;
			6: seg = 7'b1011111;
			7: seg = 7'b1110000;
			8: seg = 7'b1111111;
			9: seg = 7'b1111011;
			default: seg = 7'bx;
		endcase

			
endmodule
