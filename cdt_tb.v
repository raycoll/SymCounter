`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:14:03 06/01/2015
// Design Name:   CountDownTimer
// Module Name:   /home/steven/workspace/SymCounter/cdt_tb.v
// Project Name:  lab4Stevia
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: CountDownTimer
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module cdt_tb;

	// Inputs
	reg Clk100M;
	reg Clk1Hz;
	reg start;
	reg [3:0] curLevel;

	// Outputs
	wire doneCounting;
	wire [7:0] seg0;
	wire [7:0] seg1;

	// Instantiate the Unit Under Test (UUT)
	CountDownTimer uut (
		.Clk100M(Clk100M), 
		.Clk1Hz(Clk1Hz), 
		.start(start), 
		.curLevel(curLevel), 
		.doneCounting(doneCounting), 
		.seg0(seg0), 
		.seg1(seg1)
	);



	initial begin
		// Initialize Inputs
		//Clk1Hz = 0;
		Clk100M=1;
		start = 1;
		curLevel = 1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	always Clk100M = #5 ~Clk100M;

integer counter1Hz;
initial begin
  counter1Hz = 0;
end

always @(posedge Clk100M) begin
$display("In always block that initializes  Clk1Hz") ;
  //if (counter1Hz == 100000000 - 1) begin
  if (counter1Hz == 100 - 1) begin
    counter1Hz <= 0;
    Clk1Hz <= 1;
  end
  else begin
    Clk1Hz <= 0;
    counter1Hz <= counter1Hz + 1;
  end
  //$display("%d", counter1Hz) ;
end

endmodule

