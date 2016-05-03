`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:43:11 04/21/2016 
// Design Name: 
// Module Name:    c74160 
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
module c74160(
		output reg[3:0] q,
		output rco,
		input [3:0] d,
		input en,
		//input ent,
		input notLoad,
		input clk,
		input notMr
    );
	initial q = 4'b0000;
	 //initial rco = 1'b0;
	 
	assign rco = ((q == 4'b1001)&en)? 1'b1:1'b0;
	 
	
	always @ (posedge clk, negedge notMr) begin
		if(notMr==0) q <= 4'b0000;
		else begin 
			if(notLoad !=0)  begin
						if(en != 0) begin // enable
								if(q > 4'b1000) q <= 4'b0000;
								else q <= q + 4'b0001;
						end
			end 
				else q <= d;
		end
	end
	
	
endmodule
