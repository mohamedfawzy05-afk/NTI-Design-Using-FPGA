module SEQ_OVERLAP_DETECT (
    input clk,
    input reset,
    input serial_in,
    output reg sequence_detected
);

    parameter S0 = 0;
    parameter S1 = 1;
    parameter S2 = 2;
    parameter S3 = 3;
    parameter S4 = 4;
    parameter S5 = 5;
    parameter S6 = 6;

    reg [2:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        case (state)
            S0: begin
                if (serial_in)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (serial_in)
                    next_state = S2;
                else
                    next_state = S0;
            end

            S2: begin
                if (serial_in)
                    next_state = S2;
                else
                    next_state = S3;
            end

            S3: begin
                if (serial_in)
                    next_state = S4;
                else
                    next_state = S0;
            end

            S4: begin
                if (serial_in)
                    next_state = S2;
                else
                    next_state = S5;
            end

            S5: begin
                if (serial_in)
                    next_state = S6;
                else
                    next_state = S0;
            end

            S6: begin
                if (serial_in)
                    next_state = S2;
                else
                    next_state = S0;
            end

            default: next_state = S0;
        endcase
    end

    always @(*) begin
        if (state == S6)
            sequence_detected = 1;
        else
            sequence_detected = 0;
    end

endmodule