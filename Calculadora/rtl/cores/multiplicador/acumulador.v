module acumulador (
    input clk,
    input LD,
    input ADDB,
    input [31:0] in_sh_B,

    output reg [31:0] resultado
);
    always @(negedge clk) begin
        if (LD) begin
            resultado <= 32'b0;
        end else if (ADDB) begin
            resultado <= resultado + in_sh_B; 
        end 
    end



endmodule