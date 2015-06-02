`timescale 1ns / 1ps
module BtnInput(
    input clk, 
    input up,  
    input down,
    output reg downB,
    output reg upB 
);

reg up_sync_0;
reg down_sync_0;
always @(posedge clk) begin
  up_sync_0 <= up;
  down_sync_0 <= down;
end 
reg up_sync_1;
reg down_sync_1;
always @(posedge clk) begin
  up_sync_1 <= up_sync_0;
  down_sync_1 <= down_sync_0;
end

reg [15:0] up_cnt;
reg [15:0] down_cnt;
always @(posedge clk) begin
  if(upB==up_sync_1)
      up_cnt <= 0;
  else
  begin
      up_cnt <= up_cnt + 1'b1;  
      if(up_cnt == 16'hffff) upB <= ~upB;  
  end
  if(downB==down_sync_1)
      down_cnt <= 0;
  else
  begin
      down_cnt <= down_cnt + 1'b1;  
      if(down_cnt == 16'hffff) downB <= ~downB;  
  end
end
endmodule
