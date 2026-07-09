module contador_dec (

    input clk,
    input LD0,
    input DECI,

    output reg zero

);

reg [7:0] out;

    always @(negedge clk) begin
        if (LD0) begin
            out <= 8;
        end else if (DECI) begin
            out <= out - 1;
        end

        assign zero = (out == 0);     //Señal que se activa una vez el contador llega a 0
    end



    
endmodule