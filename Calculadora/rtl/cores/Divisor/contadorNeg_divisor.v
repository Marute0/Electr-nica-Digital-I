module contadorNeg_divisor #(
    parameter width = 4
) (

    input clk,
    input LD0,
    input DECI,

    output reg [width:0] out_i
    output zero

);

    always @(negedge clk) begin
        if (LD0) begin
            out_i <= 8;
        end else if (DECI) begin
            out_i <= out_i - 1;
        end
    end

    //Señal que ocurre una vez el contador llega a 0

    if (out_i == 0) begin
        assign zero = 1;
    end else begin
        assign zero = 0;
    end
    
endmodule