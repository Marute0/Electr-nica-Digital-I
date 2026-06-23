`timescale 10ns / 10ns
`define SIMULATION

module root_TB;


reg clk;
reg init; 
reg rst;
reg [7:0] A; 

wire [7:0] raiz;
wire done;

// Inicialización del modulo

root_top uut ( //Unit under test
    .clk (clk), .init (init), .rst (rst), .A (A), // Entradas

    .raiz (raiz), .done (done) // Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("root_TB.vcd");
    $dumpvars(-1, root_TB);

    $monitor("t=%0t A=0x%h raiz=0x%h done=%b", $time, A, raiz, done);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    A = 0;
    init = 0;
    rst = 0;

    @(negedge clk);
    @(posedge clk);

    A = 8'b10101001;

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
    #500;

    $finish;
end



endmodule