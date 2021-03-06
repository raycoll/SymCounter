module GamePeriod(
          input Clk100M,
          input Clk1Hz,
          input gameSig,
          input [31:0] symGenMax,
          input [31:0] counter,
          output reg [0:0] startGen,
          output reg [0:0] stopGen,
          output reg [0:0] answerSig,
          output reg [7:0] numSpecial,
          output reg [7:0] gameSeg0,
          output reg [7:0] gameSeg1,
          output reg [7:0] gameSeg2,
          output reg [7:0] gameSeg3
);

// Current game time in seconds
integer gameTime;
reg runTiming;
reg periodFinished; 

// symbol generation module
wire generated, special;
reg generateSymbols;
wire [7:0] generatedSym;
SymGen sg(
      .Clk100M(Clk100M),
      .symGenMax(symGenMax),
      .counter(counter),
      .genSym(generateSymbols),
      .generated(generated),
      .special(special),
      .generatedSym(generatedSym)
);

initial begin
  gameTime = 0;
  periodFinished = 0;
  answerSig = 0;
  startGen = 0;
  stopGen = 0;
  generateSymbols = 0;
  numSpecial = 0;
  gameSeg0 = 8'b11111111;
  gameSeg1 = 8'b11111111;
  gameSeg2 = 8'b11111111;
  gameSeg3 = 8'b11111111;
end

always @(posedge Clk100M) begin
  if (gameSig) begin
    gameSeg0 <= 8'b11111111;
    gameSeg1 <= 8'b11111111;
    gameSeg2 <= 8'b11111111;
    gameSeg3 <= 8'b11111111;
    numSpecial <= 0;
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
    answerSig <= 1;
  end
  else begin
    stopGen <= 0;
    answerSig <= 0;
  end

  // move over the digits if we generated a symbol
  if (generated) begin
    // increment the special count if we generated a special symbol
    if (special) begin
      numSpecial <= numSpecial + 1;
    end

    gameSeg3 <= gameSeg2;
    gameSeg2 <= gameSeg1;
    gameSeg1 <= gameSeg0;
    gameSeg0 <= generatedSym;
  end
end

always @(posedge Clk1Hz) begin
  // stop the period after 15 seconds
  if (runTiming && !periodFinished && gameTime < 14) begin
    generateSymbols <= 1;
    gameTime <= gameTime + 1;
    periodFinished <= 0;
  end
  else if (runTiming && gameTime == 14) begin
    generateSymbols <= 0; // stop generating 1 second before moving to answer period
    gameTime <= gameTime +1;
  end
  else if (runTiming && gameTime == 15) begin
    generateSymbols <= 0;
    periodFinished <= 1;
    gameTime <= 0;
  end
  else begin
    generateSymbols <= 0;
    periodFinished <= 0;
  end
end

endmodule