module sum_res_comp2 (
    input [7:0] in_B,
    input [7:0] in_vAux,

    output reg [7:0] residuo,
    output reg residuo_MSB
);

always @(*) begin
    residuo <= in_vAux - in_B;
    residuo_MSB <= residuo[7];
end
    
endmodule
