`timescale 1ns / 1ps

module controller_tb;

    reg clk;
    reg rst;
    reg zero;
    reg [2:0] phase;
    reg [2:0] opcode;

    wire sel, rd, ld_ir, halt, inc_pc, ld_ac, ld_pc, wr, data_e;

    control dut (
        .clk(clk),
        .rst(rst),
        .zero(zero),
        .phase(phase),
        .opcode(opcode),
        .sel(sel),
        .rd(rd),
        .ld_ir(ld_ir),
        .halt(halt),
        .inc_pc(inc_pc),
        .ld_ac(ld_ac),
        .ld_pc(ld_pc),
        .wr(wr),
        .data_e(data_e)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    integer op, ph;

    initial begin
        rst = 1;
        zero = 0;
        phase = 0;
        opcode = 0;

        #10;
        rst = 0;

        for (op = 0; op < 8; op = op + 1) begin
            for (ph = 0; ph < 8; ph = ph + 1) begin
                opcode = op;
                phase = ph;
                zero = (op == 1);
                #10;
            end
        end

        $finish;
    end

endmodule