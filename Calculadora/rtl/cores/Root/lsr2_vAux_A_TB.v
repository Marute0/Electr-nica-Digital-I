`timescale 10ns / 10ns
`define SIMULATION

module lsr2_vAux_A_TB;


reg clk;
reg LD;
reg SH0;
reg LDRes;
reg [7:0] in_A;
reg [7:0] residuo;

wire [7:0] v_Aux;
wire [7:0] A_shift;

// Inicialización del modulo

lsr2_vAux_A uut ( 
    .clk (clk), .SH0 (SH0), .LD (LD), .LDRes (LDRes), .in_A (in_A), .residuo (residuo), // Entradas
    .v_Aux (v_Aux), .A_shift (A_shift)//Salidas
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("lsr2_vAux_A_TB.vcd");
    $dumpvars(-1, lsr2_vAux_A_TB);

    $monitor("t=%0t LD=0x%h SH0=0x%h in_A=0x%h v_Aux=0x%h A_shift=0x%h", $time, LD, SH0, in_A, v_Aux, A_shift);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    LDRes = 0;
    SH0 = 0;
    in_A = 8'b01000011;
    residuo = 8'b00001011;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 1;
    LDRes = 0;
    SH0 = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD = 0;
    LDRes = 1;
    SH0 = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD = 0;
    LDRes = 0;
    SH0 = 0;

    #1000;

    $finish;
end



endmodule
