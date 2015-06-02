module Starter(
          input Clk100M,
          input Clk1Hz,
          input newLevel,
          output reg prelimSig
);

reg start;
initial begin
  start = 1;
  prelimSig = 0;
end

always @(Clk100M) begin
  if (start || newLevel) begin
    prelimSig <= 1;
    start <= 0;  
  end
  else begin
    prelimSig <= 0;
  end
end

endmodule