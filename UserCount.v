module UserCount(
                  input Clk100M,
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

always @(posedge Clk100M) begin
  if (stop) begin
    counting <= 0;
  end
  else if (start) begin
    count <= 0;
    counting <= 1;
  end
  else if (up && counting) begin
    count <= count + 1;
  end
  else if (down && counting) begin
    count <= count - 1;
  end
  else begin
    //n none
  end
end

endmodule