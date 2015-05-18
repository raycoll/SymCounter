module LevelControl(
    input Clk1Hz,
    input reset,
    input [6:0] symCountDiff,
    output reg [4:0] level,
    output reg levelChng,
    output reg answerPeriod,
    output reg prelimPeriod,
    output reg [2:0] countDownTime,
    output reg postPeriod,
    output reg loss
    );
initial begin
    integer levelDuration=0;
    countDownTime = 0;
    levelChng=0;
    level = 0;
    answerPeriod = 0;
    prelimPeriod = 0;
end

// Move level back to 0 on reset
always @(posedge reset) begin
    levelDuration=0;
    level=0;
    levelChng = 0;
    countDownTime = 0;
    answerPeriod = 0;
    prelimPeriod = 0;
    postPeriod = 0;
end

always @(posedge Clk1hz) begin
  // During the prelim period, we will display a countdown timer before the level starts
  if (levelDuration < 3) begin
    prelimPeriod = 1;
    answerPeriod = 0;
    postPeriod = 0;
    levelChng = 0;
    countDownTime = 3 - levelDuration;
  end
  if (level)
  // After 20 seconds has passed since level start, begin answer period
  else if (levelDuration == 23) begin
    prelimPeriod = 0;
    levelChng = 0;
    postPeriod = 0;
    answerPeriod = 1;
  end
  // After 23 seconds have passed since level start, enter post level period
  else if (levelDuration == 26) begin
    postPeriod = 1;
    answerPeriod = 0;
    levelChng = 0;
    perlimPeriod = 0;
  end
  // After 28 seconds have passed since level start determine if we should go to next level
  else if (levelDuration == 31) begin
    postPeriod = 0;
    if (symCountDiff < 3) begin
      levelChng = 1;
      level = level + 1;
      levelDuration = 0;
    end
    else begin
      levelChng = 0;
      loss = 1;
    end
  end
  // Normal game operation case
  else begin
    preLimPeriod = 0;
    postPeriod = 0;
    answerPeriod = 0;
    levelChng = 0;
  end

  if (levelChng) begin
    levelDuration = 0;
  else if (loss) begin
    // do nothing
  else
    levelDuration = levelDuration + 1;
  end
end

endmodule
