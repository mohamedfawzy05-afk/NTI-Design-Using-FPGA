module counter #(
    parameter WIDTH = 5
) (
    input wire clk,
    input wire rst,
    input wire load,
    input wire en,
    input wire [WIDTH-1:0] count_in,
    output reg [WIDTH-1:0] count_out
);

    reg [WIDTH-1:0] next_count;

    always @(*) begin
        if (load)
            next_count = count_in;
        else if (en)
            next_count = count_out + 1;
        else
            next_count = count_out;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            count_out <= {WIDTH{1'b0}};
        else
            count_out <= next_count;
    end

endmodule