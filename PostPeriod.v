module PostPeriod(
          input Clk100M,
          input Clk1Hz,
          input postSig,
          input [7:0] magicSymbolCount,
          output reg levelComplete,
          output reg [7:0] postSeg0,
          output reg [7:0] postSeg1,
          output reg [7:0] postSeg2,
          output reg [7:0] postSeg3
);
// Current game time in seconds
integer postTime;
reg periodFinished; 
reg runTiming;

initial begin
  runTiming=0;
  postTime = 0;
  periodFinished = 0;
  //stopCount = 0;
  postSeg0 = 8'b11111111;
  postSeg1 = 8'b11111111;
  postSeg2 = 8'b11111111;
  postSeg3 = 8'b11111111;
end

always @(posedge Clk100M) begin
  if (postSig && runTiming == 0) begin
    runTiming <= 1;    
  end
  // send the stop generation signal after the period time is up
  else if (periodFinished && runTiming == 1) begin
    runTiming <= 0;
    levelComplete <= 1;
  end
  else begin
    levelComplete <= 0;
  end

  // display the actual number of desired symbols generated
  postSeg0 <= intToSeg(magicSymbolCount / 10);
  postSeg1 <= intToSeg(magicSymbolCount % 10);
end

always @(posedge Clk1Hz) begin
  // stop the post period after 5 seconds
  if (runTiming && !periodFinished && postTime < 5) begin
    postTime <= postTime + 1;
    periodFinished <= 0;
  end
  else if (runTiming && postTime == 5) begin
    periodFinished <= 1;
    postTime <= 0;
  end
  else begin
    periodFinished <= 0;
  end
end

endmodule