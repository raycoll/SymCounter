module CountDownTimer(
              input Clk1Hz,
              input start,
              output reg doneCounting,
              output reg seg [7:0] 
);

integer curCount;
reg counting;
reg finished;

initial begin
  doneCounting = 0;
  counting = 0;
  curCount = 5;
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
  if (counting && curCount > 0) begin 
    seg <= IntToSeg(curCount);
    curCount <= curCount - 1;
    finished <= 0;
  end
  else if (counting && curCount == 0) begin
    finished <= 1;
    curCount <= 5;
  end
  else begin
    finished <= 0;
  end
end

