`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:36:19 04/19/2016 
// Design Name: 
// Module Name:    display 
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
module display(
    output [6:0] seg,
	 output [3:0] segEn,
	 output dp,
    input sysclk
    );
	 wire sig1s,sig4ms;
	 wire [1:0] sigWhichDigit;
	 wire [3:0] valDigit;
	 
	 //just for test time display - begin
	 reg [3:0] m_,m__,h_,h__;
	 initial begin
		m_ = 5;
		m__ = 9;
		h_ = 2;
		h__ = 1;
	 end
	 //just for test time display - end
	 
	 assign dp = (sigWhichDigit[1]^sigWhichDigit[0])&sig1s;
	 dataSel1_4 valSwap(valDigit, sigWhichDigit, h_, h__, m_, m__);
	 counter_2bit swapDigit(sigWhichDigit, sig4ms);
	 clk_1s tick(sig1s,sysclk);
	 clk_4ms tick2(sig4ms,sysclk);
	 BCDto7seg valDisplaySig(seg, valDigit);
	 decoder2_4 SsegSwap(segEn, sigWhichDigit);
	 
	 
endmodule
