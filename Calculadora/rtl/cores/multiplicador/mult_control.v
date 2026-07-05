module mult_control #(

// Establecimiento de los estados como parámetros

    parameter START = 3'b000,
    parameter CHECK = 3'b001,
    parameter ACCUMULATE = 3'b010,
    parameter INC_SHIFT = 3'b011,
    parameter FCHECK = 3'b100,
    parameter FINISH = 3'b101
) (

    input clk,
    input init,
    input A_i,
    input z,
    input rst,

    output reg done,
    output reg LD,
    output reg SH,
    output reg ADDI,
    output reg ADDB
);


// Maquina de estados: lógica de transición

    reg [2:0] current_state;
    reg [4:0] count;


    always @(posedge clk) begin

        if(rst) begin
            current_state = START;
            
        end else begin

            case (current_state)
                START: begin
                    if (init) begin
                        current_state = CHECK;
                        count = 0;
                    end else begin
                        current_state = START;
                    end
                end

                CHECK: begin
                    if(A_i) begin
                        current_state = ACCUMULATE;
                    end else begin 
                        current_state = INC_SHIFT;
                    end
                end

                ACCUMULATE: begin
                    current_state = INC_SHIFT;
                end

                INC_SHIFT: begin
                    current_state = FCHECK;
                end

                FCHECK: begin
                    if (z) begin
                        current_state = FINISH;
                    end else begin
                        current_state = CHECK;
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
            LD <= 1;
            SH <= 0;
            ADDB <= 0;
            ADDI <= 0;
            done <= 0;
        end

        CHECK: begin
            LD <= 0;
            SH <= 0;
            ADDB <= 0;
            ADDI <= 0;
            done <= 0;
        end

        ACCUMULATE: begin
            LD <= 0;
            SH <= 0;
            ADDB <= 1;
            ADDI <= 0;
            done <= 0;
        end 

        INC_SHIFT: begin
            LD <= 0;
            SH <= 1;
            ADDB <= 0;
            ADDI <= 1;
            done <= 0;
        end   

        FCHECK: begin
            LD <= 0;
            SH <= 0;
            ADDB <= 0;
            ADDI <= 0;
            done <= 0;
        end

        FINISH: begin
            LD <= 0;
            SH <= 0;
            ADDB <= 0;
            ADDI <= 0;
            done <= 1;
        end

    default: begin
        LD   = 0;
        SH   = 0;
        ADDI = 0;
        ADDB = 0;
        done = 0;
       end

    endcase
end

//Bloque que asigna codigos ASCII a las señales

`ifdef BENCH
reg [8*40:1] state_name;
always @(*) begin
    case (current_state)
        START: state_name = "START";
        CHECK: state_name = "CHECK";
        ACCUMULATE: state_name = "ACCUMULATE";
        INC_SHIFT: state_name = "INC_SHIFT";
        FCHECK: state_name = "FCHECK";
        FINISH: state_name = "FINISH";
    endcase
end
`endif



endmodule
