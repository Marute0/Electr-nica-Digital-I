module root_control #(

// Establecimiento de los estados como parámetros

    parameter START = 3'b000,
    parameter SHIFT_VAUX_A = 3'b001,
    parameter CHECK1 = 3'b010,
    parameter LOAD = 3'b011,
    parameter DECI = 3'b100,
    parameter CHECK2 = 3'b101,
    parameter NEXT_SHIFT = 3'b110,
    parameter FINISH = 3'b111

) (

    input clk,
    input init,
    input residuo_MSB,
    input zero,
    input rst,


    output reg LD,
    output reg LDRes,
    output reg SH0,
    output reg SH1,
    output reg DEC,
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
                        current_state = SHIFT_VAUX_A;
                        count = 0;
                    end else begin
                        current_state = START;
                    end
                end

                SHIFT_VAUX_A: begin
                    current_state = CHECK1;
                end

                CHECK1: begin
                    if(residuo_MSB) begin
                        current_state = DECI;
                    end else begin 
                        current_state = LOAD;
                    end
                end

                LOAD: begin
                    current_state = DECI;
                end

                DECI: begin
                    current_state = CHECK2;
                end

                CHECK2: begin
                    if (zero) begin
                        current_state = FINISH;
                    end else begin
                        current_state = NEXT_SHIFT;
                    end
                end

                NEXT_SHIFT: begin
                    current_state = SHIFT_VAUX_A;
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
            LD    <= 1;
            LDRes <= 0;
            SH0   <= 0;
            SH1   <= 0;
            DEC  <= 0;
            done  <= 0;
        end

        SHIFT_VAUX_A: begin
            LD    <= 0;
            LDRes <= 0;
            SH0   <= 1;
            SH1   <= 0;
            DEC  <= 0;
            done  <= 0;
        end

        CHECK1: begin
            LD    <= 0;
            LDRes <= 0;
            SH0   <= 0;
            SH1   <= 0;
            DEC  <= 0;
            done  <= 0;
        end

        LOAD: begin
            LD    <= 0;
            LDRes <= 1;
            SH0   <= 0;
            SH1   <= 0;
            DEC  <= 0;
            done  <= 0;
        end 

        DECI: begin
            LD    <= 0;
            LDRes <= 0;
            SH0   <= 0;
            SH1   <= 0;
            DEC  <= 1;
            done  <= 0;
        end 

        CHECK2: begin
            LD    <= 0;
            LDRes <= 0;
            SH0   <= 0;
            SH1   <= 0;
            DEC  <= 0;
            done  <= 0;
        end   

        NEXT_SHIFT: begin
            LD    <= 0;
            LDRes <= 0;
            SH0   <= 0;
            SH1   <= 1;
            DEC  <= 0;
            done  <= 0;
        end

        FINISH: begin
            LD    <= 0;
            LDRes <= 0;
            SH0   <= 0;
            SH1   <= 0;
            DEC  <= 0;
            done  <= 1;
        end

        default: begin
            LD    = 1'b0;
            LDRes = 1'b0;
            SH0   = 1'b0;
            SH1   = 1'b0;
            DEC  = 1'b0;
            done  = 1'b0;
        end

    endcase
end

//Bloque que asigna codigos ASCII a las señales

`ifdef BENCH
reg [8*12-1:1] state_name;
always @(*) begin
    case (current_state)
        START: state_name = "START";
        SHIFT_VAUX_A: state_name = "SHIFT_VAUX_A";
        CHECK1: state_name = "CHECK1";
        LOAD: state_name = "LOAD";
        DECI: state_name = "DECI";
        CHECK2: state_name = "CHECK2";
        NEXT_SHIFT: state_name = "NEXT_SHIFT";
        FINISH: state_name = "FINISH";
    endcase
end
`endif



endmodule