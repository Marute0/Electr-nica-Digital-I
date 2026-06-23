module comp (
    input [3:0] bcd,

    output reg Y
);

always @(*) begin
    if(bcd >= 5) begin
        Y = 1;
    end else begin
        Y = 0;
    end
end
    
endmodule