module GamePlay(
                input Clk100Mhz,
                input Clk1Hz,
                input ClkDisp,
                input userUp,
                input userDown,
                input reset,
                output reg [7:0] seg0,
                output reg [7:0] seg1,
                output reg [7:0] seg2,
                output reg [7:0] seg3,
                output reg [3:0] an
);

///////////////////////////////////////////
wire [7:0] prelimSeg0;
wire [7:0] prelimSeg1;
wire [7:0] prelimSeg2;
wire [7:0] prelimSeg3;
wire gameSig;
PrelimPeriod pre(
          .Clk100M(Clk100M),
          .Clk1Hz(Clk1Hz),
          .prelimSig(),
          .gameSig(gameSig),
          .prelimSeg0(prelimSeg0),
          .prelimSeg1(prelimSeg1),
          .prelimSeg2(prelimSeg2),
          .prelimSeg3(prelimSeg3));
///////////////////////////////////////////

///////////////////////////////////////////
wire [7:0] gameSeg0;
wire [7:0] gameSeg1;
wire [7:0] gameSeg2;
wire [7:0] gameSeg3;
wire startGen, stopGen, answerSig;
GamePeriod gp(
          .Clk100M(Clk100M),
          .Clk1Hz(Clk1Hz),
          .gameSig(gameSig),
          .startGen(startGen),
          .stopGen(stopGen),
          .answerSig(answerSig),
          .gameSeg0(gameSeg0),
          .gameSeg1(gameSeg1),
          .gameSeg2(gameSeg2),
          .gameSeg3(gameSeg3));
///////////////////////////////////////////


///////////////////////////////////////////
wire [7:0] answerSeg0;
wire [7:0] answerSeg1;
wire [7:0] answerSeg2;
wire [7:0] answerSeg3;
wire postSig, stopCount; 
AnswerPeriod ap(
          .Clk100M(Clk100M),
          .Clk1Hz(Clk1Hz),
          .answerSig(answerSig),
          .postSig(postSig),
          .stopCount(stopCount),
          .answerSeg0(answerSeg0),
          .answerSeg1(answerSeg1),
          .answerSeg2(answerSeg2),
          .answerSeg3(answerSeg3));
///////////////////////////////////////////

///////////////////////////////////////////
wire [7:0] postSeg0;
wire [7:0] postSeg1;
wire [7:0] postSeg2;
wire [7:0] postSeg3;
wire levelComplete;
PostPeriod pp(
          .Clk100M(Clk100M,
          .Clk1Hz(Clk1Hz),
          .postSig(postSig),
          .levelComplete(levelComplete),
          .postSeg0(postSeg0),
          .postSeg1(postSeg1),
          .postSeg2(postSeg2),
          .postSeg3(postSeg3));
///////////////////////////////////////////

///////////////////////////////////////////
wire pre, game, answer, post;
CurPeriod cp(
          .Clk100M(Clk100M),
          .prelimSig(.prelimSig),
          .gameSig(gameSig),
          .answerSig(answerSig),
          .postSig(postSig),
          .pre(pre),
          .game(game),
          .answer(answer),
          .post(post));
///////////////////////////////////////////

///////////////////////////////////////////
DisplayCntrl dc(
                .Clk100M(Clk100M),
                .ClkDisp(ClkDisp),
                .pre(pre),
                .game(game),
                .answer(answer),
                .post(post),
                .prelimSeg0(prelimSeg0),
                .prelimSeg1(prelimSeg1),
                .prelimSeg2(prelimSeg2),
                .prelimSeg3(prelimSeg3),
                .gameSeg0(gameSeg0),
                .gameSeg1(gameSeg1),
                .gameSeg2(gameSeg2),
                .gameSeg3(gameSeg3),
                .answerSeg0(answerSeg0),
                .answerSeg1(answerSeg1),
                .answerSeg2(answerSeg2),
                .answerSeg3(answerSeg3),
                .postSeg0(postSeg0),
                .postSeg1(postSeg1),
                .postSeg2(postSeg2),
                .postSeg3(postSeg3),
                .segOut0(seg0),
                .segOut1(seg1),
                .segOut2(seg2),
                .segOut3(seg3),
                .anOut(an)
                );
///////////////////////////////////////////
endmodule