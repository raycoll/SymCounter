module Starter(
          input Clk100M,
          input Clk1Hz,
          input newLevel,
          input start,
          output reg prelimSig
);

reg started;
initial begin
  started = 0;
  prelimSig = 0;
end

always @(Clk100M) begin
  if (start && !started) begin
    started <= 1;
    prelimSig <= 1;
  end
  else if (newLevel) begin
    prelimSig <= 1;
  end
  else begin 
    prelimSig <= 0;
  end
end

endmodule