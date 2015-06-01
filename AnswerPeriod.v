module AnswerPeriod(
          input Clk1Hz,
          input answerSig,
          output postSig,
          output reg [7:0] answerSeg0,
          output reg [7:0] answerSeg1,
          output reg [7:0] answerSeg2,
          output reg [7:0] answerSeg3
);