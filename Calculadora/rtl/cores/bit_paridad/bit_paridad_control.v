module mult_control #(

// Establecimiento de los estados como parámetros

    parameter START = 3'b000,
    parameter CHECK1 = 3'b001,
    parameter ADDER = 3'b010,
    parameter SHIFT = 3'b011,
    parameter CHECK_A = 3'b100,
    parameter FINISH = 3'b101
) (

    input clk,
    input init,
    input LSB_A,
    input z,
    input rst,

    output reg done,
    output reg LD,
    output reg SH,
    output reg ADDI,
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
                        current_state = CHECK1;
                        count = 0;
                    end else begin
                        current_state = START;
                    end
                end

                CHECK: begin
                    if(LSB_A) begin
                        current_state = ADDER;
                    end else begin 
                        current_state = SHIFT;
                    end
                end

                ADDER: begin
                    current_state = SHIFT;
                end

                SHIFT: begin
                    current_state = CHECK_A;
                end

                CHECK_A: begin
                    if (z) begin
                        current_state = FINISH;
                    end else begin
                        current_state = CHECK1;
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
            ADDI <= 0;
            done <= 0;
        end

        CHECK1: begin
            LD <= 0;
            SH <= 0;
            ADDI <= 0;
            done <= 0;
        end

        ADDER: begin
            LD <= 0;
            SH <= 0;
            ADDI <= 1;
            done <= 0;
        end 

        SHIFT: begin
            LD <= 0;
            SH <= 1;
            ADDI <= 0;
            done <= 0;
        end   

        CHECK_A: begin
            LD <= 0;
            SH <= 0;
            ADDI <= 0;
            done <= 0;
        end

        FINISH: begin
            LD <= 0;
            SH <= 0;
            ADDI <= 0;
            done <= 1;
        end

    default: begin
        LD   = 0;
        SH   = 0;
        ADDI = 0;
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
        CHECK1: state_name = "CHECK1";
        ADDER: state_name = "ADDER";
        SHIFT: state_name = "SHIFT";
        CHECK_A: state_name = "CHECK_A";
        FINISH: state_name = "FINISH";
    endcase
end
`endif



endmodule