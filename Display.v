`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:08:01 04/29/2015
// Design Name:
// Module Name:    Display
// Project Name:
// Target Devices:
// Tool versions:
// Description:
//
// Dependencies:
//
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
//
//////////////////////////////////////////////////////////////////////////////////
module Display(
  input Clk1Hz,
  input ClkGen,
	input ClkDisp,
  input prelimPeriod,
  input gamePeriod,
  input answerPeriod,
  input postPeriod,
  input [3:0] countDownTime,
  inpur [4:0] level,
  input [7:0] generatedSymbol,
	output reg [7:0] seg,
  output reg [3:0] an
);

register [7:0] dig0;
register [7:0] dig1;
register [7:0] dig2;
register [7:0] dig3;

register [1:0] count;
initial begin
 count=2'b00;
 dig0=8'b11000000;
 dig1=8'b11111111;
 dig2=8'b11111111;
 dig3=8'b11111111;
 an = 4'b1111;
 integer postCount = 0;
end

// Clear digits when game mode starts
always @(posedge gamePeriod) begin
  dig0=8'b11111111;
  dig1=8'b11111111;
  dig2=8'b11111111;
  dig3=8'b11111111;
end

// Move symbols during normal game mode
always @(posedge ClkGen) begin
  if (gamePeriod) begin
    dig3 <= dig2;
    dig2 <= dig1;
    dig1 <= dig0;
    dig0 <= generatedSymbol;
  end
end

// Display countdown timer during prelim mode
always @(posedge Clk1Hz) begin
  if (prelimPeriod) begin
    dig0=8'b11000111; // make this an "L"
    dig2=8'b11111111;
    dig3=8'b11111111;
    case (countDownTime)
  		0: seg<=8'b11000000;
  		1: seg<=8'b11111001;
  		2: seg<=8'b10100100;
  		3: seg<=8'b10110000;
  		4: seg<=8'b10011001;
  		5: seg<=8'b10010010;
  		default: seg<=8'b11000000;
  end
end

// Display all zeroes during answer period
always @(posedge answerPeriod) begin
  dig0=8'b11000111;
  dig1=8'b11000111;
  dig2=8'b11000111;
  dig3=8'b11000111;
end

always @(posedge postPeriod) begin
  postCount = 0;
end

// Display user count, expected count, difference during post period
always @(posedge Clk1Hz or posedge postPeriod) begin
  case(postCount)
    0: begin // P1 Sym Count
          dig0=8'b11111111;
          dig1=8'b11111111;
          dig2=8'b11111111;
          dig3=8'b11111111;
        end
    1: begin // Game Sym Count
          dig0=8'b11111111;
          dig1=8'b11111111;
          dig2=8'b11111111;
          dig3=8'b11111111;
        end
    2: begin // Difference
          dig0=8'b11111111;
          dig1=8'b11111111;
          dig2=8'b11111111;
          dig3=8'b11111111;
        end
    3: begin // Lose?
          dig0=8'b11111111;
          dig1=8'b11111111;
          dig2=8'b11111111;
          dig3=8'b11111111;
        end
    default: begin
                  dig0=8'b11111111;
                  dig1=8'b11111111;
                  dig2=8'b11111111;
                  dig3=8'b11111111;
                end
    endcase

end

always @(posedge ClkDisp) begin
	if(count==2'b00) begin
		an=4'b0111;
		count=count+1;
	ends
	else if(count==2'b01) begin
		an=4'b1011;
		count=count+1;
	end
	else if(count==2'b10) begin
		an=4'b1101;
		count=count+1;
	end
	else if(count==2'b11) begin
		an=4'b1110;
		count=2'b00;
	end

  // Display current digit
	case (count)
    0: seg <= dig0;
    1: seg <= dig1;
    2: seg <= dig2;
    3: seg <= dig3;
    default seg <= 8'b11111111;
	endcase

end

endmodule
