module sumResComp2_divisor (
    input signed [7:0] in_B,
    input signed [7:0] in_vAux,

    output reg signed [7:0] residuo
);

always @(*) begin
    residuo = in_vAux - in_B;
end

    
endmodule