module Score(
          input start,
          input stop,
          input [7:0] userCount,
          input [7:0] magicSymbolCount,
          output [4:0] difference
);

reg counting;

initial begin
  difference = 0;
  counting = 0;
end

always @(posedge Clk100Mhz) begin
  if (stop) begin
    counting <= 0;
  end
  if (start) begin
    difference <= 0;
    counting <= 1;
  end
  if (counting) begin
    difference <= magicSymbolCount - userCount;
  end
end

endmodule