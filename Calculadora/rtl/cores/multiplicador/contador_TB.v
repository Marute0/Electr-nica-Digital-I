`timescale 10ns / 10ns
`define SIMULATION

module contador_TB;


reg clk;
reg LD;
reg ADDI;

wire [4:0] out_i;

// Inicialización del modulo

contador uut ( 
    .clk (clk), .LD (LD), .ADDI (ADDI), // Entradas
    .out_i (out_i) //Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("contador_TB.vcd");
    $dumpvars(-1, contador_TB);

    $monitor("t=%0t LD=0x%h ADDI=0x%h out_i=0x%h ", $time, LD, ADDI, out_i);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    ADDI = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 1;
    ADDI = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD = 0;
    ADDI = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    ADDI = 0;

    #100;

    $finish;
end



endmodule