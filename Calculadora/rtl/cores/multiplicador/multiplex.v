module multiplex #( 
    parameter width = 4
) (
    input [width:0] in_i,
    input [15:0] A,

    output reg A_i
);

    always @(*) begin
        A_i = A[in_i];
    end
    
endmodule
