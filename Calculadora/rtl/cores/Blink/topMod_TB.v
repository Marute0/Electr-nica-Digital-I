`timescale 10ns / 10ns
module topMod_TB;

reg clk;
reg rst;

wire led;
    
topMod uut (
    .clk (clk), .rst (rst),
    .led (led)
);

initial clk = 0; 
always #1 clk = ~clk;

initial begin

    rst = 1;

    @(posedge clk);
    @(posedge clk);

    rst = 0;

    @(posedge clk);
    @(posedge clk);

    #40;

    $finish();

end

initial $monitor("Time: %t", $time);

initial begin
    $dumpfile("topMod_TB.vcd");
    $dumpvars(-1, topMod_TB);
end



endmodule