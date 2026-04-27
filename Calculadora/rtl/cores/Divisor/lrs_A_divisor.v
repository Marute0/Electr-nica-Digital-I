module lsr_A_divisor (
    input clk,
    input LD0,
    input SH0,
    input signed [7:0] in_A,

    output signed [7:0] out_sh_A,
    output MSB_A
);

always @(negedge clk) begin
    if(LD0) begin
        out_sh_A = in_A;
    end else if (SH0) begin
        out_sh_A = out_sh_A << 1; 
    end 

    MSB_A <= out_sh_A[7];
end
   
    
endmodule