`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:59:13 04/19/2016 
// Design Name: 
// Module Name:    decoder2_4 
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
module decoder2_4(
	output reg [3:0] m,
	input [1:0] bin
    );
	 always @(bin) begin
		case(bin)
		3: m<= 4'b1110;
		2: m<= 4'b1101;
		1: m<= 4'b1011;
		0: m<= 4'b0111;
	endcase
	end


endmodule
