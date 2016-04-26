`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:31:59 04/23/2016 
// Design Name: 
// Module Name:    cuckooRinging 
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
module cuckooRinging(
    output buzzer, 
    input isSameTime,
    input clk,
    input yoodRong,
	 input onOffAlarm
    );
	 
	 assign ringAble = isSameTime & (!onOffAlarm);
	 
	 reg ringIng;
	 
	 always @(posedge ringAble, negedge yoodRong) begin
	 if(ringAble) ringIng <= 1;
	 else ringIng <= 0;
	 if(!yoodRong) ringIng <= 0;
	 end
	 
	 reg [12:0] soundFile = 13'b0000010111111;
	 wire sound = soundFile[0];
	 always @(posedge clk) begin
		soundFile <= {soundFile[11:0],soundFile[12]};
	 end
	 
	 assign buzzer = sound&ringIng;
	 


endmodule
