`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:15 05/13/2015 
// Design Name: 
// Module Name:    Symbol 
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
module Symbol(
	input reg [3:0] randomNum,
	input ClkSymGen,
	output reg [7:0] generatedSymbol
);

/*initial begin
randomNum=4'b1111;
end
*/
always @(posedge ClkSymGen) begin
	case (randomNum)
		0: generatedSymbol=8'b11101010;
		1: generatedSymbol=8'b11110001;
		2: generatedSymbol=8'b11010110;
		3: generatedSymbol=8'b10001001;
		4: generatedSymbol=8'b10011110;
		5: generatedSymbol=8'b11100101;
		6: generatedSymbol=8'b10110110;
		7: generatedSymbol=8'b10111111;
		8: generatedSymbol=8'b11011010;
		9: generatedSymbol=8'b11010101;
		10: generatedSymbol=8'b11100110;
		11: generatedSymbol=8'b10011101;
		12: generatedSymbol=8'b11111000;
		13: generatedSymbol=8'b10110011;
		14: generatedSymbol=8'b11110100;
		15: generatedSymbol=8'b11101101;
	endcase
	
end


endmodule
