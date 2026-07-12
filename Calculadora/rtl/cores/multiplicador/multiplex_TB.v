`timescale 10ns / 10ns
`define SIMULATION

module multiplex_TB;


reg [4:0] in_i;
reg [15:0] A;

wire A_i;

// Inicialización del modulo

multiplex uut ( 
    .in_i (in_i), .A (A), .A_i (A_i)
    );


initial begin
    $dumpfile("multiplex_TB.vcd");
    $dumpvars(-1, multiplex_TB);

    $monitor("t=%0t in_i=0x%h A=0x%h A_i=0x%h", $time, in_i, A, A_i);
end


initial begin


    in_i = 5'b00000;
    A = 16'b0000000000000000;

    #20;

    in_i = 5'b00001;
    A = 16'b0000000000001111;

    #20;

    
    in_i = 5'b00010;
    A = 16'b0000000000010000;

    #20;

    in_i = 5'b00011;
    A = 16'b0000000000011111;


    #10000;

    $finish;
end



endmodule
