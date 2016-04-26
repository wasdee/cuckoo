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
	 output [3:0] segEn, status,
	 output [7:0] led,
	 output dp,buzz,
	 input [7:0] ci,//charlesInterface
    input sysclk, setH, setM, displayMode, onOffAlarm, yudRong,
	 input [1:0] k
	  
    );
	 parameter h = 1'b1;
	 wire sigDot1s,sig4ms,sig1hz;
	 
	 
	 wire [1:0] sigWhichDigit;
	 wire [3:0] valDigit,out;
	 
	 wire setSH, setSM, setSaH, setSaM;
	 wire [3:0] m_,m__,h_,h__, 
					aM_, aM__, aH_, aH__,
					cH_,cH__,cM_,cM__;


	 
	 
	 assign dp = (sigWhichDigit[1]^sigWhichDigit[0])&sig1hz&displayMode;
	 
	 assign {h_, h__, m_, m__} = displayMode? {cH_,cH__,cM_,cM__}:{aH_, aH__, aM_, aM__};
	 
	 assign {cSetH,cSetM} = displayMode? {setH,setM}: {h,h};
	 assign {aSetH,aSetM} = displayMode?  {h,h}: {setH,setM};
	 
	 dataSel1_4 valSwap(valDigit, sigWhichDigit, h_, h__, m_, m__);
	 counter_2bit swapDigit(sigWhichDigit, sig4ms);
	 clk_1s tick(sigDot1s,sysclk);
	 clk_4ms tick2(sig4ms,sysclk);
	 BCDto7seg valDisplaySig(seg, valDigit);
	 decoder2_4 SsegSwap(segEn, sigWhichDigit);
	 
	 clock molClk(cH_,cH__,cM_,cM__,sig1hz,sigDot1s,cSetH,cSetM);
	 alarm molAlarm(aH_, aH__, aM_, aM__, aSetM, aSetH, sigDot1s);
	 
	 reg isSetting;
	 reg [1:0] timePosition,tmp;
	 assign isSameTime = {cH_,cH__,cM_,cM__} == {aH_, aH__, aM_, aM__};
	 cuckooRinging ring(buzz, isSameTime&(!isSetting), sigDot1s, yudRong, onOffAlarm);
	 
	 //check whether user is interact hhmm setting
	 initial tmp =3;
	 always @( setM ,setH,timePosition) begin
		if (!(setM&setH)) begin 
			tmp <= timePosition; 
			isSetting <=1; 
		end else begin
			if(tmp == timePosition) isSetting <=1;
			else begin isSetting <=0;tmp <= 3;		end
		end
	end
	 always @(posedge cM__[0]) begin
			if(timePosition==2) timePosition<=0;
			else timePosition<=timePosition+1;
	 end
	 
	 //i2c slave
	 wire [7:0] linkData;
	 I2CslaveWith8bitsIO link(SDA,SCL,linkData);
	 
	 //debug zone
	 assign led = ci;
	 assign status = 4'b1100;
endmodule
