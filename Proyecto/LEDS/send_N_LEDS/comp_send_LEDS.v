module comp_send_LEDS (
    input [9:0] addr,

    output reg Z
);

parameter N_LEDS = 10'b0100000000;

always @(*) begin
    if (addr == N_LEDS) begin
        Z = 1;
    end else begin
        Z = 0;
    end
end
    
endmodule