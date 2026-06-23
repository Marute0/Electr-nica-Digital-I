module lsr_cociente (
    input clk,
    input LD1,
    input SH1,
    input LD0,

    output reg [7:0] out_cociente
    
);

always @(negedge clk) begin
    if(LD1) begin
        out_cociente[0] <= 1;
    end else if (SH1) begin
        out_cociente <= out_cociente << 1; 
    end else if (LD0) begin
        out_cociente <= 7'b0;
    end
end
   
    
endmodule