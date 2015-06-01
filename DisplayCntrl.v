module DisplayCntrl(
                input Clk100M,
                input lose,
                input pre,
                input game,
                input answer,
                input post,
                input [7:0] prelimSeg0,
                input [7:0] prelimSeg1,
                input [7:0] prelimSeg2,
                input [7:0] prelimSeg3,
                input [7:0] gameSeg0,
                input [7:0] gameSeg1,
                input [7:0] gameSeg2,
                input [7:0] gameSeg3,
                input [7:0] answerSeg0,
                input [7:0] answerSeg1,
                input [7:0] answerSeg2,
                input [7:0] answerSeg3,
                input [7:0] postSeg0,
                input [7:0] postSeg1,
                input [7:0] postSeg2,
                input [7:0] postSeg3,
                output reg [7:0] segOut0,
                output reg [7:0] segOut1,
                output reg [7:0] segOut2,
                output reg [7:0] segOut3
);

initial begin
 segOut0 = 8'b11111111;
 segOut1 = 8'b11111111;
 segOut2 = 8'b11111111;
 segOut3 = 8'b11111111;
end

always @(posedge Clk100M) begin
  if (lose) begin
    segOut0 <= 8'b11000111; // L
    segOut1 <= 8'b11000000; // O
    segOut2 <= 8'b10010010; // S 
    segOut3 <= 8'b10000110; // E
  end
  else if (pre) begin
    segOut0 <= prelimSeg0;
    segOut1 <= prelimSeg1;
    segOut2 <= prelimSeg2;
    segOut3 <= prelimSeg3;
  end
  else if (game) begin
    segOut0 <= gameSeg0;
    segOut1 <= gameSeg1;
    segOut2 <= gameSeg2;
    segOut3 <= gameSeg3;  
  end 
  else if (answer) begin
    segOut0 <= answerSeg0;
    segOut1 <= answerSeg1;
    segOut2 <= answerSeg2;
    segOut3 <= answerSeg3;
  end 
  else if (post) begin
    segOut0 <= postSeg0;
    segOut1 <= postSeg1;
    segOut2 <= postSeg2;
    segOut3 <= postSeg3;
  end
  else begin
    segOut0 <= 8'b00000000;
    segOut1 <= 8'b00000000;
    segOut2 <= 8'b00000000;
    segOut3 <= 8'b00000000;
  end
end

/*
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
end */

endmodule
