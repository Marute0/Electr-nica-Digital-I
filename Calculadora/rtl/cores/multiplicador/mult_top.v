module mult_top
 #(
    parameter width = 4
) (
    input clk,
    input init,
    input rst,
    input [15:0] A,
    input [15:0] B,

    output [31:0] resultado,
    output done
);

wire [15:0] w_out_A;
wire [31:0] w_out_B;

wire load;
wire shift;
wire inc_B;
wire inc_I;


wire w_A_i;
wire [width:0] w_out_i;
wire w_z;



//Organización de módulos dentro del multipllicador



Areg Areg ( 
    .clk (clk), .LD (load), .A (A), // Entradas
    .out_A (w_out_A) //Salidas
    
    );

lsr_B Breg ( 
    .clk (clk), .SH(shift), .LD (load), .B (B), // Entradas
    .out_sh_B (w_out_B) //Salidas
    
    );

multiplex multiplex0 ( 
    .in_i (w_out_i), .A (w_out_A), // Entradas
    .A_i (w_A_i) //Salidas
    
    );

contador cont0 ( 
    .clk (clk), .LD (load), .ADDI (inc_I), // Entradas
    .out_i (w_out_i) //Salidas
    
    );

acumulador acc0 ( 
    .clk (clk), .LD (load), .ADDB (inc_B), .in_sh_B (w_out_B), // Entradas
    .resultado (resultado) //Salidas
    
    );

comparador comp0 ( 
    .clk (clk), .in_i (w_out_i), // Entradas
    .z (w_z) //Salidas
    
    );

mult_control control ( 
    .clk (clk), .init (init), .A_i (w_A_i), .z (w_z), .rst (rst), // Entradas
    .done (done), .LD (load), .SH (shift), .ADDI (inc_I), .ADDB (inc_B) //Salidas
    
    );


endmodule
