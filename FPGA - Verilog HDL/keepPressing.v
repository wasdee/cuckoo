`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:19:43 04/22/2016 
// Design Name: 
// Module Name:    keepPressing 
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
module keepPressing(
		output reg isKP,
		input clk10hz, pb
    );
	 reg [3:0] counter;
	 
	 initial begin counter=0; isKP=0; end
	 
	 always @(posedge clk10hz, posedge pb) begin
		if(counter > 8) begin
			isKP <= 1'b1;
			if (pb==1) counter <= 0;
		end
		else begin
			isKP <= 1'b0;
			counter <= counter + 1;
			if (pb==1) counter <= 0;
		end
	 end
	

endmodule
