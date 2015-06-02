`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:45:38 06/01/2015
// Design Name:   SymGen
// Module Name:   /home/steven/workspace/SymCounter/symgen_tb.v
// Project Name:  lab4Stevia
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: SymGen
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module symgen_tb;

	// Inputs
	reg Clk100M;
	reg [31:0] symGenMax;
	reg genSym;

	// Outputs
	wire generated;
	wire special;
	wire [7:0] generatedSym;

	// Instantiate the Unit Under Test (UUT)
	SymGen uut (
		.Clk100M(Clk100M), 
		.symGenMax(symGenMax), 
		.genSym(genSym), 
		.generated(generated), 
		.special(special), 
		.generatedSym(generatedSym)
	);

	initial begin
		// Initialize Inputs
		Clk100M = 1;
		symGenMax = 10;
		genSym = 1; //are we in game period

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
 always Clk100M = #5 ~Clk100M;      
endmodule

