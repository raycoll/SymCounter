`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:13:45 05/18/2015 
// Design Name: 
// Module Name:    RandomNum 
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

module RandomNum(
  input clk,
  input reset,
  input enable,
  output reg [3:0] randomNum
 );
 
 wire randBit;
 assign randBit = ~(randomNum[3] ^ randomNum[2]);
 
 always @(posedge clk or posedge reset) begin
  if(reset)
    randomNum=4'b0000
  else
    randomNum={randomNum[3:1], randBit}  //concat first three bits of randomNum to the random bit
 end


endmodule
