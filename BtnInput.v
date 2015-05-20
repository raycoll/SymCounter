`timescale 1ns / 1ps

module BtnInput(
   input clk,
	 input btnU, // player count up
   input btnD, // player count down
   input btnR, // reset game
   output reg up,
   output reg down,
   output reg reset
    );

	always @(posedge clk or posedge btnU) begin
		if (btnU)
			up <= 1;
		else
			up <= 0;
	end

	always @(posedge clk or posedge btnD) begin
		if (btnD)
			down <= 1;
		else
			down <= 0;
	end

  always @(posedge clk or posedge btnR) begin
    if (btnR)
      reset <= 1;
    else
      rest <= 0;
  end

endmodule
