module lsr2_vAux_A (
    input clk,
    input LD,
    input SH0,
    input LDRes,
    input [7:0] in_A,
    input [7:0] residuo,

    output reg [7:0] v_Aux,
    output reg [7:0] A_shift

);



    always @(negedge clk) begin
        if (LD) begin
            v_Aux = 8'b0;
            A_shift = in_A;
        end else if (SH0) begin
            v_Aux[7:0] = {v_Aux[5:0], A_shift[7:6]};
            A_shift = {A_shift[5:0], 2'b00};
        end else if (LDRes) begin
            v_Aux = residuo;
        end
    end

endmodule