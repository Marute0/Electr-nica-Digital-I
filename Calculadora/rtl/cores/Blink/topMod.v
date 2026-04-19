module topMod (
    input clk,
    input rst,

    output led
);

blinking blink_1 (
    .clk (clk), .rst (rst),

    .led (led)
);


endmodule