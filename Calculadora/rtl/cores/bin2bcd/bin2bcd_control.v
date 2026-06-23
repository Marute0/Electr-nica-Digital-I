module bin2bcd_control #(

// Establecimiento de los estados como parámetros

    parameter START = 4'b0000,
    parameter SHIFT = 4'b0001,
    parameter CHECK = 4'b0010,
    parameter LOAD_O = 4'b0011,
    parameter LOAD_T = 4'b0100,
    parameter LOAD_H = 4'b0101,
    parameter DEC_I = 4'b0110,
    parameter FCHECK = 4'b0111,
    parameter FINISH = 4'b1000

) (

    input clk,
    input init,
    input rst,
    input O,
    input T,
    input H,
    input Z,

    output reg done,
    output reg LD0,
    output reg LD1,
    output reg LD2,
    output reg LD3,
    output reg DEC,
    output reg SH

);


// Maquina de estados: lógica de transición

    reg [3:0] current_state;
    reg [4:0] count;

    always @(negedge clk) begin

        if(rst) begin
            current_state = START;
            
        end else begin

            case (current_state)
                START: begin
                    if (init) begin
                        current_state = SHIFT;
                        count = 0;
                    end else begin
                        current_state = START;
                    end
                end

                SHIFT: begin
                    current_state = CHECK;
                end

                CHECK: begin
                    if(O) begin
                        current_state = LOAD_O;
                    end else if (T) begin 
                        current_state = LOAD_T;
                    end else if (H) begin 
                        current_state = LOAD_H;
                    end else begin
                        current_state = DEC_I;
                    end
                end

                LOAD_O: begin
                    current_state = DEC_I;
                end

                LOAD_T: begin
                    current_state = DEC_I;
                end

                LOAD_H: begin
                    current_state = DEC_I;
                end  

                DEC_I: begin
                    current_state = FCHECK;
                end            

                FCHECK: begin
                    if (Z) begin
                        current_state = FINISH;
                    end else begin
                        current_state = SHIFT;
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
            LD0  <= 1;
            LD1  <= 0;
            LD2  <= 0;
            LD3  <= 0;
            SH   <= 0;
            DEC  <= 0;
            done <= 0;
        end

        SHIFT: begin
            LD0  <= 0;
            LD1  <= 0;
            LD2  <= 0;
            LD3  <= 0;
            SH   <= 1;
            DEC  <= 0;
            done <= 0;
        end

        CHECK: begin
            LD0  <= 0;
            LD1  <= 0;
            LD2  <= 0;
            LD3  <= 0;
            SH   <= 0;
            DEC  <= 0;
            done <= 0;
        end

        LOAD_O: begin
            LD0  <= 0;
            LD1  <= 1;
            LD2  <= 0;
            LD3  <= 0;
            SH   <= 0;
            DEC  <= 0;
            done <= 0;
        end 

        LOAD_T: begin
            LD0  <= 0;
            LD1  <= 0;
            LD2  <= 1;
            LD3  <= 0;
            SH   <= 0;
            DEC  <= 0;
            done <= 0;
        end   

        LOAD_H: begin
            LD0  <= 0;
            LD1  <= 0;
            LD2  <= 0;
            LD3  <= 1;
            SH   <= 0;
            DEC  <= 0;
            done <= 0;
        end 

        DEC_I: begin
            LD0  <= 0;
            LD1  <= 0;
            LD2  <= 0;
            LD3  <= 0;
            SH   <= 0;
            DEC  <= 1;
            done <= 0;
        end

        FCHECK: begin
            LD0  <= 0;
            LD1  <= 0;
            LD2  <= 0;
            LD3  <= 0;
            SH   <= 0;
            DEC  <= 0;
            done <= 0;
        end

        FINISH: begin
            LD0  <= 0;
            LD1  <= 0;
            LD2  <= 0;
            LD3  <= 0;
            SH   <= 0;
            DEC  <= 0;
            done <= 1;
        end

    default: begin
            LD0  <= 0;
            LD1  <= 0;
            LD2  <= 0;
            LD3  <= 0;
            DEC  <= 0;
            SH   <= 0;
            done <= 0;
       end

    endcase
end

//Bloque que asigna codigos ASCII a las señales

`ifdef BENCH
reg [8*40:1] state_name;
always @(*) begin
    case (current_state)
        START: state_name = "START";
        SHIFT: state_name = "SHIFT";
        CHECK: state_name = "CHECK";
        LOAD_O: state_name = "LOAD_O";
        LOAD_T: state_name = "LOAD_T";
        LOAD_H: state_name = "LOAD_H";
        DEC_I: state_name = "DEC_I";
        FCHECK: state_name = "FCHECK";
        FINISH: state_name = "FINISH";
    endcase
end
`endif



endmodule