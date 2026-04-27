module lsr_vAux_divisor (
    input clk,
    input SH0,
    input LD0,
    input LD1,
    input SH1,
    input MSB_A,
    input signed [7:0] residuo,


    output reg signed [7:0] out_vAux
    
);

always @(negedge clk) begin
    if(LD0) begin
        out_vAux <= 8'b0;
    end else if (LD1) begin
        out_vAux <= residuo; 
    end else if (SH0) begin
        out_vAux <= out_vAux << 1;
    end else if (SH1) begin
        out_vAux[7] <= MSB_A;
    end
end
   
    
    
endmodule