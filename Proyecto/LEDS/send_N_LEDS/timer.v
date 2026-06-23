module timer (
    input clk, 
    input INIT_T, 
    input RST_CMD, 
    input rst,
    input MSB,

    output DOUT, 
    output DONE_T
);

wire [12:0] w_count_out;
wire [12:0] w_data2transfer;
wire w_Z;

wire RST;
wire INC;
wire [1:0] SEL_TIM;

count_out count_out (
    .clk (clk), .RST (RST), .INC (INC), //Entradas

    .count_out (w_count_out) //Salidas
);

mux mux0 (
    .SEL_TIM (SEL_TIM), //Entrada

    .data2transfer (w_data2transfer) //Salidas
);

comp_timer comp_timer (
    .count_out (w_count_out), .data2transfer (w_data2transfer), //Entradas

    .Z (w_Z) //Salidas
);

timer_control timer_control (
    .clk (clk), .rst (rst), .INIT_T (INIT_T), .MSB (MSB), .RST_CMD (RST_CMD), .Z (w_Z), //Entradas

    .RST (RST), .INC (INC), .SEL_TIM (SEL_TIM), .DOUT (DOUT), .DONE_T (DONE_T) //Salidas
);

endmodule

 