`timescale 10ns / 10ns
`define SIMULATION

module sum_comp2_TB;

reg [3:0] in_bcd;

wire [3:0] out_bcd;

// Inicialización del modulo

sum_comp2 uut ( 
    .in_bcd (in_bcd), .out_bcd (out_bcd)
    );


initial begin
    $dumpfile("sum_comp2_TB.vcd");
    $dumpvars(-1, sum_comp2_TB);

    $monitor("t=%0t in_bcd=0x%h out_bcd=0x%h", $time, in_bcd, out_bcd);
end


initial begin

    in_bcd = 4'b0100;

    in_bcd = 4'b0100;
    
    in_bcd = 4'b0100;

    in_bcd = 4'b0100;


    #10000;

    $finish;
end



endmodule
