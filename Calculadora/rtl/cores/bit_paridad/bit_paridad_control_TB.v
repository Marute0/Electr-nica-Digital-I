`timescale 10ns / 10ns
`define SIMULATION

module bit_paridad_control_TB;


reg clk;
reg init; 
reg rst;
reg LSB_A;
reg z;  

wire load;
wire shift;
wire ADDI;
wire done;

// Inicialización del modulo

bit_paridad_control uut ( 
    .clk (clk), .init (init), .LSB_A (LSB_A), .z (z), .rst (rst), // Entradas
    .done (done), .LD (load), .SH (shift), .ADDI (ADDI) //Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("bit_paridad_TB.vcd");
    $dumpvars(-1, bit_paridad_TB);

    $monitor("t=%0t LSB_A=%b z=%b load=%b shift=%b ADDI=%b done=%b", $time, LSB_A, z, load, shift, ADDI, done);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    LSB_A = 0;
    z = 0;

    @(negedge clk);
    @(posedge clk);

    init = 1;
    rst = 0;
    LSB_A = 0;
    z = 0;

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    LSB_A = 1;
    z = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    init = 0;
    rst = 0;
    LSB_A = 0;
    z = 0;

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    LSB_A = 0;
    z = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    LSB_A = 0;
    z = 0;

    wait(done == 1);
    #1000;

    $finish;
end



endmodule