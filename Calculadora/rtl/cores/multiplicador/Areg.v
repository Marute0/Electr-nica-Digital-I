module Areg (
    input clk,
    input LD,
    input [15:0] A,
    output reg [15:0] out_A

);
    always @(negedge clk) begin
        if (LD) begin
            out_A = A;
        end
    end

endmodule
