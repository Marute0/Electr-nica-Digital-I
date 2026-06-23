`timescale 10ns / 10ns
`define SIMULATION

module bcd2bin_TB;


reg clk;
reg init; 
reg rst;
reg [11:0] A_bcd;

wire [7:0] A_bin;
wire done;

// Inicialización del modulo

bcd2bin_top uut ( //Unit under test
    .clk (clk), .init (init), .rst (rst), .A_bcd (A_bcd), // Entradas

    .A_bin (A_bin), .done (done) // Salidas
    
    );





initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("bcd2bin_TB.vcd");
    $dumpvars(-1, bcd2bin_TB);

    $monitor("t=%0t A_bcd=0x%h A_bin=0x%h done=%b", $time, A_bcd, A_bin, done);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    A_bcd = 0;
    init = 0;
    rst = 0;

    @(negedge clk);
    @(posedge clk);

    A_bcd = 12'b001001000011 ; //243

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