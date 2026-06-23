module lsr_A_res (

    input clk,
    input [7:0] A_bin,
    input [3:0] ones_comp2,
    input [3:0] tens_comp2,
    input [3:0] hundreds_comp2,
    input LD0,
    input LD1,
    input LD2,
    input LD3,
    input SH,
    
    output reg [3:0] bcd_ones, 
    output reg [3:0] bcd_tens, 
    output reg [3:0] bcd_hundreds, 
    output reg [11:0] A_bcd, 
    output reg [7:0] out_A 
);
    
    always @(posedge clk) begin
        if (LD0) begin
            out_A = A_bin;
            A_bcd = 12'b0;
        end else if (LD1) begin
            A_bcd[3:0] = ones_comp2;
        end else if (LD2) begin
            A_bcd[7:4] = tens_comp2;
        end else if (LD3) begin
            A_bcd[11:8] = hundreds_comp2;
        end else if (SH) begin
            A_bcd = {A_bcd[10:0],out_A[7]};
            out_A = out_A << 1;
        end
        
        bcd_ones = A_bcd[3:0];
        bcd_tens = A_bcd[7:4];
        bcd_hundreds = A_bcd[11:8];
    end

endmodule