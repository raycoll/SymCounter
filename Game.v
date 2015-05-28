`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:24:15 05/13/2015 
// Design Name: 
// Module Name:    Game 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Game(
	input Clk100M,
	input btnS, //reset
	input btnU, //up
	input btnD, //down
	
	//These three are for the block memory generator
	input clka,
	input [1:0] addra,
	output [0:0] douta,
	
	output wire [7:0] seg,
	output wire [3:0] an
 );
 
 Rand block_mem_gen ( //instantiating ROM in top level module
  .clka(clka), // input clka
  .addra(addra), // input [1 : 0] addra
  .douta(douta) // output [0 : 0] douta
);

wire up, down, reset;
wire Clk1Hz;
wire levelChng;
wire [4:0] level;
wire [7:0] generatedSymbol;
wire prelimPeriod, gamePeriod, answerPeriod, postPeriod;
wire ClkGen, ClkDisp;
//wire [3:0] randomNum;
wire [6:0] userCount;
wire [6:0] gameCount;
wire [6:0] countDifference; // aka SCORE
wire [3:0] countDownTime;
wire loss;

BtnInput b(.clk(clk), .btnU(btnU), .btnD(btnD), .btnS(btnS), .up(up), .down(down), .reset(reset));
Clock c(.Clk100M(Clk100M), .reset(reset), .levelChng(levelChng), .prelimPeriod(prelimPeriod), 
.gamePeriod(gamePeriod), .answerPeriod(answerPeriod), .postPeriod(postPeriod), .level(level), .ClkSymGen(ClkSymGen), .ClkDisp(ClkDisp), .Clk1Hz(Clk1Hz));
LevelControl lc(.Clk1Hz(Clk1Hz),.reset(reset), .level(level), .levelChng(levelChng), .answerPeriod(answerPeriod), 
.prelimPeriod(prelimPeriod),.countDownTime(countDownTime),.gamePeriod(gamePeriod), .postPeriod(postPeriod), .loss(loss));
Symbol s(/*.randomNum(randomNum),*/ .ClkSymGen(ClkSymGen), .generatedSymbol(generatedSymbol));
Display d(.Clk1Hz(Clk1Hz), .ClkGen(ClkGen), .ClkDisp(ClkDisp), .prelimPeriod(prelimPeriod), .gamePeriod(gamePeriod), .answerPeriod(answerPeriod), .postPeriod(postPeriod),
  .lose(lose), .userCount(userCount), .gameCount(0), .countDifference(countDifference), .countDownTime(countDownTime), .level(level), .generatedSymbol(generatedSymbol), .seg(seg), .an(an));
UserSymCount u(.up(up), .down(down), .reset(reset), .userCount(userCount));


endmodule
