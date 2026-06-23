module mux (
    input [1:0] SEL_TIM,

    output reg [12:0] data2transfer
);

parameter T0H = 2'b00;
parameter T1H = 2'b01;
parameter RES = 2'b10;
parameter PER = 2'b11;

always @(*) begin
    case (SEL_TIM)
        
        T0H: begin
            data2transfer <= 10;
        end

        T1H: begin
            data2transfer <= 20;
        end

        PER: begin
            data2transfer <= 31;
        end

        RES: begin
            data2transfer <= 1250;
        end

    endcase
end

endmodule