module CountDownTimer(
              input Clk1Hz,
              input start,
              output reg doneCounting,
              output reg seg [7:0] 
);

initial begin
  doneCounting = 0;
end

always @(posedge Clk100M) begin
  
end

