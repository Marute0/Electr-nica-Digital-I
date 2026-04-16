module Areg_multiplicador (
    input clk,
    input LD,
    input signed [15:0] A,
    output reg [15:0] out_A

);
    always @(posedge clk) begin
        if (LD) begin
            out_A = A;
        end
    end

endmodule