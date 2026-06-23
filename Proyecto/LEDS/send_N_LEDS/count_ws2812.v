module count_ws2812 (
    input clk,
    input LD,
    input DEC,

    output reg Z
);

reg [4:0] out;

always @(negedge clk) begin
    if (LD) begin
        out = 24;
    end else if (DEC) begin
        out = out - 1;
    end
        Z = (out == 0); //Señal que se activa una vez el contador llega a 0    
end
    
endmodule