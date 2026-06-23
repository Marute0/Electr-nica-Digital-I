module lsr2_rParcial (
    input clk,
    input LD,
    input SH1,
    input DECI,
    input [7:0] raiz,

    output reg [7:0] out_rParcial
);

always @(negedge clk) begin
    if (LD) begin
        out_rParcial = 8'b00000001;
    end else if (SH1) begin
        out_rParcial[7:0] = {out_rParcial[5:0], 2'b01};
    end else if (DECI) begin
        out_rParcial = raiz;
    end
end
    
endmodule