`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   15:19:17 06/01/2015
// Design Name:   Game
// Module Name:   C:/Users/152/SymCounter/tb.v
// Project Name:  lab4Stevia
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Game
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb;

	// Inputs
	reg Clk100M;
	reg btnS;
	reg btnU;
	reg btnD;

	// Outputs
	wire [7:0] seg;
	wire [3:0] an;

	// Instantiate the Unit Under Test (UUT)
	Game uut (
		.Clk100M(Clk100M), 
		.btnS(btnS), 
		.btnU(btnU), 
		.btnD(btnD), 
		.seg(seg), 
		.an(an)
	);

	initial begin
		// Initialize Inputs
		Clk100M = 0;
		btnS = 0;
		btnU = 0;
		btnD = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

