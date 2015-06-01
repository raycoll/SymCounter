module PrelimPeriod(
          input Clk1Hz,
          input prelimSig,
          output gameSig,
          output reg [7:0] prelimSeg0,
          output reg [7:0] prelimSeg1,
          output reg [7:0] prelimSeg2,
          output reg [7:0] prelimSeg3
);

integer periodTime;
reg periodEnabled;
wire doneCounting;
initial begin
  periodTime = 0;
  periodEnabled = 0;
  prelimSeg1 = 8'b11111111;
  prelimSeg2 = 8'b11111111;
  prelimSeg3 = 8'b11111111;
  prelimSeg0 = 8'b11111111;
end

CountDownTimer t(.Clk1Hz(Clk1Hz),
                 .start(),
                 .done(),
                 .seg(prelimSeg0));

always @(posedge Clk100M) begin
  if (prelimSig) begin
    periodEnabled <= 1;
    periodTime <= 0;
  end 
  if (doneCounting) begin
    
  end
end

always @(posedge Clk1Hz) begin
  if (periodEnabled) begin
    


  end
end
