`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////

module Display(
        input ClkDisp,
        input wire [7:0] seg0,
        input wire [7:0] seg1,
        input wire [7:0] seg2,
        input wire [7:0] seg3,
        output reg [7:0] segOut,
        output reg [7:0] anOut
);

reg [1:0] count;

initial begin
  segOut = 8'b11111111;
  anOut = 4'b1111;
  count = 2'b00;
end

always @(posedge ClkDisp) begin
  if (count == 0) begin
    anOut <= 4'b0111;
    segOut <= seg0;
    count <= count + 1;
  end
  else if (count == 1) begin
    anOut <= 4'b1011;
    segOut <= seg1;
    count <= count + 1;
  end
  else if (count == 2) begin
    anOut <= 4'b1101;
    segOut <= seg2;
    count <= count + 1;
  end
  else if (count == 3) begin
    anOut <= 4'b1110;
    segOut <= seg3;
    count <= 2'b00;
  end
  else begin
    // do nothing
  end
end

endmodule
