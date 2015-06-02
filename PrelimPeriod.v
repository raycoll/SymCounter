module PrelimPeriod(
          input Clk100M,
          input Clk1Hz,
          input prelimSig,
          input [3:0] curLevel,
          output reg gameSig,
          output [7:0] prelimSeg0,
          output [7:0] prelimSeg1,
          output reg [7:0] prelimSeg2,
          output reg [7:0] prelimSeg3
);

integer periodTime;
//integer periodEnabled;
wire doneCounting;
reg startCountDown;

initial begin
  periodTime = 0;
  //periodEnabled = 0;
  startCountDown = 0;
  gameSig = 0;
  prelimSeg2 = 8'b11111111;
  prelimSeg3 = 8'b11111111;
end

CountDownTimer t(.Clk100M(Clk100M),
                 .Clk1Hz(Clk1Hz),
                 .curLevel(curLevel),
                 .start(startCountDown),
                 .doneCounting(doneCounting),
                 .seg0(prelimSeg0),
                 .seg1(prelimSeg1));

always @(posedge Clk100M) begin
  // set the startCountDown signal when we receive the start prelim period signal
  if (prelimSig) begin
    startCountDown <= 1;
    prelimSeg2 = 8'b11111111;
    prelimSeg3 = 8'b11111111;
  end 
  else begin
    startCountDown <= 0;
  end
  // After countdown timer completes, send the start game period signal
  if (doneCounting) begin
    gameSig <= 1;
  end
  else begin
    gameSig <= 0;
  end
end

endmodule
