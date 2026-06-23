module lsr_raiz (
    input clk,
    input SH1,
    input LD,
    input LDRes,

    output reg [7:0] raiz
    
);

always @(negedge clk) begin
    if(LD) begin
        raiz = 8'b0;
    end else if (SH1) begin
        raiz = raiz << 1; 
    end else if (LDRes) begin
        raiz[7:0] = {raiz[7:1],1'b1};
    end
end
   
    
endmodule