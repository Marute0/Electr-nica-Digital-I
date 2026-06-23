module comp_timer (
    input [12:0] count_out, 
    input [12:0] data2transfer,

    output reg Z
);

always @(*) begin
    if (count_out == data2transfer) begin
        Z <= 1;
    end else begin
        Z <= 0;
    end
end
    
endmodule