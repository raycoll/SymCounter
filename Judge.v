module Judge(
          input Clk100M,
          input levelComplete,
          input [4:0] difference,
          output reg incLevel,
          output reg lose
);

initial begin
  incLevel = 0;
  lose = 0;
end

always @(posedge Clk100M) begin
  if (levelComplete) begin
    if (difference) begin
      lose <= 1;
      incLevel <= 0;
    end
    else begin // user passed the level
      incLevel <= 1; 
      lose <= 0;
    end
  end
  else begin
    incLevel <= 0;
  end
  //lose <= 0;
end

endmodule