module lsr_vAux (
    input clk,
    input SH0,
    input LD0,
    input LD1,
    input SH1,
    input [7:0] in_A,
    input [7:0] residuo,


    output reg [7:0] out_vAux
    
);

always @(negedge clk) begin
    if(LD0) begin
        out_vAux <= 8'b0;
    end
    if (LD1) begin
        out_vAux <= residuo; 
    end
    if (SH0) begin
        out_vAux <= out_vAux << 1;
    end
    if (SH1) begin
        out_vAux[0] <= in_A[7];
    end
end
   
    
    
endmodule