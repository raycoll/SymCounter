module Judge(
          input levelComplete,
          input [4:0] difference,
          output reg incLevel,
          output reg lose
);

initial begin
  incLevel = 0;
  lose = 0;
end

always @(posedge levelComplete) begin
  if (difference > 2) begin
    lose <= 1;
  end
  else begin
    incLevel <= 1;
  end

  levelComplete <= 0;
end

endmodule