`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:08 03/29/2016 
// Design Name: 
// Module Name:    top_module 
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
module top_module(
    output [6:0] seg,
	 output 	DG1,
				DG2,
    input clk,
    input not_reset
    );
	 wire clk_10_5hz,clk_1hz,rco1,rco2,reset2nddigit;
	 wire [3:0] q,digit1,digit2;
	 
	 assign reset2nddigit = ((digit2==4'b0110)&&(!not_reset))? 0 :1;
	 assign q =(clk_10_5hz)? digit1: digit2;
	 assign DG1 = (clk_10_5hz)? 1: 0;
	 assign DG2 = (clk_10_5hz)? 0: 1;
	 
	 clk_4ms clk_4ms(clk_10_5hz,clk);
	 divider divider(clk_1hz,clk);
	 BCDcounter counter1(digit1,rco1,clk_1hz,not_reset);
	 BCDcounter counter2(digit2,rco2,rco1,reset2nddigit);
	 BCDto7seg segDisplay(seg,q);		


endmodule
