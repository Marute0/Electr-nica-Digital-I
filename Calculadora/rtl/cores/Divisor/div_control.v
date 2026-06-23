module div_control #(

// Establecimiento de los estados como parámetros

    parameter START = 3'b000,
    parameter CHECK1 = 3'b001,
    parameter LOAD = 3'b010,
    parameter DEC_SHIFT = 3'b011,
    parameter CHECK2 = 3'b100,
    parameter SHIFT2 = 3'b101,
    parameter FINISH = 3'b110

) (

    input clk,
    input init,
    input residuo_MSB,
    input zero,
    input rst,


    output reg LD0,
    output reg LD1,
    output reg SH0,
    output reg SH1,
    output reg DECI,
    output reg done

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

                CHECK1: begin
                    if(residuo_MSB) begin
                        current_state = DEC_SHIFT;
                    end else begin 
                        current_state = LOAD;
                    end
                end

                LOAD: begin
                    current_state = DEC_SHIFT;
                end

                DEC_SHIFT: begin
                    current_state = CHECK2;
                end

                CHECK2: begin
                    if (zero) begin
                        current_state = FINISH;
                    end else begin
                        current_state = SHIFT2;
                    end
                end

                SHIFT2: begin
                    current_state = CHECK1;
                end

                FINISH: begin
                    count = count + 1;
                    current_state = (count>31) ? START : FINISH ;
                end

                default: current_state = START;
            
            endcase
        end
    end

// Salidas según el estado

always @(*) begin
    LD0  = 1'b0;
    LD1  = 1'b0;
    SH0  = 1'b0;
    SH1  = 1'b0;
    DECI = 1'b0;
    done = 1'b0;

    case (current_state)

        START: begin
            LD0  <= 1;
            LD1  <= 0;
            SH0  <= 0;
            SH1  <= 0;
            DECI <= 0;
            done <= 0;
        end

        CHECK1: begin
            LD0  <= 0;
            LD1  <= 0;
            SH0  <= 0;
            SH1  <= 0;
            DECI <= 0;
            done <= 0;
        end

        LOAD: begin
            LD0  <= 0;
            LD1  <= 1;
            SH0  <= 0;
            SH1  <= 0;
            DECI <= 0;
            done <= 0;
        end


        DEC_SHIFT: begin
            LD0  <= 0;
            LD1  <= 0;
            SH0  <= 1;
            SH1  <= 0;
            DECI <= 1;
            done <= 0;
        end 

        CHECK2: begin
            LD0  <= 0;
            LD1  <= 0;
            SH0  <= 0;
            SH1  <= 0;
            DECI <= 0;
            done <= 0;
        end   

        SHIFT2: begin
            LD0  <= 0;
            LD1  <= 0;
            SH0  <= 0;
            SH1  <= 1;
            DECI <= 0;
            done <= 0;
        end

        FINISH: begin
            LD0  <= 0;
            LD1  <= 0;
            SH0  <= 0;
            SH1  <= 0;
            DECI <= 0;
            done <= 1;
        end

    default: begin
            LD0  <= 0;
            LD1  <= 0;
            SH0  <= 0;
            SH1  <= 0;
            DECI <= 0;
            done <= 0;
       end

    endcase
end

//Bloque que asigna codigos ASCII a las señales

`ifdef BENCH
reg [8*40-12:1] state_name;
always @(*) begin
    case (current_state)
        START: state_name <= "START";
        CHECK1: state_name <= "CHECK1";
        LOAD: state_name <= "LOAD";
        DEC_SHIFT: state_name <= "DEC_SHIFT";
        CHECK2: state_name <= "CHECK2";
        SHIFT2: state_name <= "SHIFT2";
        FINISH: state_name <= "FINISH";
    endcase
end
`endif



endmodule