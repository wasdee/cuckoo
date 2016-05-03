`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:23:50 04/19/2016 
// Design Name: 
// Module Name:    clock 
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
module clock(
    output [3:0] hourTens,hourMu, minTens,minMu,
    output sig1s,
	 input clk10hz,
    input setH,
	 input setM
    );
	 parameter dGND = 4'b0000;
	 parameter h = 1'b1;
	 
	 
	 wire [3:0] qS___, qS__, qS_;
	 
	 wire rcoS___, rcoS__, rcoS_, rcoM__, rcoM_, rcoH__, rcoH_;
	 wire qS__d1,qS__d2,qS__d3, qS_d0, qS_d1, qS_d2, qS_d3;
	 

	 
	 assign nand1 = !(qS_[0] & qS_[2] & rcoS__);
	 assign nand2 = !(nand1 & setM);
	 assign nand3 = !(minTens[0] & minTens[2] & rcoM__);
	 assign nand4 = !(((setM&nand3)|(!setM)) & setH);
	 assign nand5 = !(nand4 & hourMu[0] & hourMu[1] & hourTens[1]); //24 reset

	 
	 
	 assign sig1s = qS__[0];
	 
	 c74160 s___(qS___, rcoS___, dGND, h, h, clk10hz,h);
	 c74160 s__(qS__, rcoS__, dGND, rcoS___, h, clk10hz,h);
	 c74160 s_(qS_, rcoS_, dGND, rcoS__, nand1, clk10hz, h);
	 
	 
	 c74160 m__(minMu, rcoM__, dGND, nand2, h, clk10hz, h);
	 c74160 m_(minTens, rcoM_, dGND, rcoM__, nand3, clk10hz, h);
	 
	 c74160 h__(hourMu, rcoH__, dGND, nand4, nand5, clk10hz, h);
	 c74160 h_(hourTens, rcoH_, dGND, rcoH__, nand5, clk10hz, h);
	 
	 

endmodule
