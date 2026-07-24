`timescale 1ns / 1ps

module tb_edge_detectors;

    logic clk;
    logic reset;
    logic level;
    logic tick_mealy;
    logic tick_moore;

    rising_edge_mealy uut_mealy (
        .clk(clk),
        .reset(reset),
        .level(level),
        .tick(tick_mealy)
    );

    rising_edge_moore uut_moore (
        .clk(clk),
        .reset(reset),
        .level(level),
        .tick(tick_moore)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        level = 0;
        #10;

        reset = 0;
        #10;

        level = 1;
        #30;

        level = 0;
        #20;

        level = 1;
        #20;

        $finish;
    end

endmodule