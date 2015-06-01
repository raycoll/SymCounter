///////////////////////////////////
// Outputs persistent signals to show the current period
////////////////////////////////////
module CurPeriod(
          input Clk100M,
          input prelimSig,
          input gameSig,
          input answerSig,
          input postSig,
          output reg pre,
          output reg game,
          output reg answer,
          output reg post
);

initial begin
  pre = 0;
  game = 0;
  answer = 0;
  post = 0;
end

always @(posedge Clk100M) begin
  if (prelimSig) begin
    pre <= 1;
    game <= 0;
    answer <= 0;
    post <= 0;
  end
  else if (gameSig) begin
    pre <= 0;
    game <= 1;
    answer <= 0;
    post <= 0;
  end
  else if (answerSig) begin
    pre <= 0;
    game <= 0;
    answer <= 1;
    post <= 0; 
  end
  else if (postSig) begin
    pre <= 0;
    game <= 0;
    answer <= 0;
    post <= 1;  
  end
  else begin
    // do nothing
  end
end

endmodule