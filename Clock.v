`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    14:55:29 04/27/2015
// Design Name:
// Module Name:    Clock
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module Clock(
    input Clk100M,
    input reset,
    input levelChng,
    input prelimPeriod,
    input gamePeriod,
    input answerPeriod,
    input postPeriod,
    input [4:0] level,
    output reg ClkSymGen,
    output reg ClkDisp,
    output reg Clk1Hz
    );

initial begin
    // Difficulty is increased by adjusting the SymGen clock via SymGenMax
    integer counterSymGen=0;
    integer SymGenMax= 100000000; // starts at 1 second

    integer counter1Hz=0;
    integer counterDisp=0;
end

always @(posedge reset) begin
  SymGenMax = 100000000;
  counterSymGen = 0;
  counter1Hz = 0;
end

// Update the clock when level changes
always @(posedge levelChng) begin
  SymGenMax = SymGenMax - level * 5000000;
  counterSymGen = 0;
end

// reset 1hz counter when changing period
always @(posedge answerPeriod or posedge prelimPeriod or posedge postPeriod) begin
  counter1Hz = 0;
end

always @(posedge Clk100M) begin
	// ClkSymGen controls the speed of symbol movement/generation
  // This will only be generated during the game period
  if((counterSymGen == SymGenMax - 1) && (gamePeriod)) begin
		counterSymGen=0;
		ClkSymGen=1;
	end
	else begin
		counterSymGen=counterSymGen+1;
		ClkSymGen=0;
	end

  // Keep a 1 HZ clock to keep track of level duration
  if(counter1Hz == 100000000 - 1) begin
    counter1Hz=0;
    Clk1Hz=1;
  end
  else begin
    counter1Hz=counter1Hz + 1;
    Clk1Hz=0;
  end

  // ClkDisp should be fast enough for the 7seg display
	if (counterDisp == 5000000-1) begin
		counterDisp = 0;
		ClkDisp=1;
	end
	else begin
		counterDisp=counterDisp+1;
		ClkDisp=0;
	end

end
endmodule
