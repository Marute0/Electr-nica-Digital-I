`timescale 10ns / 10ns
`define SIMULATION

module rsr_A_TB;


reg clk;
reg load;
reg shift;
reg [7:0] A;

wire z;
wire LSB_A;

// Inicialización del modulo

rsr_A uut ( 
    .clk (clk), .SH(shift), .LD (load), .A (A), // Entradas
    .z (z), .LSB_A (LSB_A)//Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("contador_TB.vcd");
    $dumpvars(-1, contador_TB);

    $monitor("t=%0t load=0x%h shift=0x%h A=0x%h z=0x%h LSB_A=0x%h", $time, load, shift, A, z, LSB_A);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    load = 0;
    shift = 0;
    A = 8'b01000011;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    load = 1;
    shift = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    load = 0;
    shift = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    load = 0;
    shift = 0;

    #1000;

    $finish;
end



endmodule