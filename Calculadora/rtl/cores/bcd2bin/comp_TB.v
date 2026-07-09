`timescale 10ns / 10ns
`define SIMULATION

module comp_TB;

reg [3:0] bcd;

wire Y;

// Inicialización del modulo

comp uut ( 
    .bcd (bcd), // Entradas
    .Y (Y) //Salidas
    
    );


initial begin
    $dumpfile("comp_TB.vcd");
    $dumpvars(-1, comp_TB);

    $monitor("t=%0t bcd=0x%h Y=0x%h ", $time, bcd, Y);
end


initial begin

    bcd = 4'b0000;

    bcd = 4'b0001;
    
    bcd = 4'b0010;

    bcd = 4'b0011;

    bcd = 4'b1000;

    #100;

    $finish;
end



endmodule
