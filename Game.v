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
  input btnS, //start
  input btnU, //up
  input btnD, //down
  
  //These three are for the block memory generator
 /* input clka,
  input [1:0] addra,
  output [0:0] douta,
 */
 
  output wire [7:0] seg,
  output wire [3:0] an
 );
 
/* Rand block_mem_gen ( //instantiating ROM in top level module
  .clka(clka), // input clka
  .addra(addra), // input [1 : 0] addra
  .douta(douta) // output [0 : 0] douta
);*/
wire Clk1Hz, ClkDisp, ClkBtn, counterBtn;
Clock c(.Clk100M(Clk100M),
            .Clk1Hz(Clk1Hz),
            .ClkDisp(ClkDisp),
            .ClkBtn(ClkBtn),
            .counterBtn(counterBtn));
         
wire up, down, reset;
BtnInput b(.clk(ClkBtn),  
                .btnU(btnU), 
                .btnD(btnD),
                .btnS(btnS),
                .up(up),
                .down(down),
                .start(start));
               
/*RandomNum rn(
  .clk(clk),
  .ranrst(ranrst),
  .randomNum(randomNum)
 );
*/
               
// Clock generation module

wire upB, downB, startB;
BtnBlip bup(.Clk100M(Clk100M),.D(up),.blip(upB)); 
BtnBlip bdown(.Clk100M(Clk100M),.D(down),.blip(downB)); 
BtnBlip bstart(.Clk100M(Clk100M),.D(start),.blip(startB)); 
// Main game play module
wire [7:0] seg0;
wire [7:0] seg1;
wire [7:0] seg2;
wire [7:0] seg3;
GamePlay gp( .Clk100M(Clk100M),
                      .Clk1Hz(Clk1Hz),
                      .ClkDisp(ClkDisp),
                      .userUp(upB),
                      .userDown(downB),
                      //.userStart(startB),
                      .start(startB),
                      .counter(counterBtn),
                      .seg0(seg0),
                      .seg1(seg1),
                      .seg2(seg2),
                      .seg3(seg3));

Display disp(
       .ClkDisp(ClkDisp),
       .start(startB),
        .seg0(seg0),
        .seg1(seg1),
        .seg2(seg2),
        .seg3(seg3),
        .segOut(seg),
        .anOut(an)
);

endmodule
