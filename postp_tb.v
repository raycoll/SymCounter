`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   01:44:02 06/02/2015
// Design Name:   PostPeriod
// Module Name:   /home/steven/workspace/SymCounter/postp_tb.v
// Project Name:  lab4Stevia
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PostPeriod
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module postp_tb;

	// Inputs
	reg Clk100M;
	reg Clk1Hz;
	reg postSig;

	// Outputs
	wire levelComplete;
	wire [7:0] postSeg0;
	wire [7:0] postSeg1;
	wire [7:0] postSeg2;
	wire [7:0] postSeg3;

	// Instantiate the Unit Under Test (UUT)
	PostPeriod uut (
		.Clk100M(Clk100M), 
		.Clk1Hz(Clk1Hz), 
		.postSig(postSig), 
		.levelComplete(levelComplete), 
		.postSeg0(postSeg0), 
		.postSeg1(postSeg1), 
		.postSeg2(postSeg2), 
		.postSeg3(postSeg3)
	);

	initial begin
		// Initialize Inputs
		Clk100M = 0;
		Clk1Hz = 0;
		postSig = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

