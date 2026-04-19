module blinking (
    input clk,
    input rst,

    output reg led
);
    
reg [24:0] contador; // 25 bits capaces de contener los ciclos necesarios para el modulo

always @(posedge clk) begin
    if (rst) begin
        contador <= 25000000 - 10;
        led <= 0;
    end else begin
        if (contador >= 25000000) begin
            contador <= 25'b0;
            led <= ~led;
        end else begin
            contador <= contador + 1;
        end
    end 
end

endmodule