`timescale 10ns / 10ns
`define SIMULATION

module contador_dec_TB;


reg clk;
reg LD0;
reg DECI;

wire Z;

// Inicialización del modulo

contador_dec uut ( 
    .clk (clk), .LD0 (LD0), .DECI (DECI), // Entradas
    .Z (Z) //Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("contador_dec_TB.vcd");
    $dumpvars(-1, contador_dec_TB);

    $monitor("t=%0t LD0=0x%h DECI=0x%h Z=0x%h ", $time, LD0, DECI, Z);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    DECI = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 1;
    DECI = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD0 = 0;
    DECI = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    DECI = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    DECI = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    DECI = 1;

    #100;

    $finish;
end



endmodule
