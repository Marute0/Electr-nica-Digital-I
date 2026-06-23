module lsr_A (
    input clk,
    input LD0,
    input SH0,
    input [7:0] in_A,

    output reg [7:0] out_sh_A
);

always @(negedge clk) begin
    if(LD0) begin
        out_sh_A = in_A;
    end else if (SH0) begin
        out_sh_A = out_sh_A << 1; 
    end 
end
   
    
endmodule