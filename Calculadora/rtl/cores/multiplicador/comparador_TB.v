`timescale 10ns / 10ns
`define SIMULATION

module comparador_TB;

reg [4:0] in_i;

wire z;

// Inicialización del modulo

comparador uut ( 
    .in_i (in_i), // Entradas
    .z (z) //Salidas
    
    );


initial begin
    $dumpfile("comparador_TB.vcd");
    $dumpvars(-1, comparador_TB);

    $monitor("t=%0t in_i=0x%h z=0x%h ", $time, in_i, z);
end


initial begin

    in_i = 5'b00000;

    in_i = 5'b00001;
    
    in_i = 5'b00010;

    in_i = 5'b00011;

    in_i = 5'b10000;

    #100;

    $finish;
end



endmodule
