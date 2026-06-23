`timescale 10ns / 10ns
`define SIMULATION

module ws2812_TB;

reg clk;
reg INIT; 
reg [23:0] GRB;
reg RST_CMD;

wire DONE;
wire DOUT;

// Inicialización del modulo

ws2812 uut ( //Unit under test
    .clk (clk), .INIT (INIT), .RST_CMD (RST_CMD), .GRB (GRB), // Entradas

    .DONE (DONE), .DOUT (DOUT) // Salidas
    
    );


initial clk = 0; 
always #2 clk = ~clk;


initial begin
    $dumpfile("ws2812_TB.vcd");
    $dumpvars(-1, ws2812_TB);

    $monitor("t=%0t, DOUT =0x%h, DONE =0x%h", $time, DOUT, DONE);
end


initial begin

    INIT = 0;
    GRB = 24'h00FF00;
    RST_CMD = 0;

    @(negedge clk);
    @(posedge clk);

    INIT = 1;

    @(negedge clk);
    @(posedge clk);

    INIT = 0;

    @(negedge clk);
    @(posedge clk);

    wait(DONE == 1);
    #150;


    $finish;
end



endmodule