`timescale 10ns / 10ns
`define SIMULATION

module Areg_TB;


reg clk;
reg LD;
reg [15:0] A;

wire [15:0] out_A;

// Inicialización del modulo

Areg uut ( 
    .clk (clk), .LD (LD), .A (A), // Entradas
    .out_A (out_A) //Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("Areg_TB.vcd");
    $dumpvars(-1, Areg_TB);

    $monitor("t=%0t LD=0x%h A=0x%h out_A=0x%h ", $time, LD, A, out_A);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    A = 16'd255;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    A = 16'd1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    A = 16'd0;

    #100;

    $finish;
end



endmodule
