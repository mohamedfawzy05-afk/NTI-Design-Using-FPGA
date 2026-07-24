`timescale 1ns / 1ps

module tb_adder_subtractor;
    reg  [3:0] in1;
    reg  [3:0] in2;
    reg        en;
    wire [3:0] out;
    wire       carry;

    adder_subtractor uut (
        .in1(in1),
        .in2(in2),
        .en(en),
        .out(out),
        .carry(carry)
    );
    initial begin
        en  = 1;
        in1 = 5;
        in2 = 3;
        #10;

        en  = 0;
        in1 = 5;
        in2 = 3;
        #10;

        en  = 1;
        in1 = 10;
        in2 = 7;
        #10;

        $finish; 
    end

endmodule