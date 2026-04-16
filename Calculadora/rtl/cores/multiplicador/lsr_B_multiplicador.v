module lsr_B_multiplicador (
    input clk,
    input SH,
    input LD,
    input signed [15:0] B,
    output reg [31:0] out_sh_B
    
);

always @(posedge clk) begin
    if(LD) begin
        out_sh_B = B;
    end else if (SH) begin
           out_sh_B = out_sh_B << 1; 
        end 
    end
   
    
endmodule