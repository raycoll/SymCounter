module UserCount(
                  input Clk100Mhz,
                  input start,
                  input stop,
                  input up,
                  input down,
                  output reg [7:0] count
);

reg counting;

initial begin
  count = 0;
  counting = 0;
end

always @(posedge Clk100Mhz) begin
  if (stop) begin
    counting <= 0;
  end
  if (start) begin
    counting <= 1;
  end
  if (up && counting) begin
    count <= count + 1;
  end
  if (down && counting) begin
    count <= count + 1;
  end
end