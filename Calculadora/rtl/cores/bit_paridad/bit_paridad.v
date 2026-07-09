module bit_paridad (
    input clk,
    input init,
    input rst,
    input [7:0] A,

    output i_0,
    output done
);


wire w_LSB_A;
wire w_Z;

wire load;
wire shift;
wire ADDI;


//Organización de módulos dentro del multipllicador

rsr_A rsr_A ( 
    .clk (clk), .SH(shift), .LD (load), .A (A), // Entradas
    .z (w_Z), .LSB_A (w_LSB_A)//Salidas
    
    );

contador count0 ( 
    .clk (clk), .LD (load), .ADDI (ADDI), // Entradas
    .i_0 (i_0) //Salidas
    
    );

bit_paridad_control control ( 
    .clk (clk), .init (init), .LSB_A (w_LSB_A), .z (w_Z), .rst (rst), // Entradas
    .done (done), .LD (load), .SH (shift), .ADDI (ADDI) //Salidas
    
    );


endmodule
