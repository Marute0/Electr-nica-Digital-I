module topMod_multiplicador #(
    parameter width = 4
) (
    input clk,
    input init,
    input signed [15:0] A,
    input signed [15:0] B,

    output [31:0] resultado,
    output done
);

wire signed [15:0] w_out_A;
wire signed [31:0] w_out_B;

wire load;
wire shift;
wire inc_B;
wire inc_I;


wire w_bit_A;
wire [width:0] w_out_i;
wire w_z;



//Organización de módulos dentro del multipllicador



Areg_multiplicador Areg ( 
    .clk (clk), .LD (load), .A (A), // Entradas
    .out_A (w_out_A) //Salidas
    
    );

lsr_B_multiplicador Breg ( 
    .clk (clk), .SH(shift), .LD (load), .B (B), // Entradas
    .out_sh_B (w_out_B) //Salidas
    
    );

multiplex_multiplicador multiplex0 ( 
    .in_i (w_out_i), .A (w_out_A), // Entradas
    .bit_A (w_bit_A) //Salidas
    
    );

contador_multiplicador cont0 ( 
    .clk (clk), .LD (load), .ADDI (inc_I), // Entradas
    .out_i (w_out_i) //Salidas
    
    );

acumulador_multiplicador acc0 ( 
    .clk (clk), .LD (load), .ADDB (inc_B), .in_sh_B (w_out_B), // Entradas
    .resultado (resultado) //Salidas
    
    );

comparador_multiplicador comp0 ( 
    .clk (clk), .in_i (w_out_i), // Entradas
    .z (w_z) //Salidas
    
    );

control_multiplicador control ( 
    .clk (clk), .init (init), .bit_A (w_bit_A), .z (w_z), // Entradas
    .done (done), .LD (load), .SH (shift), .ADDI (inc_I), .ADDB (inc_B) //Salidas
    
    );


endmodule