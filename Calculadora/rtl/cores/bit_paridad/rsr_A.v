module rsr_A (
    input clk,
    input LD,
    input SH,
    input [7:0] A,

    output reg z,
    output reg LSB_A
);

always @(negedge clk) begin
    if(LD) begin
        out_A = A;
    end else if (SH) begin
        out_A = out_A << 1; 
    end

    LSB_A = out_A[0];

    assign z = (out_A == 0);     //Señal que se activa una vez A es 0
end
   
    
endmodule