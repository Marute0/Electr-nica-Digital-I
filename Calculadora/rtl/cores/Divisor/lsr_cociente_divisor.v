module lsr_A_divisor (
    input clk,
    input LD1,
    input SH1,
    input signed [7:0] in_cociente,

    output reg signed [7:0] out_cociente
    
);

always @(negedge clk) begin
    if(LD1) begin
        out_cociente[0] <= 1'b1;
    end else if (SH1) begin
        out_cociente = out_cociente << 1; 
    end 
end
   
    
endmodule