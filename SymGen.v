module SymGen(
        input Clk100M,
        input [31:0] symGenMax, // used to control generation speed
        input genSym, // are we in game period?
        output reg generated, // was symbol generated
        output reg special, // was generated symbol the desired one
        output reg [7:0] generatedSym 
);

function [7:0] intToSeg;
input [3:0] number;
  case(number)
    0: intToSeg=8'b11000000;
    1: intToSeg=8'b11111001;
    2: intToSeg=8'b10100100;
    3: intToSeg=8'b10110000;
    4: intToSeg=8'b10011001;
    5: intToSeg=8'b10010010;
    6: intToSeg=8'b10000010;
    7: intToSeg=8'b11011000;
    8: intToSeg=8'b10000000;
    9: intToSeg=8'b10010000;
    default: intToSeg=8'b11111111;
  endcase
endfunction

integer symGenCount;
wire [7:0] randSym;
//integer count;
reg [3:0] count;
initial begin
  special = 0;
  //count = 0;
  count=3'b000;
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
    else begin
      count <= count+1;
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
