module send_LEDS (
    input clk,
    input INIT_M,
    input rst,
    input RST_CMD,

    output DONE_M,
    output DOUT
);

wire [9:0] w_addr;
wire [23:0] w_GRB;

wire w_Z;
wire w_DONE_LED;

wire INIT_LED;
wire RST;
wire INC;


    
led_mem led_mem0 (
    .clk (clk), .addr (w_addr), //Entrada
    .GRB (w_GRB) //Salida
);

count_addr count_addr0 (
    .clk (clk), .RST (RST), .INC (INC), //Entrada
    .addr (w_addr) //Salida

);

comp_send_LEDS comp0 (
    .addr (w_addr), //Entrada
    .Z (w_Z) //Salida
);

ws2812 ws2812 (
    .clk (clk), .rst (rst), .INIT (INIT_LED), .GRB (w_GRB), .RST_CMD (1'b0), //Entrada
    .DONE (w_DONE_LED), .DOUT (DOUT) //Salida
);

send_LEDS_control send_LEDS_control (
    .clk(clk), .rst (rst), .INIT_M (~INIT_M), .DONE_LED (w_DONE_LED), .Z (w_Z), //Entrada
    .DONE_M (DONE_M), .INC (INC), .RST (RST), .INIT_LED (INIT_LED)

);


endmodule