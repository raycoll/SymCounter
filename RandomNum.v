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
  input [31:0] counter,
  output [12:0] randomNum
 );
 
wire feedback =random[12] ^ random[3] ^ random[2] ^ random[0];
reg[12:0] random, random_next, random_done;
reg[3:0] count, count_next;
reg reset;
initial begin
count=0;
count_next=0;
reset=1;
end
 always @(posedge clk or posedge reset) begin
  if(reset) begin
    random<=13'hf; //counter[12:0];
    //$display("reset. random=%d",random);
    reset<=0;
  end
  else begin
    random<={random[11:0], feedback};
  end
  //$display("random %d", random);
 end
 assign randomNum = random;

endmodule

