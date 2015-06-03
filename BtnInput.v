`timescale 1ns / 1ps

module BtnInput(
   input clk,
	 input btnU, // player count up
   input btnD, // player count down
   input btnS, // start game
   output reg up,
   output reg down,
   output reg start
    );

	always @(posedge clk) begin
		if (btnU)
			up <= 1;
		else
			up <= 0;
	end

	always @(posedge clk) begin
		if (btnD)
			down <= 1;
		else
			down <= 0;
	end

  always @(posedge clk) begin
    if (btnS)
      start <= 1;
    else
      start <= 0;
  end

endmodule
