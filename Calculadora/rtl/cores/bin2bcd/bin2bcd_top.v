module bin2bcd_top (
    input clk,
    input init,
    input rst,
    input [7:0] A_bin,

    output [11:0] A_bcd,
    output done
);

wire [7:0] w_Abin;
wire [3:0] w_bcd_ones;
wire [3:0] w_bcd_tens;
wire [3:0] w_bcd_hundreds;

wire [3:0] w_ones_comp2;
wire [3:0] w_tens_comp2;
wire [3:0] w_hundreds_comp2;

wire load_reset;
wire load_ones;
wire load_tens;
wire load_hundreds;
wire shift;
wire DEC;

wire w_H;
wire w_T;
wire w_O;
wire w_Z;


lsr_A_res lsr0 ( 
    .clk (clk), .A_bin (A_bin), .ones_comp2 (w_ones_comp2), .tens_comp2 (w_tens_comp2), .hundreds_comp2 (w_hundreds_comp2), .LD0 (load_reset), .LD1 (load_ones), .LD2 (load_tens), .LD3 (load_hundreds), .SH (shift), //Entrada
    .bcd_ones (w_bcd_ones), .bcd_tens (w_bcd_tens), .bcd_hundreds (w_bcd_hundreds), .A_bcd (A_bcd), .out_A (w_Abin) //Salida
);

comp comp_ones ( .bcd (w_bcd_ones), //Entradas

    .Y (w_O) //Salida
);

comp comp_tens ( .bcd (w_bcd_tens), //Entrada

    .Y (w_T) //Salida
);

comp comp_hundreds ( .bcd (w_bcd_hundreds), //Entrada

    .Y (w_H) //Salida
);

contador_dec cont0 ( .clk (clk), .LD0 (load_reset), .DECI (DEC), //Entrada

    .Z (w_Z) //Salida
);

sum_comp2 sum_comp2_hundreds ( .in_bcd (w_bcd_hundreds), //Entrada
    
    .out_bcd (w_hundreds_comp2) //Salida
);

sum_comp2 sum_comp2_tens ( .in_bcd (w_bcd_tens), //Entrada

    .out_bcd (w_tens_comp2) //Salida
);

sum_comp2 sum_comp2_ones ( .in_bcd (w_bcd_ones), //Entrada

    .out_bcd (w_ones_comp2) //Entrada
);

bin2bcd_control control ( .clk (clk), .init (init), .rst (rst) , .O (w_O), .T (w_T), .H (w_H), .Z (w_Z), //Entradas

    .LD0 (load_reset), .LD1 (load_ones), .LD2 (load_tens), .LD3 (load_hundreds), .SH (shift), .DEC (DEC), .done(done) //Salidas
);



endmodule