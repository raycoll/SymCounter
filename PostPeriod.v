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
    postSeg0 = 8'b11111111;
    postSeg1 = 8'b11111111;
    postSeg2 = 8'b11111111;
    postSeg3 = 8'b11111111;
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