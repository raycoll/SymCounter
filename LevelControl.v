module LevelControl(
	    input incLevel,
          output reg [3:0] curLevel,
          output reg [31:0] symGenMax // used to increase symbol generation speed as level increases
);

initial begin
  level = 1;
end

always @(posedge incLevel) begin
  level <= level + 1;
  symGenMax <= symGenMax - 50000*level; // make it harder as level goes up
  incLevel <= 0;
end

endmodule