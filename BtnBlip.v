`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:39:55 06/01/2015 
// Design Name: 
// Module Name:    BtnBlip 
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
module BtnBlip(
        input Clk100M,
        input up,
        input down,
        output reg upB,
        output reg downB
);

reg curUp, curDown;
initial begin
  upB = 0;
  downB = 0;
  curUp = 0;
  curDown = 0;
end

always @(Clk100M) begin
  if ((up == 1) && (curUp == 0)) begin
    upB <= 1;
    curUp <= 1;
  end
  else if ((up == 1) && (curUp == 1)) begin
    upB <= 0;
  end
  else begin
    upB <= 0;
    curUp <= 0;
  end

  if ((down == 1) && (curDown == 0)) begin
    downB <= 1;
    curDown <= 1;
  end
  else if ((down == 1) && (curDown == 1)) begin
    downB <= 0;
  end
  else begin
    downB <= 0;
    curDown <= 0;
  end  

end

endmodule
