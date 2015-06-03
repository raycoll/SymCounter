module SymGen(
        input Clk100M,
        input [31:0] symGenMax, // used to control generation speed
        //input [127:0] randomNum,
        input genSym, // are we in game period?
        output reg generated, // was symbol generated
        output reg special, // was generated symbol the desired one
        output reg [7:0] generatedSym 
);

wire [12:0] randomNum;
wire rst;
RandomNum rn(
  .clk(Clk100M),
  //.reset(rst),
  .randomNum(randomNum)
);

function [7:0] newSym;
input [12:0] number;
  case(number %16)
    0: newSym=8'b11101010;
		1: newSym=8'b11110001;
		2: newSym=8'b11010110;
		3: newSym=8'b10001001;
		4: newSym=8'b10011110;
		5: newSym=8'b11100101;
		6: newSym=8'b10110110;
		7: newSym=8'b10111111;
		8: newSym=8'b11011010;
		9: newSym=8'b11010101;
		10: newSym=8'b11100110;
		11: newSym=8'b10011101;
		12: newSym=8'b11111000;
		13: newSym=8'b10110011;
		14: newSym=8'b11110100;
		15: newSym=8'b11101101;
    default: newSym=8'b11111101;
  endcase
endfunction


 
integer symGenCount;
wire [7:0] randSym;
//integer count;
reg [3:0] count;
initial begin
  special = 0;
  //count = 0;
  count=4'b0000;
  generated = 0;
  symGenCount = 0;
  generatedSym = 8'b11111111;
end


always @(posedge Clk100M) begin
  // generate a new symbol after counting symGenMax times 
  if (genSym && (symGenCount >= symGenMax - 1)) begin
    generated <= 1;
    //special <= 1;
    symGenCount <= 0;
    generatedSym <= newSym(randomNum);
    if((~generatedSym) & (8'b00000001)) 
      special<=1;
    else
      special<=0;
  end
  else begin
    generated <= 0;
    special <= 0;
    symGenCount <= symGenCount + 1;
  end
end

endmodule
