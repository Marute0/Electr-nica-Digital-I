module sum_comp2 (
    input [3:0] in_bcd,

    output reg [3:0] out_bcd
);
    
    always @(*) begin
        out_bcd = in_bcd - 4'b0011;
    end

endmodule