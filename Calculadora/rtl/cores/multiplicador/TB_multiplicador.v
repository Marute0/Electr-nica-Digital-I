`timescale 10ns / 10ns
// Para qué funciona el define?


module TB_multiplicador;


reg clk;
reg init; 
reg rst;
reg [15:0] B; // Multiplicador
reg [15:0] A; // Multiplicando


integer i;

wire [31:0] resultado;
wire done;

// Inicialización del modulo

topMod_multiplicador uut ( //Unit under test
    .clk (clk), .init (init), .rst (rst), .A (A), .B (B), // Entradas

    .resultado (resultado), .done (done) // Salidas
    
    );

event reset_trigger;
event reset_done_trigger;


initial begin
    forever begin
        @(reset_trigger);
        @(negedge clk);

        rst = 1;

        @(negedge clk);

        rst = 0;

        -> reset_done_trigger;
    end
end


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("TB_multiplicador.vcd");
    $dumpvars(-1, TB_multiplicador);

    $monitor("t=%0t A=0x%h B=0x%h resultado=0x%h done=%b", $time, A, B, resultado, done);
end


initial begin
    #50 -> reset_trigger;
    @(reset_done_trigger);

    @(negedge clk);
    @(posedge clk);

    A = 0;
    B = 0;
    init = 0;
    
    @(negedge clk);
    @(posedge clk);

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