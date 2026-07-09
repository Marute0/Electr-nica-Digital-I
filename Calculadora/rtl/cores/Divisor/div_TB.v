`timescale 10ns / 10ns
`define SIMULATION

module div_TB;


reg clk;
reg init; 
reg rst;
reg [7:0] A; 
reg [7:0] B; 

wire [7:0] cociente;
wire [7:0] residuo;
wire done;

// Inicialización del modulo

div uut ( //Unit under test
    .clk (clk), .init (init), .rst (rst), .A (A), .B (B), // Entradas

    .residuo (residuo), .cociente (cociente), .done (done) // Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("div_TB.vcd");
    $dumpvars(-1, div_TB);

    $monitor("t=%0t A=0x%h B=0x%h cociente=0x%h residuo=0x%h done=%b", $time, A, B, cociente, residuo, done);
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

    A = 8'b01000011;
    B = 8'b00001001;

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