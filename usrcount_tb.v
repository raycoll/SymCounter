`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   11:45:52 06/02/2015
// Design Name:   UserCount
// Module Name:   C:/Users/152/SymCounter/usrcount_tb.v
// Project Name:  lab4Stevia
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: UserCount
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module usrcount_tb;

	// Inputs
	reg Clk100M;
	reg start;
	reg stop;
	reg up;
	reg down;

	// Outputs
	wire [7:0] count;

	// Instantiate the Unit Under Test (UUT)
	UserCount uut (
		.Clk100M(Clk100M), 
		.start(start), 
		.stop(stop), 
		.up(up), 
		.down(down), 
		.count(count)
	);

 
 reg blipcheck;
	initial begin
		// Initialize Inputs
		Clk100M = 1;
    blipcheck=1;
		start = 0;
		stop = 0;
		up = 0;
		down = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
  
always Clk100M = #5 ~Clk100M;  // 100 MHz
		
	
integer counter1Hz;
initial begin
  counter1Hz = 0;
end

always @(posedge Clk100M) begin
	if(blipcheck) begin
		prelimSig<=1;
		blipcheck<=0;
	end
	else begin
		prelimSig<=0;
	end
  if (counter1Hz == 100 - 1) begin
    counter1Hz <= 0;
    Clk1Hz <= 1;
  end
  else begin
    Clk1Hz <= 0;
    counter1Hz <= counter1Hz + 1;
  end
end
      
      
endmodule

