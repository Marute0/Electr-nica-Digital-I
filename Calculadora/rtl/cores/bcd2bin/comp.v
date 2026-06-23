module comp (
    input [3:0] bcd,

    output reg Y
);

always @(*) begin
    if(bcd >= 8) begin
        Y = 1;
    end else begin
        Y = 0;
    end
end
    
endmodule