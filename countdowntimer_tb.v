`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:13:40 06/01/2015
// Design Name:   Game
// Module Name:   /home/steven/workspace/SymCounter/countdowntimer_tb.v
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

module countdowntimer_tb;

	// Inputs
	reg Clk100Mhz;
	reg btnS;
	reg btnU;
	reg btnD;

	// Outputs
	wire [7:0] seg;
	wire [3:0] an;

	// Instantiate the Unit Under Test (UUT)
	Game uut (
		.Clk100Mhz(Clk100Mhz), 
		.btnS(btnS), 
		.btnU(btnU), 
		.btnD(btnD), 
		.seg(seg), 
		.an(an)
	);

	initial begin
		// Initialize Inputs
		Clk100Mhz = 0;
		btnS = 0;
		btnU = 0;
		btnD = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

