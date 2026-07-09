`timescale 10ns / 10ns
`define SIMULATION

module bin2bcd_control_TB;


reg clk;
reg init; 
reg rst;
reg O;
reg T;
reg H;
reg Z;


wire LD0;
wire LD1;
wire LD2;
wire LD3;
wire DEC;
wire SH;
wire done;

// Inicialización del modulo


bin2bcd_control uut ( 
    .clk (clk), .init (init), .O (O), .T (T), .H (H), .Z (Z), .rst (rst), // Entradas
    .done (done), .LD0 (LD0), .LD1 (LD1), .LD2 (LD2), .LD3 (LD3), .DEC (DEC), .SH (SH) //Salidas
    
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("bin2bcd_control_TB.vcd");
    $dumpvars(-1, bin2bcd_control_TB);

    $monitor("t=%0t O=%b T=%b H=%b Z=%b LD0=%b LD1=%b LD2=%b LD3=%b DEC=%b SH=%b done=%b", $time, O, T, H, Z, LD0, LD1, LD2, LD3, DEC, SH, done);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    O = 0;
    T = 0;
    H = 0;
    Z = 0;


    @(negedge clk);
    @(posedge clk);

    init = 1;
    rst = 0;
    O = 0;
    T = 0;
    H = 0;
    Z = 0;

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    O = 0;
    T = 0;
    H = 0;
    Z = 0;

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    O = 1;
    T = 0;
    H = 0;
    Z = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    init = 0;
    rst = 0;
    O = 0;
    T = 1;
    H = 0;
    Z = 0;

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    O = 0;
    T = 0;
    H = 1;
    Z = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    O = 0;
    T = 0;
    H = 0;
    Z = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    init = 0;
    rst = 0;
    O = 0;
    T = 0;
    H = 0;
    Z = 1;

    wait(done == 1);
    #1000;

    $finish;
end

endmodule
