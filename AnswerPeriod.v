module AnswerPeriod(
          input Clk100M,
          input Clk1Hz,
          input answerSig,
          input userCount,
          output reg postSig,
          output reg stopCount,
          output reg [7:0] answerSeg0,
          output reg [7:0] answerSeg1,
          output reg [7:0] answerSeg2,
          output reg [7:0] answerSeg3
);

function [7:0] intToSeg;
input [3:0] number;
  case(number)
    0: intToSeg=8'b11000000;
    1: intToSeg=8'b11111001;
    2: intToSeg=8'b10100100;
    3: intToSeg=8'b10110000;
    4: intToSeg=8'b10011001;
    5: intToSeg=8'b10010010;
    6: intToSeg=8'b10000010;
    7: intToSeg=8'b11011000;
    8: intToSeg=8'b10000000;
    9: intToSeg=8'b10010000;
    default: intToSeg=8'b11111111;
  endcase
endfunction

// Current game time in seconds
integer answerTime;
reg periodFinished;
reg runTiming; 

initial begin
  answerTime = 0;
  periodFinished = 0;
  postSig = 0;
  stopCount = 0;
  answerSeg0 = 8'b11111111;
  answerSeg1 = 8'b11111111;
  answerSeg2 = 8'b11111111;
  answerSeg3 = 8'b11111111;
end

always @(posedge Clk100M) begin
  if (answerSig && runTiming == 0) begin
    answerSeg0 <= 8'b11111111;
    answerSeg1 <= 8'b11111111;
    answerSeg2 <= 8'b11111111;
    answerSeg3 <= 8'b11111111;
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

    // display user count
    answerSeg0 <= intToSeg(userCount / 10);
    answerSeg1 <= intToSeg(userCount % 10);
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