`timescale 10ns / 10ns
`define SIMULATION

module mult_TB;


reg clk;
reg init; 
reg rst;
reg [15:0] B; // Multiplicador
reg [15:0] A; // Multiplicando

wire [31:0] resultado;
wire done;

// Inicialización del modulo

mult uut ( //Unit under test
    .clk (clk), .init (init), .rst (rst), .A (A), .B (B), // Entradas

    .resultado (resultado), .done (done) // Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("mult_TB.vcd");
    $dumpvars(-1, mult_TB);

    $monitor("t=%0t A=0x%h B=0x%h resultado=0x%h done=%b", $time, A, B, resultado, done);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    A = 0;
    B = 0;
    init = 0;
    rst = 0;

    @(negedge clk);
    @(posedge clk);

    A = $random;
    B = $random;

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
