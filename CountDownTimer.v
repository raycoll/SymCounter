//`include "intToSeg.v"
module CountDownTimer(
              input Clk100M, 
              input Clk1Hz,
              input start,
              input [3:0] curLevel,
              output reg doneCounting,
              output reg [7:0] seg0,
              output reg [7:0] seg1
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

integer curCount;
reg counting;
reg finished;

initial begin
  seg0 = 8'b11111111;
  seg1 = 8'b11111111;
  doneCounting = 0;
  counting = 0;
  curCount = 6;
  finished = 0;
end

always @(posedge Clk100M) begin
  // start signal arrives, begin counting
  if (start && counting == 0) begin
    seg0 <= 8'b11111111;
    seg1 <= 8'b11111111;
    counting <= 1;
  end
  // Done counting, send the signal
  else if (finished && counting == 1) begin
    counting <= 0;
    doneCounting <= 1;
  end
  else begin
    doneCounting <= 0;
  end
end

always @(posedge Clk1Hz) begin
  if (counting && curCount == 6) begin // display level
    seg0 <= 8'b11000111; // L
    seg1 <= intToSeg(curLevel); // levelnum
    curCount <= curCount - 1; //TODO VERIFY THIS FIX
  end
  else if (counting && curCount > 0) begin // normal countdown
    seg0 <= intToSeg(curCount);
    seg0 <= 8'b11111111;
    curCount <= curCount - 1;
    finished <= 0;
  end
  else if (counting && curCount == 0) begin
    finished <= 1;
    curCount <= 6;
  end
  else begin
    finished <= 0;
  end
end

endmodule
