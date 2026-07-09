`timescale 10ns / 10ns
`define SIMULATION

module lsr_A_TB;


reg clk;
reg LD0;
reg SH0;
reg [7:0] in_A;

wire [7:0] out_sh_A;

// Inicialización del modulo

lsr_A uut ( 
    .clk (clk), .SH0 (SH0), .LD0 (LD0), .in_A (in_A), // Entradas
    .out_sh_A (out_sh_A)//Salidas
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("lsr_A_TB.vcd");
    $dumpvars(-1, lsr_A_TB);

    $monitor("t=%0t LD0=0x%h SH0=0x%h in_A=0x%h out_sh_A=0x%h", $time, LD0, SH0, in_A, out_sh_A);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    SH0 = 0;
    in_A = 8'b01000011;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 1;
    SH0 = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD0 = 0;
    SH0 = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    SH0 = 0;

    #1000;

    $finish;
end



endmodule
