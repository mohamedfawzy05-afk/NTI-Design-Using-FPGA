module piso_reg #(
    parameter PISO_W = 4
)(
    input wire clk,
    input wire rst_n,      // low async
    input wire shift_en,
    input wire [PISO_W-1:0] Parallel_in,
    output wire serial_out
);

    reg [PISO_W-1:0] SER_out;

    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
        begin
            SER_out <= 'b0;
        end
        else if (shift_en)
        begin
            SER_out <= {1'b0, SER_out[PISO_W-1:1]};
        end
    end

    assign serial_out = SER_out[0];

endmodule