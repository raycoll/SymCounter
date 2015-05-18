module SymCount(
    input up,
    input down,
    input reset,
    output reg [6:0] userCount // 7 bits just cause
    );

initial begin
    userCount = 0;
end

always @(posedge reset) begin
    userCount = 0;
end

always @(posedge up) begin
    userCount = userCount + 1;
end

always @(posedge down) begin
    userCount = userCount - 1;
end

endmodule
