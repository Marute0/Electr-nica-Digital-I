module timer_control #(

// Establecimiento de los estados como parámetros

    parameter START = 3'b000,
    parameter RESET_COUNT = 3'b001,
    parameter CHECK_DATA = 3'b010,
    parameter SEND_0 = 3'b011,
    parameter SEND_1 = 3'b100,
    parameter SEND_RST = 3'b101,
    parameter INC_COUNT_PER = 3'b110,
    parameter FINISH = 3'b111

) (

    input clk,
    input INIT_T,
    input rst,
    input MSB,
    input RST_CMD,
    input Z,

    output reg RST,
    output reg INC,
    output reg [1:0] SEL_TIM,
    output reg DOUT,
    output reg DONE_T

);


// Maquina de estados: lógica de transición

    reg [2:0] current_state;
    reg [4:0] count;


    always @(posedge clk) begin

        if (rst) begin
            current_state = START;
        end else begin

            case (current_state)

                START: begin
                    if (INIT_T) begin
                        current_state = RESET_COUNT;
                        count = 0;
                    end else begin
                        current_state = START;
                    end
                end

                RESET_COUNT: begin
                    current_state = CHECK_DATA;
                end

                CHECK_DATA: begin
                    if(RST_CMD) begin
                        current_state = SEND_RST;
                    end else begin 
                        if (MSB) begin
                            current_state = SEND_1;
                        end else begin
                            current_state = SEND_0;
                        end
                    end
                end

                SEND_RST: begin
                    if (Z) begin
                        current_state = FINISH;
                    end else begin
                        current_state = SEND_RST;
                    end
                end

                SEND_0: begin
                    if (Z) begin
                        current_state = INC_COUNT_PER;
                    end else begin
                        current_state = SEND_0;
                    end
                end

                SEND_1: begin
                    if (Z) begin
                        current_state = INC_COUNT_PER;
                    end else begin
                        current_state = SEND_1;
                    end
                end

                INC_COUNT_PER: begin
                    if (Z) begin
                        current_state = FINISH;
                    end else begin
                        current_state = INC_COUNT_PER;
                    end
                end

                FINISH: begin
                    count = count + 1;
                    current_state = (count==1) ? START : FINISH ;
                end

                default: current_state = START;
                
            endcase
        end
    end

// Salidas según el estado

always @(*) begin

    case (current_state)

        START: begin
            DOUT    = 1'b0;
            RST     = 1'b0;
            INC     = 1'b0;
            SEL_TIM = 2'b00;
            DONE_T  = 1'b0;
        end

        RESET_COUNT: begin
            DOUT    = 1'b0;
            RST     = 1'b1;
            INC     = 1'b0;
            SEL_TIM = 2'b00;
            DONE_T  = 1'b0;
        end

        CHECK_DATA: begin
            DOUT    = 1'b0;
            RST     = 1'b0;
            INC     = 1'b0;
            SEL_TIM = 2'b00;
            DONE_T  = 1'b0;
        end 

        SEND_0: begin
            DOUT    = 1'b1;
            RST     = 1'b0;
            INC     = 1'b1;
            SEL_TIM = 2'b00;
            DONE_T  = 1'b0;
        end 

        SEND_1: begin
            DOUT    = 1'b1;
            RST     = 1'b0;
            INC     = 1'b1;
            SEL_TIM = 2'b01;
            DONE_T  = 1'b0;
        end   

        SEND_RST: begin
            DOUT    = 1'b0;
            RST     = 1'b0;
            INC     = 1'b1;
            SEL_TIM = 2'b10;
            DONE_T  = 1'b0;
        end

        INC_COUNT_PER: begin
            DOUT    = 1'b0;
            RST     = 1'b0;
            INC     = 1'b1;
            SEL_TIM = 2'b11;
            DONE_T  = 1'b0;
        end

        FINISH: begin
            DOUT    = 1'b0;
            RST     = 1'b0;
            INC     = 1'b0;
            SEL_TIM = 2'b00;
            DONE_T  = 1'b1;
        end

        default: begin
            DOUT    = 1'b0;
            RST     = 1'b0;
            INC     = 1'b0;
            SEL_TIM = 2'b00;
            DONE_T  = 1'b0;
        end

    endcase
end

//Bloque que asigna codigos ASCII a las señales

`ifdef BENCH
reg [8*12-1:1] state_name;
always @(*) begin
    case (current_state)
        START: state_name = "START";
        RESET_COUNT: state_name = "RESET_COUNT";
        CHECK_DATA: state_name = "CHECK_DATA";
        SEND_0: state_name = "SEND_0";
        SEND_1: state_name = "SEND_1";
        SEND_RST: state_name = "SEND_RST";
        INC_COUNT_PER: state_name = "INC_COUNT_PER";
        FINISH: state_name = "FINISH";
    endcase
end
`endif



endmodule