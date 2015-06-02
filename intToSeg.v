module intToSegMod();

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
endmodule