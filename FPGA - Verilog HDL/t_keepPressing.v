`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:55:49 04/22/2016
// Design Name:   keepPressing
// Module Name:   Z:/digital/project/cuckooExten/t_keepPressing.v
// Project Name:  cuckooExten
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: keepPressing
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module t_keepPressing;

	// Inputs
	reg clk10hz;
	reg pb;

	// Outputs
	wire isKP;

	// Instantiate the Unit Under Test (UUT)
	keepPressing uut (
		.isKP(isKP), 
		.clk10hz(clk10hz), 
		.pb(pb)
	);

	initial begin
		// Initialize Inputs
		clk10hz = 0;
		#92; 

		// Wait 100 ns for global reset to finish
		forever #10 clk10hz=~clk10hz;
        
		// Add stimulus here

	end
	initial begin
		// Initialize Inputs
		pb = 1;

		// Wait 100 ns for global reset to finish
		#100;
		
		pb =0;
		#10;pb =1;#20;
		
		pb =0;
		#50;pb =1;#20;
      
			pb =0;
		#90;pb =1;#20;
        
		  pb =0;
		#100;pb =1;#20;
		
		pb =0;
		#110;pb =1;#20;
		
		pb =0;
		#120;pb =1;#20;
		
		pb =0;
		#200;pb =1;#20;
        
        
		// Add stimulus here

	end
      
endmodule

