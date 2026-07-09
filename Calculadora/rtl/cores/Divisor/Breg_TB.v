`timescale 10ns / 10ns
`define SIMULATION

module Breg_TB;



reg clk;
reg LD0;
reg [7:0] in_B;

wire [7:0] out_B;

// Inicialización del modulo

Breg uut ( 
    .clk (clk), .LD0 (LD0), .in_B (in_B), // Entradas
    .out_B (out_B) //Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("Breg_TB.vcd");
    $dumpvars(-1, Breg_TB);

    $monitor("t=%0t LD0=0x%h in_B=0x%h out_B=0x%h ", $time, LD0, in_B, out_B);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    in_B = 8'd255;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    in_B = 8'd1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD0 = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD0 = 0;
    in_B = 8'd0;

    #100;

    $finish;
end



endmodule
