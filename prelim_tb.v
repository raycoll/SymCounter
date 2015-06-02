`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   20:23:31 06/01/2015
// Design Name:   PrelimPeriod
// Module Name:   /home/steven/workspace/SymCounter/prelim_tb.v
// Project Name:  lab4Stevia
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: PrelimPeriod
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module prelim_tb;

	// Inputs
	reg Clk100M;
	reg Clk1Hz;
	reg prelimSig;
	reg [3:0] curLevel;

	// Outputs
	wire gameSig;
	wire [7:0] prelimSeg0;
	wire [7:0] prelimSeg1;
	wire [7:0] prelimSeg2;
	wire [7:0] prelimSeg3;

	// Instantiate the Unit Under Test (UUT)
	PrelimPeriod uut (
		.Clk100M(Clk100M), 
		.Clk1Hz(Clk1Hz), 
		.prelimSig(prelimSig), 
		.curLevel(curLevel), 
		.gameSig(gameSig), 
		.prelimSeg0(prelimSeg0), 
		.prelimSeg1(prelimSeg1), 
		.prelimSeg2(prelimSeg2), 
		.prelimSeg3(prelimSeg3)
	);
	
reg start;
	initial begin
		// Initialize Inputs
		prelimSig = 0;
		curLevel = 1;
		Clk100M=1;
		start=1;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
		always Clk100M = #5 ~Clk100M;  // 100 MHz
		
	
integer counter1Hz;
initial begin
  counter1Hz = 0;
end

always @(posedge Clk100M) begin
	if(start) begin
		prelimSig<=1;
		start<=0;
	end
	else begin
		prelimSig<=0;
	end
  if (counter1Hz == 100 - 1) begin
    counter1Hz <= 0;
    Clk1Hz <= 1;
  end
  else begin
    Clk1Hz <= 0;
    counter1Hz <= counter1Hz + 1;
  end
end
      
endmodule

