module comparador #(
    parameter width = 4
) (
    input [width:0] in_i,
    
    output reg z
);

    always @(*) begin
        if (in_i == 16) begin
            z = 1'b1;
        end else begin
            z = 1'b0;
        end
    end
endmodule
