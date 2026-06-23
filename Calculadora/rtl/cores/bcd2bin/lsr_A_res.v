module lsr_A_res (

    input clk,
    input [11:0] A_bcd,
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
    output reg [7:0] A_bin
);
    
    reg [11:0] temp_A_bcd;

    always @(posedge clk) begin
        if (LD0) begin
            A_bin = 8'b0;
            temp_A_bcd = A_bcd;
        end else if (LD1) begin
            temp_A_bcd[3:0] = ones_comp2;
        end else if (LD2) begin
            temp_A_bcd[7:4] = tens_comp2;
        end else if (LD3) begin
            temp_A_bcd[11:8] = hundreds_comp2;
        end else if (SH) begin
            A_bin = {temp_A_bcd[0],A_bin[7:1]};
            temp_A_bcd = temp_A_bcd >> 1;
        end
        
        bcd_ones = temp_A_bcd[3:0];
        bcd_tens = temp_A_bcd[7:4];
        bcd_hundreds = temp_A_bcd[11:8];
    end

endmodule