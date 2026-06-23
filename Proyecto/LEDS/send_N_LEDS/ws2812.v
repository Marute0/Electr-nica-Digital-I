module ws2812 (
    input clk,
    input INIT, 
    input [23:0] GRB, // Codigo de color recibido de la memoria
    input RST_CMD,
    input rst,

    output DONE, 
    output DOUT 
);

wire w_MSB;
wire w_Z;

wire DONE_T;

wire INIT_T;
wire [1:0] SEL;
wire LD;
wire SH;
wire DEC;



GRB_lsr grb_lsr (
    .clk (clk), .LD (LD), .SH (SH), .GRB (GRB), //Entradas

    .MSB (w_MSB) //Salida
);

count_ws2812 count_ws2812 (
    .clk (clk), .LD (LD), .DEC (DEC), //Entradas

    .Z (w_Z) //Salida
);

timer timer (
    .clk (clk), .rst (rst), .INIT_T (INIT_T), .RST_CMD (RST_CMD), .MSB (w_MSB), //Entradas

    .DOUT (DOUT), .DONE_T (DONE_T) //Salidas
);

ws2812_control ws2812_control (
    .clk (clk), .rst (rst), .INIT (INIT),  .Z (w_Z), .DONE_T (DONE_T), //Entradas

    .SH (SH), .INIT_T (INIT_T), .DEC (DEC), .LD (LD), .DONE (DONE) //Salidas
);
    
endmodule