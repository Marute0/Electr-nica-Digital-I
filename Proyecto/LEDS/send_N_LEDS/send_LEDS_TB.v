`timescale 10ns / 10ns
`define SIMULATION

module send_LEDS_TB;

reg clk;
reg INIT_M; 
reg RST_CMD;

wire DONE_M;
wire DOUT;

// Inicialización del modulo

send_LEDS uut ( //Unit under test
    .clk (clk), .INIT_M (INIT_M), .RST_CMD (RST_CMD), // Entradas

    .DONE_M (DONE_M), .DOUT (DOUT) // Salidas
    
    );


initial clk = 0; 
always #2 clk = ~clk;


initial begin
    $dumpfile("send_LEDS_TB.vcd");
    $dumpvars(-1, send_LEDS_TB);

    $monitor("t=%0t, DOUT =0x%h", $time, DOUT);
end


initial begin

    INIT_M = 0;
    RST_CMD = 0;

    @(negedge clk);
    @(posedge clk);

    INIT_M = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    INIT_M = 0;

    @(negedge clk);
    @(posedge clk);

    wait(DONE_M == 1);
    #50;

    INIT_M = 1;
    RST_CMD = 1;

    @(negedge clk);
    @(posedge clk);

    INIT_M = 0;
    RST_CMD = 0;

    @(negedge clk);
    @(posedge clk);

    $finish;
end



endmodule