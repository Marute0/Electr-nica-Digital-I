module GRB_lsr (
    input clk,
    input LD,
    input SH, 
    input [23:0] GRB, //Entradas

    output reg MSB //Salida
);
    
reg [23:0] GRB_aux;

always @(negedge clk) begin
    if (LD) begin
        GRB_aux = GRB;
    end else if (SH) begin
        GRB_aux = GRB_aux << 1;
    end

    MSB = GRB_aux[23];
end

endmodule