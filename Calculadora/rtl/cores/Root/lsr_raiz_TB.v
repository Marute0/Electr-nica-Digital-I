`timescale 10ns / 10ns
`define SIMULATION

module lsr_raiz_TB;


reg clk;
reg LD;
reg SH1;
reg LDRes;

wire [7:0] raiz;

// Inicialización del modulo

lsr_raiz uut ( 
    .clk (clk), .SH1 (SH1), .LD (LD), .LDRes (LDRes), .raiz (raiz) // Entradas
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("lsr_raiz_TB.vcd");
    $dumpvars(-1, lsr_raiz_TB);

    $monitor("t=%0t LD=0x%h SH1=0x%h LDRes=0x%h raiz=0x%h", $time, LD, SH1, LDRes, raiz);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    SH1 = 0;
    LDRes = 0;
    

    @(negedge clk);
    @(posedge clk);

    LD = 1;
    SH1 = 0;
    LDRes = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD = 0;
    SH1 = 0;
    LDRes = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    SH1 = 1;
    LDRes = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    SH1 = 0;
    LDRes = 0;

    #1000;

    $finish;
end



endmodule
