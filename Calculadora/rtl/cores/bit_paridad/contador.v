module contador (
    input clk,
    input LD,
    input ADDI,

    output reg i_0
);

reg [2:0] count;

    always @(negedge clk) begin
        if (LD) begin
            count <= 3'b0;
        end else if (ADDI) begin
            count <= count + 1; 
        end
        i_0 = count[0];
    end

endmodule
