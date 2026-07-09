`timescale 10ns / 10ns
`define SIMULATION

module mult_control_TB;

reg clk;
reg init; 
reg rst;
reg A_i;
reg z;


wire LD;
wire SH;
wire ADDI;
wire ADDB;
wire done;

// Inicialización del modulo


mult_control uut ( 
    .clk (clk), .init (init), .A_i (A_i), .z (z), .rst (rst), // Entradas
    .done (done), .LD (LD), .SH (SH), .ADDI (ADDI), .ADDB (ADDB) //Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("mult_control_TB.vcd");
    $dumpvars(-1, mult_control_TB);

    $monitor("t=%0t A_i=%b z=%b LD=%b SH=%b ADDI=%b ADDB=%b done=%b", $time, A_i, z, LD, SH, ADDI, ADDB, done);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    A_i = 0;
    z = 0;


    @(negedge clk);
    @(posedge clk);

    init = 1;
    rst = 0;
    A_i = 0;
    z = 0;

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    A_i = 0;
    z = 0;

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    A_i = 1;
    z = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    init = 0;
    rst = 0;
    A_i = 0;
    z = 0;

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    A_i = 0;
    z = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    A_i = 0;
    z = 0;

    wait(done == 1);
    #1000;

    $finish;
end



endmodule
