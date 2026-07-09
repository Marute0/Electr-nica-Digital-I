module div (

    input clk,
    input init,
    input rst,
    input [7:0] A,
    input [7:0] B,

    output [7:0] residuo,
    output [7:0] cociente,
    output done

);

wire [7:0] w_out_A;
wire [7:0] w_out_B;
wire [7:0] w_out_vAux;
wire w_residuo_MSB;
wire [7:0] w_residuo;

wire load;
wire loadResiduo;
wire shift_cociente;
wire dec_I;

wire w_zero;

assign residuo = w_residuo;


//Organización de módulos dentro del multipllicador



lsr_A Areg ( 
    .clk (clk), .LD0 (load), .SH0 (shift), .in_A (A), // Entradas
    .out_sh_A (w_out_A) //Salidas
    
    );

Breg Breg ( 
    .clk (clk), .LD0 (load), .in_B (B), // Entradas
    .out_B (w_out_B) //Salidas
    
    );

lsr_vAux vAuxReg  ( 
    .clk (clk), .LD0 (load), .LD1 (loadResiduo), .SH0 (shift), .SH1 (shift_cociente), .in_A (w_out_A), .residuo (w_residuo), // Entradas
    .out_vAux (w_out_vAux) //Salidas
    
    );

contador_dec cont0 ( 
    .clk (clk), .LD0 (load), .DECI (dec_I), // Entradas
    .zero (w_zero) //Salidas
    
    );

sum_res_comp2 sum_res_comp20 ( 
    .in_B (w_out_B), .in_vAux (w_out_vAux), // Entradas
    .residuo (w_residuo), .residuo_MSB (w_residuo_MSB) //Salidas
    
    );

lsr_cociente cocienteReg ( 
    .clk (clk), .LD0 (load), .LD1 (loadResiduo), .SH1 (shift_cociente),// Entradas
    .out_cociente (cociente) //Salidas
    
    );

div_control control ( 
    .clk (clk), .init (init), .residuo_MSB (w_residuo_MSB), .zero (w_zero), .rst (rst), // Entradas
    .done (done), .LD0 (load), .LD1 (loadResiduo), .SH0 (shift), .SH1 (shift_cociente), .DECI (dec_I) //Salidas
    
    );



endmodule