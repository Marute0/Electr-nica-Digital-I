module contador #(
    parameter width = 4
) (

    input clk,
    input LD,
    input ADDI,

    output reg [width:0] out_i

);

    always @(posedge clk) begin
        if (LD) begin
            out_i <= 0;
        end else if (ADDI) begin
            out_i <= out_i + 1;
        end
    end
    
endmodule