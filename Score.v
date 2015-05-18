module Score(
    input Clk100M,
    input  [6:0] userSymCount,
    input [6:0] actualSymCount,
    input reset,
    output reg [6:0] symCountDiff // 7 bits just cause
    );

initial begin
  integer signedDifference = 0;
end

always @(posedge Clk100M) begin
  signedDifference = userSymCount - actualSymCount;
  if (signedDifference < 0) begin
    symCountDiff = -signedDifference;
  end
  else begin
    symCountDiff = signedDifference;
  end
end

endmodule
