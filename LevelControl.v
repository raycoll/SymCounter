module LevelControl(
    input Clk1Hz,
    input reset,
    input [6:0] symCountDiff,
    output reg [4:0] level,
    output reg levelChng,
    output reg answerPeriod,
    output reg prelimPeriod,
    output reg [2:0] countDownTime,
    output reg gamePeriod,
    output reg postPeriod,
    output reg loss
    );

integer levelDuration;
initial begin
    levelDuration=0;
    countDownTime = 0;
    levelChng=0;
    level = 0;
    answerPeriod = 0;
    prelimPeriod = 0;
    gamePeriod = 0;
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
    gamePeriod = 0;
end

always @(posedge Clk1Hz) begin
  // During the prelim period, we will display a countdown timer before the level starts
  if (levelDuration < 3) begin
    prelimPeriod = 1;
    answerPeriod = 0;
    gamePeriod = 0;
    postPeriod = 0;
    levelChng = 0;
    countDownTime = 3 - levelDuration;
  end
  // After prelim period, enter game period for 20 seconds
  else if (levelDuration < 23) begin
    prelimPeriod = 0;
    answerPeriod = 0;
    gamePeriod = 1;
    postPeriod = 0;
    levelChng = 0;
  end
  // After 20 seconds of game period, enter answer period
  else if (levelDuration > 22 && levelDuration < 26) begin
    prelimPeriod = 0;
    levelChng = 0;
    gamePeriod = 0;
    postPeriod = 0;
    answerPeriod = 1;
  end
  // After 3 seconds of answer period, enter post level period
  else if (levelDuration > 25 && levelDuration < 31) begin
    postPeriod = 1;
    answerPeriod = 0;
    gamePeriod = 0;
    levelChng = 0;
    prelimPeriod = 0;
  end
  // After 5 seconds of post level period, determine level outcome
  else if (levelDuration == 31) begin
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
  else begin
    prelimPeriod = 0;
    postPeriod = 0;
    answerPeriod = 0;
    levelChng = 0;
  end

  // Reset the level duration if the user won, freeze it if user lost, o.w. increment it
  if (levelChng) begin
    levelDuration = 0;
	end
  else if (loss) begin
    // do nothing
	end
  else begin
    levelDuration = levelDuration + 1;
  end
end

endmodule
