`timescale 10ns / 10ns
`define SIMULATION

module bin2bcd_TB;


reg clk;
reg init; 
reg rst;
reg [7:0] A_bin;

wire [11:0] A_bcd;
wire done;

// Inicialización del modulo

bin2bcd uut ( //Unit under test
    .clk (clk), .init (init), .rst (rst), .A_bin (A_bin), // Entradas

    .A_bcd (A_bcd), .done (done) // Salidas
    
    );





initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("bin2bcd_TB.vcd");
    $dumpvars(-1, bin2bcd_TB);

    $monitor("t=%0t A=0x%h resultado=0x%h done=%b", $time, A_bin, A_bcd, done);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    A_bin = 0;
    init = 0;
    rst = 0;

    @(negedge clk);
    @(posedge clk);

    A_bin = 8'b11110011;

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