module send_LEDS_control #(

// Establecimiento de los estados como parámetros

    parameter START = 3'b000,
    parameter CHECK_INIT = 3'b001,
    parameter SEND_GRB = 3'b010,
    parameter STOP_GRB = 3'b011,
    parameter CHECK_DONE = 3'b100,
    parameter INC_COUNT = 3'b101,
    parameter CHECK_ADDR = 3'b110,
    parameter FINISH = 3'b111

) (

    input clk,
    input INIT_M,
    input DONE_LED,
    input rst,
    input Z,

    output reg INIT_LED,
    output reg RST,
    output reg INC,
    output reg DONE_M

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
                current_state = CHECK_INIT;
            end

            CHECK_INIT: begin
                if (INIT_M) begin
                    current_state = SEND_GRB;
                    count = 0;
                end else begin
                    current_state = CHECK_INIT;
                end
            end

            SEND_GRB: begin
                current_state = STOP_GRB;
            end

            STOP_GRB: begin
                current_state = CHECK_DONE;
            end

            CHECK_DONE: begin
                if(DONE_LED) begin
                    current_state = INC_COUNT;
                end else begin 
                    current_state = CHECK_DONE;
                end
            end

            INC_COUNT: begin
                current_state = CHECK_ADDR;
            end

            CHECK_ADDR: begin
                if (Z) begin
                    current_state = FINISH;
                end else begin
                    current_state = SEND_GRB;
                end
            end

            FINISH: begin
                count = count + 1;
                current_state = (count>28) ? START : FINISH ;
            end

            default: current_state = START;
        endcase

        end
    end

// Salidas según el estado

always @(*) begin

    case (current_state)

        START: begin
            INIT_LED = 1'b0;
            RST      = 1'b1;
            INC      = 1'b0;
            DONE_M   = 1'b0;
        end

        CHECK_INIT: begin
            INIT_LED = 1'b0;
            RST      = 1'b0;
            INC      = 1'b0;
            DONE_M   = 1'b0;
        end

        SEND_GRB: begin
            INIT_LED = 1'b1;
            RST      = 1'b0;
            INC      = 1'b0;
            DONE_M   = 1'b0;
        end

        STOP_GRB: begin
            INIT_LED = 1'b0;
            RST      = 1'b0;
            INC      = 1'b0;
            DONE_M   = 1'b0;
        end 

        CHECK_DONE: begin
            INIT_LED = 1'b0;
            RST      = 1'b0;
            INC      = 1'b0;
            DONE_M   = 1'b0;
        end 

        INC_COUNT: begin
            INIT_LED = 1'b0;
            RST      = 1'b0;
            INC      = 1'b1;
            DONE_M   = 1'b0;
        end   

        CHECK_ADDR: begin
            INIT_LED = 1'b0;
            RST      = 1'b0;
            INC      = 1'b0;
            DONE_M   = 1'b0;
        end

        FINISH: begin
            INIT_LED = 1'b0;
            RST      = 1'b0;
            INC      = 1'b0;
            DONE_M   = 1'b1;
        end

        default: begin
            INIT_LED = 1'b0;
            RST      = 1'b0;
            INC      = 1'b0;
            DONE_M   = 1'b0;
        end

    endcase
end

//Bloque que asigna codigos ASCII a las señales

`ifdef BENCH
reg [8*12-1:1] state_name;
always @(*) begin
    case (current_state)
        START: state_name = "START";
        CHECK_INIT: state_name = "CHECK_INIT";
        SEND_GRB: state_name = "SEND_GRB";
        STOP_GRB: state_name = "STOP_GRB";
        CHECK_DONE: state_name = "CHECK_DONE";
        INC_COUNT: state_name = "INC_COUNT";
        CHECK_ADDR: state_name = "CHECK_ADDR";
        FINISH: state_name = "FINISH";
    endcase
end
`endif



endmodule