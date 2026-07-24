`timescale 1ns / 1ps

module stream_parity_gen_tb;

    reg clk;
    reg reset;
    reg serial_in;
    wire parity_out;

    stream_parity_gen dut (
        .clk(clk),
        .reset(reset),
        .serial_in(serial_in),
        .parity_out(parity_out)
    );

    always #5 clk = ~clk;

    reg [7:0] expected_shift_reg;
    wire expected_parity;

    assign expected_parity = ^expected_shift_reg;

    always @(posedge clk) begin
        if (reset)
            expected_shift_reg <= 8'b0000_0000;
        else
            expected_shift_reg <= {expected_shift_reg[6:0], serial_in};
    end



    integer i;

    initial begin
        clk = 0;
        reset = 1;
        serial_in = 0;

        #15;
        reset = 0;


        for (i = 0; i < 100; i = i + 1) begin
            @(negedge clk);
            serial_in = $random % 2;
        end

        #20;

        $finish;
    end

endmodule