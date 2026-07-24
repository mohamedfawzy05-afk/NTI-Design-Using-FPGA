module rising_edge_moore (
    input  logic clk,
    input  logic reset,
    input  logic level,
    output logic tick
);

    typedef enum logic [1:0] {zero, edg, one} state_type;
    state_type present_state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            present_state <= zero;
        else
            present_state <= next_state;
    end

    
    always_comb begin

        next_state = present_state;
        tick = 1'b0; 

        case (present_state)
            zero: begin
                tick = 1'b0; 
                if (level) 
                    next_state = edg;
                else       
                    next_state = zero;
            end

            edg: begin
                tick = 1'b1; 
                if (level) 
                    next_state = one;
                else       
                    next_state = zero;
            end

            one: begin
                tick = 1'b0; 
                if (level) 
                    next_state = one;
                else       
                    next_state = zero;
            end

            default: next_state = zero;
        endcase
    end

endmodule