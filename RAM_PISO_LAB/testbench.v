`timescale 1ns/1ps

module top_module_tb;

    reg clk;
    reg rst_n;
    reg wr_en;
    reg rd_en;
    reg shift_en;
    reg [3:0] addr;
    reg [3:0] data_in;
    wire serial_out;
    top_module DUT(
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .shift_en(shift_en),
        .addr(addr),
        .data_in(data_in),
        .serial_out(serial_out)
    );

    always #5 clk = ~clk;

    initial
    begin
        clk = 0;
        rst_n = 0;
        wr_en = 0;
        rd_en = 0;
        shift_en = 0;
        addr = 4'b0000;
        data_in = 4'b0000;

        #10;

        rst_n = 1;
        addr = 4'b0000;
        data_in = 4'b1010;
        wr_en = 1;
        #10;

        wr_en = 0;
        rd_en = 1;
        #10;
        rd_en = 0;

        shift_en = 1;
        #40;

        $stop;
    end

endmodule