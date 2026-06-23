module ws2812_control #(

// Establecimiento de los estados como parámetros

    parameter START = 3'b000,
    parameter LOAD = 3'b001,
    parameter INIT_TIMER = 3'b010,
    parameter CHECK_TIMER = 3'b011,
    parameter DEC_SHIFT = 3'b100,
    parameter CHECK_COUNT = 3'b101,
    parameter FINISH = 3'b110

) (

    input clk,
    input INIT,
    input rst,
    input DONE_T,
    input Z,

    output reg LD,
    output reg INIT_T,
    output reg DEC,
    output reg SH,
    output reg DONE

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
                if (INIT) begin
                    current_state = LOAD;
                    count = 0;
                end else begin
                    current_state = START;
                end
            end

            LOAD: begin
                current_state = INIT_TIMER;
            end

            INIT_TIMER: begin
                current_state = CHECK_TIMER;
            end

            CHECK_TIMER: begin
                if(DONE_T) begin
                    current_state = DEC_SHIFT;
                end else begin 
                    current_state = CHECK_TIMER;
                end
            end

            DEC_SHIFT: begin
                current_state = CHECK_COUNT;
            end


            CHECK_COUNT: begin
                if (Z) begin
                    current_state = FINISH;
                end else begin
                    current_state = INIT_TIMER;
                end
            end

            FINISH: begin
                count = count + 1;
                current_state = (count>1) ? START : FINISH ;
            end

            default: current_state = START;
            
        endcase

        end
    end

// Salidas según el estado

always @(*) begin

    case (current_state)

        START: begin
            LD     = 1'b0;
            INIT_T = 1'b0;
            DEC    = 1'b0;
            SH     = 1'b0;
            DONE   = 1'b0;
        end

        LOAD: begin
            LD     = 1'b1;
            INIT_T = 1'b0;
            DEC    = 1'b0;
            SH     = 1'b0;
            DONE   = 1'b0;
        end

        INIT_TIMER: begin
            LD     = 1'b0;
            INIT_T = 1'b1;
            DEC    = 1'b0;
            SH     = 1'b0;
            DONE   = 1'b0;
        end 

        CHECK_TIMER: begin
            LD     = 1'b0;
            INIT_T = 1'b0;
            DEC    = 1'b0;
            SH     = 1'b0;
            DONE   = 1'b0;
        end 

        DEC_SHIFT: begin
            LD     = 1'b0;
            INIT_T = 1'b0;
            DEC    = 1'b1;
            SH     = 1'b1;
            DONE   = 1'b0;
        end   

        CHECK_COUNT: begin
            LD     = 1'b0;
            INIT_T = 1'b0;
            DEC    = 1'b0;
            SH     = 1'b0;
            DONE   = 1'b0;
        end

        FINISH: begin
            LD     = 1'b0;
            INIT_T = 1'b0;
            DEC    = 1'b0;
            SH     = 1'b0;
            DONE   = 1'b1;
        end

        default: begin
            LD     = 1'b0;
            INIT_T = 1'b0;
            DEC    = 1'b0;
            SH     = 1'b0;
            DONE   = 1'b0;
        end

    endcase
end

//Bloque que asigna codigos ASCII a las señales

`ifdef BENCH
reg [8*12-1:1] state_name;
always @(*) begin
    case (current_state)
        START: state_name = "START";
        LOAD: state_name = "LOAD";
        INIT_TIMER: state_name = "INIT_TIMER";
        CHECK_TIMER: state_name = "CHECK_TIMER";
        DEC_SHIFT: state_name = "DEC_SHIFT";
        CHECK_COUNT: state_name = "CHECK_COUNT";
        FINISH: state_name = "FINISH";
    endcase
end
`endif



endmodule