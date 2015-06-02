`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   00:12:30 06/02/2015
// Design Name:   GamePeriod
// Module Name:   /home/steven/workspace/SymCounter/gameper_tb.v
// Project Name:  lab4Stevia
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: GamePeriod
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module gameper_tb;

	// Inputs
	reg Clk100M;
	reg Clk1Hz;
	reg gameSig;
	reg [31:0] symGenMax;

	// Outputs
	wire [0:0] startGen;
	wire [0:0] stopGen;
	wire [0:0] answerSig;
	wire [7:0] numSpecial;
	wire [7:0] gameSeg0;
	wire [7:0] gameSeg1;
	wire [7:0] gameSeg2;
	wire [7:0] gameSeg3;

	// Instantiate the Unit Under Test (UUT)
	GamePeriod uut (
		.Clk100M(Clk100M), 
		.Clk1Hz(Clk1Hz), 
		.gameSig(gameSig), 
		.symGenMax(symGenMax), 
		.startGen(startGen), 
		.stopGen(stopGen), 
		.answerSig(answerSig), 
		.numSpecial(numSpecial), 
		.gameSeg0(gameSeg0), 
		.gameSeg1(gameSeg1), 
		.gameSeg2(gameSeg2), 
		.gameSeg3(gameSeg3)
	);
reg start;
	initial begin
		// Initialize Inputs
		Clk100M = 1;
		symGenMax = 50;
		gameSig=0;
	start=1;
		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
	
		always Clk100M = #5 ~Clk100M;
		//always gameSig = #5 gameSig;



integer counter1Hz;
initial begin
  counter1Hz = 0;
end

always @(posedge Clk100M) begin
if(start) begin
	start<=0;
	gameSig<=1;
end  
else begin
	gameSig<=0;
end
  //if (counter1Hz == 100000000 - 1) begin
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

