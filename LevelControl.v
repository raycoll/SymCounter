module LevelControl(
		      input Clk100M,
	        input incLevel,
          output reg newLevel,
          output reg victory,
          output reg [3:0] curLevel,
          output reg [31:0] symGenMax // used to increase symbol generation speed as level increases
);

initial begin
  victory = 0;
  curLevel = 1;
  symGenMax = 100000000; // equates to 1 second for clock division
  newLevel = 1; 
end

always @(posedge Clk100M) begin
	if (incLevel) begin
    if (curLevel == 3) begin // max level is 3 
      victory <= 1;
    end 
    else begin
      curLevel <= curLevel + 1;
      symGenMax <= symGenMax - 50000*curLevel; // increase generation speed as level goes up
      newLevel <= 1;
    end
  end
  else begin
    newLevel <= 0;
  end
end

endmodule