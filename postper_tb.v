`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:08:00 06/02/2015
// Design Name:   PostPeriod
// Module Name:   /home/steven/workspace/SymCounter/postper_tb.v
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

module postper_tb;

	// Inputs
	reg Clk100M;
	reg Clk1Hz;
	reg postSig;
	reg [7:0] magicSymbolCount;

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
		.magicSymbolCount(magicSymbolCount), 
		.levelComplete(levelComplete), 
		.postSeg0(postSeg0), 
		.postSeg1(postSeg1), 
		.postSeg2(postSeg2), 
		.postSeg3(postSeg3)
	);
	
	
reg start;
	initial begin
		// Initialize Inputs
		Clk100M = 1;
		postSig = 0;
		start=1;
		magicSymbolCount = 27;

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
		postSig<=1;
		start<=0;
	end
	else begin
		postSig<=0;
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

