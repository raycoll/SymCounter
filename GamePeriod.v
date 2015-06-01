module GamePeriod(
          input Clk100M,
          input Clk1Hz,
          input gameSig,
          output startGen,
          output stopGen,
          output answerSig,
          output reg [7:0] gameSeg0,
          output reg [7:0] gameSeg1,
          output reg [7:0] gameSeg2,
          output reg [7:0] gameSeg3
);

// Current game time in seconds
integer gameTime;
reg periodFinished; 

initial begin
  gameTime = 0;
  periodFinished = 0;
  answerSig = 0;
  startGen = 0;
  stopGen = 0;
  gameSeg0 = 8'b11111111;
  gameSeg1 = 8'b11111111;
  gameSeg2 = 8'b11111111;
  gameSeg3 = 8'b11111111;
end




always @(posedge Clk100M) begin
  if (gameSig) begin
    runTiming <= 1;
    startGen <= 1;    
  end
  else begin
    startGen <= 0;
  end

  // send the stop generation signal after the period time is up
  if (periodFinished && runTiming == 1) begin
    runTiming <= 0;
    stopGen <= 1;
  end
  else begin
    stopGen <= 0;
  end
end

always @(posedge Clk1Hz) begin
  // stop the period after 15 seconds
  if (runTiming && !periodFinished && gameTime < 15) begin
    gameTime <= gameTime + 1;
    periodFinished <= 0;
  end
  else if (runtiming && gameTime == 15) begin
    periodFinished <= 1;
    gameTime <= 0;
  end
  else begin
    periodFinished <= 0;
  end
end



endmodule