`timescale 10ns / 10ns
`define SIMULATION

module lsr2_rParcial_TB;


reg clk;
reg LD;
reg SH1;
reg DECI;
reg [7:0] raiz;

wire [7:0] out_rParcial;

// Inicialización del modulo

lsr2_rParcial uut ( 
    .clk (clk), .SH1 (SH1), .LD (LD), .DECI (DECI), .raiz (raiz), .out_rParcial (out_rParcial)
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("lsr2_rParcial_TB.vcd");
    $dumpvars(-1, lsr2_rParcial_TB);

    $monitor("t=%0t LD=0x%h SH1=0x%h raiz=0x%h out_rParcial=0x%h", $time, LD, SH1, raiz, out_rParcial);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    DECI = 0;
    SH1 = 0;
    raiz = 8'b01000011;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 1;
    DECI = 0;
    SH1 = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD = 0;
    DECI = 1;
    SH1 = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    DECI = 0;
    SH1 = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    DECI = 0;
    SH1 = 0;

    #1000;

    $finish;
end



endmodule
