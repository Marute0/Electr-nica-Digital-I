`timescale 10ns / 10ns
`define SIMULATION

module lsr_A_res_TB;

reg clk;
reg [11:0] A_bcd;
reg [3:0] ones_comp2;
reg [3:0] tens_comp2;
reg [3:0] hundreds_comp2;
reg LD0;
reg LD1;
reg LD2;
reg LD3;
reg SH;

wire [3:0] bcd_ones;
wire [3:0] bcd_tens;
wire [3:0] bcd_hundreds;
wire [7:0] A_bin;


// Inicialización del modulo

lsr_A_res uut ( 
    .clk (clk), .A_bcd (A_bcd), .ones_comp2 (ones_comp2), .tens_comp2 (tens_comp2), .hundreds_comp2 (hundreds_comp2), .LD1 (LD1), .LD0 (LD0), .LD2 (LD2), .LD3 (LD3), .SH (SH), // Entradas
    .bcd_ones (bcd_ones), .bcd_tens (bcd_tens), .bcd_hundreds (bcd_hundreds), .A_bin (A_bin) //Salidas
    );


initial clk = 0; 
always #1 clk = ~clk;


initial begin
    $dumpfile("lsr_A_res_TB.vcd");
    $dumpvars(-1, lsr_A_res_TB);

    $monitor("t=%0t A_bcd=0x%h ones_comp2=0x%h tens_comp2=0x%h hundreds_comp2=0x%h LD1=0x%h LD0=0x%h LD2=0x%h LD3=0x%h SH=0x%h bcd_ones=0x%h bcd_tens=0x%h bcd_hundreds=0x%h A_bcd=0x%h A_bin=0x%h", $time, A_bcd, ones_comp2, tens_comp2, hundreds_comp2, LD1, LD0, LD2, LD3, SH, bcd_ones, bcd_tens, bcd_hundreds, A_bcd, A_bin);
end


initial begin

    @(negedge clk);
    @(posedge clk);

    LD1 = 0;
    LD0 = 0;
    LD2 = 0;
    LD3 = 0;
    SH = 0;
    A_bcd = 8'b01000011;
    ones_comp2 = 4'b0001;
    tens_comp2 = 4'b0100;
    hundreds_comp2 = 4'b0010;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD1 = 1;
    LD0 = 0;
    LD2 = 0;
    LD3 = 0;
    SH = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);
    
    LD1 = 0;
    LD0 = 0;
    LD2 = 0;
    LD3 = 0;
    SH = 1;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD1 = 0;
    LD0 = 1;
    LD2 = 0;
    LD3 = 0;
    SH = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD1 = 0;
    LD0 = 0;
    LD2 = 1;
    LD3 = 0;
    SH = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD1 = 0;
    LD0 = 0;
    LD2 = 0;
    LD3 = 1;
    SH = 0;

    @(negedge clk);
    @(posedge clk);

    @(negedge clk);
    @(posedge clk);

    LD1 = 0;
    LD0 = 0;
    LD2 = 0;
    LD3 = 0;
    SH = 0;

    #1000;

    $finish;
end



endmodule
