module LevelControl(
		      input Clk100M,
	        input incLevel,
          output prelimSig,
          output reg newLevel,
          output reg [3:0] curLevel,
          output reg [31:0] symGenMax // used to increase symbol generation speed as level increases
);

initial begin
  curLevel = 1;
  symGenMax = 100000000; // equates to 1 second for clock division
  newLevel = 1; 
end

always @(posedge Clk100M) begin
	if (incLevel) begin
    curLevel <= curLevel + 1;
    symGenMax <= symGenMax - 50000*level; // increase generation speed as level goes up
    newLevel <= 1;
  end
  else begin
    newLevel <= 0;
  end
end

endmodule