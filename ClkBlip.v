`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:24 05/27/2015 
// Design Name: 
// Module Name:    ClkBlip 
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
module ClkBlip(
    input clk,
    input levelChng,
	 input answerPeriod,
    input prelimPeriod,
    input postPeriod,
    input reset,
    output answerPeriodB,
    output prelimPeriodB,
    output postPeriodB,
    output resetB,
    output levelChngB
    );
reg curLevelChng=0;
reg curPrelimPeriod=0;
reg curPostPeriod=0;
reg curAnswerPeriod=0;
reg curReset=0;

assign answerPeriodB = ~curAnswerPeriod & answerPeriod;
assign prelimPeriodB = ~curPrelimPeriod & prelimPeriod;
assign postPeriodB = ~curPostPeriod & postPeriod;
assign resetB = ~curReset & reset;
assign levelChngB = ~curLevelChng & levelChng;

always @(posedge clk) begin
	curLevelChng <= levelChng;
	curPrelimPeriod <= prelimPeriod;
	curPostPeriod <= postPeriod;
	curReset <= reset;
	curAnswerPeriod <= answerPeriod;
end

endmodule
