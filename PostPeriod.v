module PostPeriod(
          input Clk1Hz,
          input postSIg,
          output levelComplete,
          output reg [7:0] postSeg0,
          output reg [7:0] postSeg1,
          output reg [7:0] postSeg2,
          output reg [7:0] postSeg3
);