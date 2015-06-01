module GamePeriod(
          input Clk1Hz,
          input gameSig,
          output answerSig,
          output reg [7:0] gameSeg0,
          output reg [7:0] gameSeg1,
          output reg [7:0] gameSeg2,
          output reg [7:0] gameSeg3
);