`timescale 10ns / 10ns
`define SIMULATION

module lsr_cociente_TB;


reg clk;
reg LD1;
reg SH1;
reg LD0;

wire [7:0] out_cociente;

// Inicialización del modulo

lsr_cociente uut ( 
    .clk (clk), .SH1 (SH1), .LD1 (LD1), .LD0 (LD0), // Entradas
    .out_cociente (out_cociente)//Salidas
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("lsr_cociente_TB.vcd");
    $dumpvars(-1, lsr_cociente_TB);

    $monitor("t=%0t LD1=0x%h SH1=0x%h LD0=0x%h out_cociente=0x%h", $time, LD1, SH1, LD0, out_cociente);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    LD1 = 0;
    SH1 = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 1;
    LD1 = 0;
    SH1 = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD0 = 0;
    LD1 = 1;
    SH1 = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    LD1 = 0;
    SH1 = 0;

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    LD1 = 0;
    SH1 = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    LD1 = 0;
    SH1 = 0;

    #1000;

    $finish;
end



endmodule
