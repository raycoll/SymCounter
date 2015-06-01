module SymGen(
        input Clk100M,
        input symGenMax, // used to control generation speed
        input genSym, // are we in game period?
        output reg generated, // was symbol generated
        output reg special, // was generated symbol the desired one
        output reg [7:0] generatedSym 
);

integer symGenCount;
wire [7:0] randSym;
integer count;
initial begin
  special = 0;
  count = 0;
  generated = 0;
  symGenCount = 0;
  generatedSym = 8'b11111111;
end


always @(posedge Clk100M) begin
  // generate a new symbol after counting symGenMax times 
  if (genSym && (symGenCount == symGenMax - 1)) begin
    if (count == 9) begin
      count <= 0;
    end

    generated <= 1;
    special <= 1;
    symGenCount <= 0;
    generatedSym <= intToSeg(count);
  end
  else begin
    generated <= 0;
    special <= 0;
    symGenCount <= symGenCount + 1;
  end
end

endmodule
