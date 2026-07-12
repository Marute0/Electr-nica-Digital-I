`timescale 10ns / 10ns
`define SIMULATION

module sum_res_comp2_TB;


reg [7:0] in_B;
reg [7:0] in_vAux;


wire [7:0] residuo;
wire residuo_MSB;

// Inicialización del modulo

sum_res_comp2 uut ( 
    .in_B (in_B), .in_vAux (in_vAux), .residuo (residuo), .residuo_MSB (residuo_MSB)
    );


initial begin
    $dumpfile("sum_res_comp2_TB.vcd");
    $dumpvars(-1, sum_res_comp2_TB);

    $monitor("t=%0t in_B=0x%h in_vAux=0x%h residuo=0x%h residuo_MSB=0x%h", $time, in_B, in_vAux, residuo, residuo_MSB);
end


initial begin


    in_B = 8'b01000011;
    in_vAux = 8'b00000000;

    #20;

    in_B = 8'b01000011;
    in_vAux = 8'b00010000;

    #20;
    
    in_B = 8'b01000011;
    in_vAux = 8'b00010100;

    #20;

    in_B = 8'b01001011;
    in_vAux = 8'b00010100;


    #10000;

    $finish;
end



endmodule
