module fsm (
    input  wire clk,
    input  wire reset,
    input  wire a,
    input  wire b,
    output reg  y0,
    output reg  y1
);

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;

    reg [1:0] state, next_state;

    always @(posedge clk or negedge reset) begin
        if (!reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        next_state = state;
        y0 = 0;
        y1 = 1;

        case (state)
            S0: begin
                y0 = a & b;
                if (!a)
                    next_state = S0;
                else if (b)
                    next_state = S2;
                else
                    next_state = S1;
            end

            S1: begin
                if (a)
                    next_state = S0;
                else
                    next_state = S1;
            end

            S2: begin
                y1 = 0;
                next_state = S0;
            end

            default: next_state = S0;
        endcase
    end

endmodule