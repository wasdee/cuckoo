`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:10:16 04/02/2016 
// Design Name: 
// Module Name:    LU 
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
module LU(
    output reg [3:0] out,
    input [3:0] a,
    input [3:0] b,
    input [2:0] sel
    );
	 
	 always @(sel,a,b) begin
		case(sel)
			0: out = a & b; //and 
			1: out = a | b; //or 
			2: out = a ^ b; //xor 
			3: out = ~(a & b); //nand 
			4: out = ~a; //not 
			5: out = a << 1; //sft l mul 2 
			6: out = a >> 1; //sft r div 2 
			default: out = 'bx; 
		endcase
	end

endmodule
