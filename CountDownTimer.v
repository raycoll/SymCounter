`include "intToSeg.v"
module CountDownTimer(
              input Clk100M, 
              input Clk1Hz,
              input start,
              input [3:0] curLevel,
              output reg doneCounting,
              output reg seg1 [7:0],
              output reg seg2 [7:0] 
);

integer curCount;
reg counting;
reg finished;

initial begin
  doneCounting = 0;
  counting = 0;
  curCount = 6;
  finished = 0;
end

always @(posedge Clk100M) begin
  // start signal arrives, begin counting
  if (start && counting == 0) begin
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
    seg1 <= IntToSeg(curLevel); // levelnum
    count <= count - 1;
  end
  if (counting && curCount > 0) begin // normal countdown
    seg0 <= IntToSeg(curCount);
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
