`timescale 1ns / 1ps

module Clock(
    input Clk100M,
    output reg ClkDisp,
    output reg Clk1Hz,
    output reg ClkBtn,
    output reg [31:0] counterBtn
    );

integer counter1Hz;
integer counterDisp;
//integer counterBtn;
initial begin
  counter1Hz = 0;
  counterDisp = 0;
  counterBtn = 0;
end

always @(posedge Clk100M) begin
  if (counter1Hz == 100000000 - 1) begin
    counter1Hz <= 0;
    Clk1Hz <= 1;
  end
  else begin
    Clk1Hz <= 0;
    counter1Hz <= counter1Hz + 1;
  end
  if (counterDisp == 500000 - 1) begin
    counterDisp <= 0;
    ClkDisp <= 1;
  end 
  else begin
    ClkDisp <= 0;
    counterDisp <= counterDisp + 1;
  end 
  if (counterBtn == 150000 - 1) begin
    counterBtn <= 0;
    ClkBtn <= 1;
  end
  else begin
    counterBtn <= counterBtn + 1;
    ClkBtn <= 0;
  end
end

endmodule

/*
// Counter for clock division
integer counterSymGen;
integer SymGenMax;
integer counter1Hz;
integer counterDisp;

// Detect posedge of signals
wire resetB;
wire levelChngB;
wire countingB = resetB || levelChngB; // should we count?
wire periodChangeB = answerPeriodB || prelimPeriodB || postPeriodB; // did the game period change?
ClkBlip(.clk(Clk100M), 
		  .levelChng(levelChng),
		  .answerPeriod(answerPeriod),
		  .prelimPeriod(prelimPeriod),
		  .postPeriod(postPeriod),
		  .reset(reset), 
		  .answerPeriodB(answerPeriodB),
		  .prelimPeriodB(prelimPeriodB),
		  .postPeriodB(postPeriodB),
		  .resetB(resetB), 
		  .levelChngB(levelChngB));
		  
initial begin
    // Difficulty is increased by adjusting the SymGen clock via SymGenMax
    counterSymGen=0;
    SymGenMax= 100000000; // starts at 1 second

    counter1Hz=0;
    counterDisp=0;
end

always @(posedge Clk100M) begin
	if (periodChangeB) begin
		counter1Hz = 0;
	end
	if (levelChngB) begin
		SymGenMax = SymGenMax - level * 5000000;
		counterSymGen = 0;
	end
	if (resetB) begin
		SymGenMax = 100000000;
		counterSymGen = 0;
		counter1Hz = 0;
	end
	
	// ClkSymGen controls the speed of symbol movement/generation
  // This will only be generated during the game period
  if (countingB) begin
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

end
*/

