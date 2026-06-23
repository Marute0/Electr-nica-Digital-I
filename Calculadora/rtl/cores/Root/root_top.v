module root_top (

    input clk,
    input init,
    input rst,
    input [7:0] A,

    output [7:0] raiz,
    output done

);
wire [7:0] w_raiz;
wire [7:0] w_vAux;
wire [7:0] w_rParcial;
wire w_residuo_MSB;
wire [7:0] w_residuo;

wire load;
wire loadResiduo;
wire shift2_vAux_A;
wire shift;
wire DEC;

wire w_zero;

assign raiz = w_raiz;



//Organización de módulos dentro del multipllicador

lsr2_vAux_A A_vAuxreg ( 
    .clk (clk), .LD (load), .SH0 (shift2_vAux_A), .LDRes(loadResiduo), .in_A (A), .residuo (w_residuo), // Entradas
    .v_Aux (w_vAux) //Salidas
    
    );

lsr2_rParcial rParcialreg ( 
    .clk (clk), .LD (load), .SH1 (shift), .DECI (DEC), .raiz(w_raiz),// Entradas
    .out_rParcial (w_rParcial) //Salidas
    
    );

lsr_raiz raizReg (
    .clk (clk), .LD (load), .SH1 (shift), .LDRes (loadResiduo), // Entradas
    .raiz (w_raiz) //Salidas
    
    );


contador_dec cont0 ( 
    .clk (clk), .LD0 (load), .DECI (DEC), // Entradas
    .zero (w_zero) //Salidas
    
    );

sum_res_comp2 sum_res_comp20 ( 
    .in_B (w_rParcial), .in_vAux (w_vAux), // Entradas
    .residuo (w_residuo), .residuo_MSB (w_residuo_MSB) //Salidas
    
    );

root_control control ( 
    .clk (clk), .init (init), .residuo_MSB (w_residuo_MSB), .zero (w_zero), .rst (rst), // Entradas
    .done (done), .LD (load), .LDRes (loadResiduo), .SH0 (shift2_vAux_A), .SH1 (shift), .DEC (DEC) //Salidas
    
    );



endmodule