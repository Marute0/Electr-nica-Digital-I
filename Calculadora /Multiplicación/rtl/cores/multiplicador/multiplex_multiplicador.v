module multiplex_multiplicador #( 
    parameter width = 4
) (
    input [width:0] in_i,
    input signed [15:0] A,

    output reg bit_A
);

    always @(*) begin
        bit_A = A[in_i];
    end
    
endmodule