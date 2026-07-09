`timescale 10ns / 10ns
`define SIMULATION

module div_control_TB;


reg clk;
reg init; 
reg rst;
reg residuo_MSB;
reg zero;


wire LD0;
wire LD1;
wire SH0;
wire SH1;
wire DECI;
wire done;

// Inicialización del modulo


div_control uut ( 
    .clk (clk), .init (init), .residuo_MSB (residuo_MSB), .zero (zero), .rst (rst), // Entradas
    .done (done), .LD0 (LD0), .LD1 (LD1), .SH0 (SH0), .SH1 (SH1), .DECI (DECI) //Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("div_control_TB.vcd");
    $dumpvars(-1, div_control_TB);

    $monitor("t=%0t residuo_MSB=%b zero=%b LD0=%b LD1=%b SH0=%b SH1=%b DECI=%b done=%b", $time, residuo_MSB, zero, LD0, LD1, SH0, SH1, DECI, done);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    residuo_MSB = 0;
    zero = 0;


    @(negedge clk);
    @(posedge clk);

    init = 1;
    rst = 0;
    residuo_MSB = 0;
    zero = 0;

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    residuo_MSB = 0;
    zero = 0;

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    residuo_MSB = 1;
    zero = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    init = 0;
    rst = 0;
    residuo_MSB = 0;
    zero = 1;

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    residuo_MSB = 0;
    zero = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    residuo_MSB = 0;
    zero = 1;

    wait(done == 1);
    #1000;

    $finish;
end



endmodule
