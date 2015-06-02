`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   02:02:09 06/02/2015
// Design Name:   AnswerPeriod
// Module Name:   /home/steven/workspace/SymCounter/answer_tb.v
// Project Name:  lab4Stevia
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: AnswerPeriod
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module answer_tb;

	// Inputs
	reg Clk100M;
	reg Clk1Hz;
	reg answerSig;
	reg [7:0] userCount;

	// Outputs
	wire postSig;
	wire stopCount;
	wire [7:0] answerSeg0;
	wire [7:0] answerSeg1;
	wire [7:0] answerSeg2;
	wire [7:0] answerSeg3;

	// Instantiate the Unit Under Test (UUT)
	AnswerPeriod uut (
		.Clk100M(Clk100M), 
		.Clk1Hz(Clk1Hz), 
		.answerSig(answerSig), 
		.userCount(userCount), 
		.postSig(postSig), 
		.stopCount(stopCount), 
		.answerSeg0(answerSeg0), 
		.answerSeg1(answerSeg1), 
		.answerSeg2(answerSeg2), 
		.answerSeg3(answerSeg3)
	);

reg start;
	initial begin
		// Initialize Inputs
		Clk100M = 1;
		answerSig = 0;
		userCount = 10;
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
		answerSig<=1;
		start<=0;
	end
	else begin
		answerSig<=0;
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

