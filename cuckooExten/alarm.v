`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:12:26 04/22/2016 
// Design Name: 
// Module Name:    alarm 
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
module alarm(
		output [3:0] alarmHourTens, alarmHourMu, alarmMinTens, alarmMinMu,	
		input  setM, setH, clk10hz
		
		
    );
		
		wire rcoM__, rcoM_, rcoH__, rcoH_, minClkRate, hourClkRate, nand3, nand5;
		parameter dGND = 4'b0000;
		parameter h = 1'b1;
		
		assign nand3 = !(alarmMinTens[0] & alarmMinTens[2] & rcoM__);
		assign nand5 = !(!setH & alarmHourMu[0] & alarmHourMu[1] & alarmHourTens[1]); //24 reset

//		assign clkMinSelected = (minClkRate & setButton)  |((!setButton) & clk10hz);
//		assign clkHourSelected = (hourClkRate & setButton)|((!setButton) & clk10hz);
		
		c74160 m__(alarmMinMu, rcoM__, dGND, !setM, h, clk10hz, h);
		c74160 m_(alarmMinTens, rcoM_, dGND, rcoM__, nand3, clk10hz, h);

		c74160 h__(alarmHourMu, rcoH__, dGND, !setH, nand5, clk10hz, h);
		c74160 h_(alarmHourTens, rcoH_, dGND, rcoH__, nand5, clk10hz, h);
endmodule
