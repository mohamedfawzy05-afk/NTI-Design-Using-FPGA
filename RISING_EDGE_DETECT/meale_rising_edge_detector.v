module rising_edge_mealy (
    input  logic clk,
    input  logic reset,
    input  logic level,
    output logic tick
);

    typedef enum logic {zero, one} state_type;
    state_type present_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            present_state <= zero;
        else
            present_state <= next_state;
    end

    always_comb begin
        tick = 1'b0; 
        next_state = present_state; 

        case(present_state)
            zero: begin
                if (level) 
                begin
                    next_state = one;
                    tick = 1'b1;
                end
                 else 
                begin
                    next_state = zero;
                end
            end

            one: begin
                if (level) begin
                    next_state = one;
                end else begin
                    next_state = zero;
                end
            end
            
            default: next_state = zero;
        endcase
    end

endmodule