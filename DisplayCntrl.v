
module DisplayCntrl(
  input Clk1Hz,
  input ClkGen,
	input ClkDisp,
  input prelimPeriod,
  input gamePeriod,
  input answerPeriod,
  input postPeriod,
  input lose,
  input [6:0] userCount,
  input [6:0] gameCount,
  input [6:0] countDifference, // aka SCORE
  input [3:0] countDownTime,
  input [4:0] level,
  input [7:0] generatedSymbol,
	output reg [7:0] seg,
  output reg [3:0] an
);
`include "IntToSeg.v"

// Registers that hold each digit of the display
reg [7:0] dig0;
reg [7:0] dig1;
reg [7:0] dig2;
reg [7:0] dig3;

reg [1:0] dispCount;
integer postCount;
reg [3:0] tempTens;
reg [3:0] tempOnes;

initial begin
 dispCount=2'b00;
 dig0=8'b11000000;
 dig1=8'b11111111;
 dig2=8'b11111111;
 dig3=8'b11111111;
 an = 4'b1111;
 postCount = 0;
end


// Clear digits when game mode starts
always @(posedge gamePeriod) begin
  dig0=8'b11111111;
  dig1=8'b11111111;
  dig2=8'b11111111;
  dig3=8'b11111111;
end

// Move symbols during normal game mode
// TODO: does this work?
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
    dig1 = intToSeg(countDownTime);
  end
end

// Display all zeroes during answer period
always @(posedge answerPeriod) begin
  dig0=8'b11000111;
  dig1=8'b11000111;
  dig2=8'b11000111;
  dig3=8'b11000111;
end

// Initialize count for start of post level period
always @(posedge postPeriod) begin
  postCount = 0;
end

// Display user count, expected count, difference during post period
always @(posedge Clk1Hz or posedge postPeriod) begin
  case(postCount)
    0: begin // P1 Sym Count
        dig0=8'b1001100; // P
        dig1=8'b11111111; // blank
        dig2=intToSeg(userCount / 10); // user count tens
        dig3=intToSeg(userCount % 10); // user count ones
        end
    1: begin // Game Sym Count
          dig0=8'b10010010; // S
          dig1=8'b11111111; // blank
          dig2=intToSeg(gameCount / 10); // game count tens
          dig3=intToSeg(gameCount % 10); // game count ones
        end
    2: begin // Difference
          dig0=8'b1010001; // d
          dig1=8'b11111111; // blank
          dig2=intToSeg(countDifference / 10); // diff tens
          dig3=intToSeg(countDifference % 10); // diff ones
        end
    3: begin
          // Output lose if user lost
          if (lose) begin
            dig0=8'b11000111; // L
            dig1=8'b11000000; // O
            dig2=8'b10010010; // S
            dig3=8'b10000110; // E
          end
          // Display underscores if user advanced
          else begin
            dig0=8'b11101111;
            dig1=8'b11101111;
            dig2=8'b11101111;
            dig3=8'b11101111;
          end
        end
    default: begin
                  dig0=8'b11111111;
                  dig1=8'b11111111;
                  dig2=8'b11111111;
                  dig3=8'b11111111;
                end
    endcase
  if (postCount == 3 && lose == 1) begin
    // freeze game if the user lost(keep displaying LOSE)
  end
  else begin
    postCount = postCount + 1;
  end
end

// Fast clock sensitive block used to display the currect contents of the dig registers
always @(posedge ClkDisp) begin
  if(dispCount==2'b00) begin
    an=4'b0111;
    dispCount = dispCount + 1;
  end
  else if(dispCount==2'b01) begin
    an=4'b1011;
    dispCount = dispCount + 1;
  end
  else if(dispCount==2'b10) begin
    an=4'b1101;
    dispCount = dispCount + 1;
  end
  else if(dispCount==2'b11) begin
    an=4'b1110;
    dispCount = 2'b00;
  end

  // Display current digit
	case (dispCount)
    0: seg <= dig0;
    1: seg <= dig1;
    2: seg <= dig2;
    3: seg <= dig3;
    default seg <= 8'b11111111;
	endcase
end

endmodule
>>>>>>> Adds symgen logic
