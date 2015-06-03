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
  //input reg reset,
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
    random<=13'hF;
    //$display("reset. random=%d",random);
    reset<=0;
  end
  else begin
    random<={random[11:0], feedback};
  end
  $display("random %d", random);
 end
 assign randomNum = random;

endmodule

/*
module RandomNum(
  input clk,
  input reset,
  output [127:0] randomNum
 );
 
wire feedback =random[127] ^ random[125] ^ random[100] ^ random[98];
reg[127:0] random, random_next, random_done;
reg[127:0] count, count_next;
initial begin
count=0;
count_next=0;
end
 always @(posedge clk or posedge reset) begin
  if(reset) begin
    random<=8'hffffffff;
    $display("reset. random=%d",random);
    count <=0;
  end
  else begin
    random <= random_next;
    count<=count_next;
    
  end
 end
 
 always @(*) begin
  random_next= random;
  count_next=count;
 
  random_next={random[126:0], feedback};
  count_next=count+1;
  if(count==128) begin
  $display("count max");
    count=0;
    random_done=random;
    $display("random_done %d", random_done);
  end
  
  $display("count %d", count);
 end
 
 assign randomNum = random_done;


endmodule
*/
/*module RandomNum(
  input clk,
  input reset,
  output [3:0] randomNum
 );
 
wire feedback =random[3] ^ random[2];
reg[3:0] random, random_next, random_done;
reg[3:0] count, count_next;
initial begin
count=0;
count_next=0;
end
 always @(posedge clk or posedge reset) begin
  if(reset) begin
    random<=4'b1111;
    $display("reset. random=%d",random);
    count <=0;
  end
  else begin
    random <= random_next;
    count<=count_next;
    
  end
 end
 
 always @(*) begin
  random_next= random;
  count_next=count;
 
  random_next={random[2:0], feedback};
  count_next=count+1;
  if(count==4) begin
  $display("count is 4");
    count=0;
    random_done=random;
    $display("random_done %d", random_done);
  end
 end
 
 assign randomNum = random_done;


endmodule*/
