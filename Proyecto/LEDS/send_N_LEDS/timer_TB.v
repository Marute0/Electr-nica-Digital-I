`timescale 10ns / 10ns
`define SIMULATION

module timer_TB;

reg clk;
reg INIT_T; 
reg RST_CMD;
reg MSB;

wire DONE_T;
wire DOUT;

// Inicialización del modulo

timer uut ( //Unit under test
    .clk (clk), .INIT_T (INIT_T), .RST_CMD (RST_CMD), .MSB (MSB), // Entradas

    .DONE_T (DONE_T), .DOUT (DOUT) // Salidas
    
    );


initial clk = 0; 
always #2 clk = ~clk;


initial begin
    $dumpfile("timer_TB.vcd");
    $dumpvars(-1, timer_TB);

    $monitor("t=%0t, DOUT =0x%h", $time, DOUT);
end


initial begin

    INIT_T = 0;
    RST_CMD = 0;
    MSB = 0;

    @(negedge clk);
    @(posedge clk);

    INIT_T = 1;

    @(negedge clk);
    @(posedge clk);

    INIT_T = 0;

    @(negedge clk);
    @(posedge clk);

    wait(DONE_T == 1);
    #150;

    INIT_T = 1;
    RST_CMD = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    INIT_T = 0;

    @(negedge clk);
    @(posedge clk);

    wait(DONE_T == 1);
    #150;

    INIT_T = 1;
    RST_CMD = 0;
    MSB = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    INIT_T = 0;
    RST_CMD = 0;
    MSB = 0;

    @(negedge clk);
    @(posedge clk);

    wait(DONE_T == 1);
    #150;

    $finish;
end



endmodule