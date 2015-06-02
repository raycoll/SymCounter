module GamePlay(
                input Clk100M,
                input Clk1Hz,
                input ClkDisp,
                input userUp,
                input userDown,
                input reset,
                output reg [7:0] seg0,
                output reg [7:0] seg1,
                output reg [7:0] seg2,
                output reg [7:0] seg3
);

wire prelimSig; // start signal
///////////////////////////////////////////
wire [7:0] prelimSeg0;
wire [7:0] prelimSeg1;
wire [7:0] prelimSeg2;
wire [7:0] prelimSeg3;
wire gameSig;
PrelimPeriod prelim(
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
wire [7:0] numSpecial;
wire startGen, stopGen, answerSig;
wire [31:0] symGenMax;
GamePeriod gp(
          .Clk100M(Clk100M),
          .Clk1Hz(Clk1Hz),
          .symGenMax(symGenMax),
          .gameSig(gameSig),
          .startGen(startGen),
          .stopGen(stopGen),
          .answerSig(answerSig),
          .numSpecial(numSpecial),
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
          .Clk100M(Clk100M),
          .Clk1Hz(Clk1Hz),
          .postSig(postSig),
          .levelComplete(levelComplete),
          .postSeg0(postSeg0),
          .postSeg1(postSeg1),
          .postSeg2(postSeg2),
          .postSeg3(postSeg3));
///////////////////////////////////////////

///////////////////////////////////////////
wire [7:0] userCount;
UserCount uc(
           .Clk100M(Clk100M),
           .start(startGen),
           .stop(stopGen),
           .up(userUp), // This should be "blips" tied to the 100mhz clk
           .down(userDown),
           .count(userCount));
///////////////////////////////////////////

///////////////////////////////////////////
wire [4:0] difference;
Score s(
          .Clk100M(Clk100M),
          .start(startGen),
          .stop(stopCount),
          .userCount(userCount),
          .magicSymbolCount(numSpecial),
          .difference(difference));
///////////////////////////////////////////

///////////////////////////////////////////
wire incLevel, lose;
Judge j(
          .Clk100M(Clk100M),
          .levelComplete(levelComplete),
          .difference(difference),
          .incLevel(incLevel),
          .lose(lose));

///////////////////////////////////////////

///////////////////////////////////////////
wire newLevel;
wire [3:0] curLevel;
LevelControl lc(
          .Clk100M(Clk100M),
          .incLevel(incLevel),
          .prelimSig(prelimSig),
          .newLevel(newLevel),
          .curLevel(curLevel),
          .symGenMax(symGenMax));
///////////////////////////////////////////

///////////////////////////////////////////
wire pre, game, answer, post;
CurPeriod cp(
          .Clk100M(Clk100M),
          .prelimSig(prelimSig),
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
                .lose(lose),
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
                .segOut3(seg3));
///////////////////////////////////////////
endmodule