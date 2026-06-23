module count_addr (
    input clk,
    input RST,
    input INC,

    output reg [9:0] addr
);

always @(negedge clk) begin
    if (RST) begin
        addr = 10'b0;
    end else if (INC) begin
        addr = addr + 1;
    end
end

endmodule