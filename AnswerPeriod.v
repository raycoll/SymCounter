module AnswerPeriod(
          input Clk100M,
          input Clk1Hz,
          input answerSig,
          output reg postSig,
          output reg stopCount,
          output reg [7:0] answerSeg0,
          output reg [7:0] answerSeg1,
          output reg [7:0] answerSeg2,
          output reg [7:0] answerSeg3
);

// Current game time in seconds
integer answerTime;
reg periodFinished;
reg runTiming; 

initial begin
  answerTime = 0;
  periodFinished = 0;
  postSig = 0;
  stopCount = 0;
  answerSeg0 = 8'b00000000;
  answerSeg1 = 8'b00000000;
  answerSeg2 = 8'b00000000;
  answerSeg3 = 8'b00000000;
end

always @(posedge Clk100M) begin
  if (answerSig && runTiming == 0) begin
    runTiming <= 1;    
  end
  // send the stop generation signal after the period time is up
  else if (periodFinished && runTiming == 1) begin
    runTiming <= 0;
    stopCount <= 1;
    postSig <= 1;
  end
  else begin
    stopCount <= 0;
    postSig <= 0;
  end
end

always @(posedge Clk1Hz) begin
  // stop the answer period after 5 seconds
  if (runTiming && !periodFinished && answerTime < 5) begin
    answerTime <= answerTime + 1;
    periodFinished <= 0;
  end
  else if (runTiming && answerTime == 5) begin
    periodFinished <= 1;
    answerTime <= 0;
  end
  else begin
    periodFinished <= 0;
  end
end

endmodule