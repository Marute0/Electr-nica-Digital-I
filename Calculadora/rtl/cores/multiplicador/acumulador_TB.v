`timescale 10ns / 10ns
`define SIMULATION

module acumulador_TB;

reg clk;
reg LD;
reg ADDB;
reg [31:0] in_sh_B;

wire [31:0] resultado;

// Inicialización del modulo

acumulador uut ( 
    .clk (clk), .LD (LD), .ADDB (ADDB), .in_sh_B (in_sh_B), // Entradas
    .resultado (resultado) //Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("acumulador_TB.vcd");
    $dumpvars(-1, acumulador_TB);

    $monitor("t=%0t LD=0x%h ADDB=0x%h in_sh_B=0x%h resultado=0x%h", $time, LD, ADDB, in_sh_B, resultado);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    in_sh_B = 32'd255;
    LD = 0;
    ADDB = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 1;
    ADDB = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD = 0;
    ADDB = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    ADDB = 0;

    #100;

    $finish;
end



endmodule
