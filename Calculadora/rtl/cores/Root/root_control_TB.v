`timescale 10ns / 10ns
`define SIMULATION

module root_control_TB;


reg clk;
reg init; 
reg rst;
reg residuo_MSB;
reg zero;


wire LD;
wire LDRes;
wire SH0;
wire SH1;
wire DEC;
wire done;

// Inicialización del modulo


root_control uut ( 
    .clk (clk), .init (init), .residuo_MSB (residuo_MSB), .zero (zero), .rst (rst), // Entradas
    .done (done), .LD (LD), .LDRes (LDRes), .SH0 (SH0), .SH1 (SH1), .DEC (DEC) //Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("root_control_TB.vcd");
    $dumpvars(-1, root_control_TB);

    $monitor("t=%0t residuo_MSB=%b zero=%b LD=%b LDRes=%b SH0=%b SH1=%b DEC=%b done=%b", $time, residuo_MSB, zero, LD, LDRes, SH0, SH1, DEC, done);
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
