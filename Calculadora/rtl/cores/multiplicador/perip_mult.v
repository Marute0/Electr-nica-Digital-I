module perip_mult (

    input clk,
    input wr,
    input cs,


    output [31:0] dout,
);


//Decodificador de dirección












mult_top mult (
    .clk (clk),
    .init (init),
    .rst (reset),
    .A (A),
    .B (B),

    .resultado (resultado),
    .done (done)
);


    
endmodule