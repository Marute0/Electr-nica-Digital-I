`timescale 10ns / 10ns
`define SIMULATION

module contador_TB;


reg clk;
reg load;
reg ADDI;

wire i_0;

// Inicialización del modulo

contador uut ( 
    .clk (clk), .LD (load), .ADDI (ADDI), // Entradas
    .i_0 (i_0) //Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("contador_TB.vcd");
    $dumpvars(-1, contador_TB);

    $monitor("t=%0t load=0x%h ADDI=0x%h i_0=0x%h ", $time, load, ADDI, i_0);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    load = 0;
    ADDI = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    load = 1;
    ADDI = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    load = 0;
    ADDI = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    load = 0;
    ADDI = 0;

    #1000;

    $finish;
end



endmodule