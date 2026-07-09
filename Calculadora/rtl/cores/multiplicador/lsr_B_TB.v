`timescale 10ns / 10ns
`define SIMULATION

module lsr_B_TB;

reg clk;
reg LD;
reg SH;
reg [15:0] B;

wire [31:0] out_sh_B;

// Inicialización del modulo

lsr_B uut ( 
    .clk (clk), .SH (SH), .LD (LD), .B (B), // Entradas
    .out_sh_B (out_sh_B)//Salidas
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("lsr_B_TB.vcd");
    $dumpvars(-1, lsr_B_TB);

    $monitor("t=%0t LD=0x%h SH=0x%h B=0x%h out_sh_B=0x%h", $time, LD, SH, B, out_sh_B);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    SH = 0;
    B = 16'b01000011;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 1;
    SH = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD = 0;
    SH = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    SH = 0;

    #1000;

    $finish;
end



endmodule
