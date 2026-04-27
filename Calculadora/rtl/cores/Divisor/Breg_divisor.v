module Breg_divisor (
    input clk,
    input LD0,
    input signed [7:0] in_B,
    output signed [7:0] out_B

);
    always @(negedge clk) begin
        if (LD) begin
            out_B = in_B;
        end
    end

endmodule