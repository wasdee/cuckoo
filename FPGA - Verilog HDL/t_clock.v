`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:44:51 04/21/2016
// Design Name:   clock
// Module Name:   W:/CPE/digital/project/cuckooExten/t_clock.v
// Project Name:  cuckooExten
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: clock
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_clock;

	// Inputs
	reg hourClkRate;
	reg minClkRate;
	reg clk10hz;
	reg setM;
	reg setH;
	reg setButton;

	// Outputs
	wire [3:0] hourMu;
	wire [3:0] hourTens;
	wire [3:0] minMu;
	wire [3:0] minTens;
	wire colon;

	// Instantiate the Unit Under Test (UUT)
	clock uut (
		.hourMu(hourMu), 
		.hourTens(hourTens), 
		.minMu(minMu), 
		.minTens(minTens), 
		.colon(colon), 
		.hourClkRate(hourClkRate), 
		.minClkRate(minClkRate), 
		.clk10hz(clk10hz), 
		.setM(setM), 
		.setH(setH), 
		.setButton(setButton)
	);

	initial begin
		// Initialize Inputs
		hourClkRate = 0;
		minClkRate = 0;
		clk10hz = 0;
		setM = 1;
		setH = 1;
		setButton = 1;

		// Wait 100 ns for global reset to finish
		forever #10 clk10hz=~clk10hz;
        
		// Add stimulus here

	end
	
	initial #100000 $finish; 
      
endmodule

