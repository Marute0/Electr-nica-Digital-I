module Breg (
    input clk,
    input LD0,
    input [7:0] in_B,
    output reg [7:0] out_B

);
    always @(negedge clk) begin
        if (LD0) begin
            out_B = in_B;
        end
    end

endmodule