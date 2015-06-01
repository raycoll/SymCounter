module GamePlay(
                input Clk100Mhz,
                input Clk1Hz,
                input ClkDisp,
                input userUp,
                input userDown,
                input reset,
                output reg [7:0] seg0,
                output reg [7:0] seg1,
                output reg [7:0] seg2,
                output reg [7:0] seg3
);