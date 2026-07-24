module counter_with_function #(
    parameter WIDTH = 5
) (
    input wire clk,
    input wire rst,
    input wire load,
    input wire en,
    input wire [WIDTH-1:0] count_in,
    output reg [WIDTH-1:0] count_out
);

    function [WIDTH-1:0] get_next_count;
        input load_val;
        input en_val;
        input [WIDTH-1:0] in_val;
        input [WIDTH-1:0] current_val;
        begin
            if (load_val)
                get_next_count = in_val;
            else if (en_val)
                get_next_count = current_val + 1;
            else
                get_next_count = current_val;
        end
    endfunction

    always @(posedge clk or posedge rst) begin
        if (rst)
            count_out <= {WIDTH{1'b0}};
        else
            count_out <= get_next_count(load, en, count_in, count_out);
    end

endmodule