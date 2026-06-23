module count_out (
    input clk, 
    input RST, 
    input INC,

    output reg [12:0] count_out
);
    
always @(negedge clk) begin
    if (RST) begin
        count_out = 14'b0;
    end else if (INC) begin
        count_out = count_out + 1;
    end
end

endmodule