`timescale 10ns / 10ns
`define SIMULATION

module lsr_vAux_TB;

reg clk;
reg LD0;
reg SH0;
reg SH1;
reg LD1;
reg [7:0] in_A;
reg [7:0] residuo;  

wire [7:0] out_vAux;

// Inicialización del modulo

lsr_vAux uut ( 
    .clk (clk), .SH0 (SH0), .LD0 (LD0), .LD1 (LD1), .SH1 (SH1), .in_A (in_A), .residuo (residuo), // Entradas
    .out_vAux (out_vAux)//Salidas
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("lsr_vAux_TB.vcd");
    $dumpvars(-1, lsr_vAux_TB);

    $monitor("t=%0t LD1=0x%h SH0=0x%h LD0=0x%h residuo=0x%h out_vAux=0x%h", $time, LD1, SH0, LD0, residuo, out_vAux);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    LD1 = 0;
    SH0 = 0;
    SH1 = 0;
    in_A = 8'b01000011;
    residuo = 8'b00000011;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 1;
    LD1 = 0;
    SH0 = 0;
    SH1 = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD0 = 0;
    LD1 = 1;
    SH0 = 0;
    SH1 = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    LD1 = 0;
    SH0 = 1;
    SH1 = 0;

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    LD1 = 0;
    SH0 = 0;
    SH1 = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    LD1 = 0;
    SH0 = 0;
    SH1 = 1;

    #1000;

    $finish;
end



endmodule
