module led_mem (
    input clk,
    input [9:0] addr, //Dirección a leer

    output reg [23:0] GRB //Código de color leido de la memoria
);

reg [23:0] LED_MEM [0:63];

initial begin
    $readmemh("led_green.hex", LED_MEM);
end

always @(negedge clk) begin
   GRB = LED_MEM[addr]; 
end



endmodule