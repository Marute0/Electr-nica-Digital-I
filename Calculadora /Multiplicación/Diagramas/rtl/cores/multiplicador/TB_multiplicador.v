`timescale 1ns / 1ps

module TB_multiplicador;

reg clk;
reg init;
reg signed [15:0] B; // Multiplicador
reg signed [15:0] A; // Multiplicando


integer i;

wire [31:0] resultado;
wire done;

// Inicialización del modulo

topMod_multiplicador uut ( //Unit under test
    .clk (clk), .init (init), .A (A), .B (B), // Entradas

    .resultado (resultado), .done (done) // Salidas
    
    );



initial clk = 0; // Cambiar la forma en que se genera la señal de clock
always #1 clk = ~clk;

initial begin
    $dumpfile("TB_multiplicador.vcd");
    $dumpvars(-1, TB_multiplicador);

    $monitor("t=%0t A=0x%h B=0x%h resultado=0x%h done=%b", $time, A, B, resultado, done);

    A = 0;
    B = 0;
    init = 0;
    
    @(negedge clk);
    @(posedge clk);

    A = $random;
    B = $random;

    init = 1;
    #10;   
    init = 0;

    wait(done == 1);
    #50;

    $finish;
end



endmodule