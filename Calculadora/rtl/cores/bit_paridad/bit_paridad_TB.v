`timescale 10ns / 10ns
`define SIMULATION

module bit_paridad_TB;


reg clk;
reg init; 
reg rst;
reg [7:0] A;  

wire i_0;
wire done;

// Inicialización del modulo

bit_paridad uut ( //Unit under test
    .clk (clk), .init (init), .rst (rst), .A (A), // Entradas

    .i_0 (i_0), .done (done) // Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("bit_paridad_TB.vcd");
    $dumpvars(-1, bit_paridad_TB);

    $monitor("t=%0t A=0x%h i_0=0x%h done=%b", $time, A, i_0, done);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    A = 0;
    init = 0;
    rst = 0;

    @(negedge clk);
    @(posedge clk);

    A = 8'b01000011;

    @(negedge clk);
    @(posedge clk);

    rst = 1;

    @(negedge clk);
    @(posedge clk);

    rst = 0;

    @(negedge clk);
    @(posedge clk);
    
    init = 1;

    @(negedge clk);
    @(posedge clk);

    init = 0;

    wait(done == 1);
    #1000;

    $finish;
end



endmodule