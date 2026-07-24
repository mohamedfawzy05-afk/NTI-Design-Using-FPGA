module control(
    input clk,
    input rst,
    input zero,
    input [2:0] phase,
    input [2:0] opcode,

    output reg sel,
    output reg rd,
    output reg ld_ir,
    output reg halt,
    output reg inc_pc,
    output reg ld_ac,
    output reg ld_pc,
    output reg wr,
    output reg data_e
);

    reg is_alu_inst;

    always @(*) begin
        if (opcode >= 3'b010 && opcode <= 3'b101)
            is_alu_inst = 1;
        else
            is_alu_inst = 0;
    end

    always @(posedge clk) begin

        if (rst) begin
            sel    <= 0;
            rd     <= 0;
            ld_ir  <= 0;
            halt   <= 0;
            inc_pc <= 0;
            ld_ac  <= 0;
            ld_pc  <= 0;
            wr     <= 0;
            data_e <= 0;
        end 

        else begin
            sel    <= 0;
            rd     <= 0;
            ld_ir  <= 0;
            halt   <= 0;
            inc_pc <= 0;
            ld_ac  <= 0;
            ld_pc  <= 0;
            wr     <= 0;
            data_e <= 0;

            case (phase)

                3'b000: begin
                    sel <= 1;
                end

                3'b001: begin
                    sel <= 1;
                    rd  <= 1;
                end

                3'b010: begin
                    sel   <= 1;
                    rd    <= 1;
                    ld_ir <= 1;
                end

                3'b011: begin
                    sel   <= 1;
                    rd    <= 1;
                    ld_ir <= 1;
                end

                3'b100: begin
                    inc_pc <= 1;

                    if (opcode == 3'b000) begin
                        halt <= 1;
                    end
                end

                3'b101: begin
                    rd <= is_alu_inst;
                end

                3'b110: begin
                    rd <= is_alu_inst;

                    if (opcode == 3'b001 && zero == 1) begin
                        inc_pc <= 1;
                    end

                    if (opcode == 3'b111) begin
                        ld_pc <= 1;
                    end

                    if (opcode == 3'b110) begin
                        data_e <= 1;
                    end
                end

                3'b111: begin
                    rd    <= is_alu_inst;
                    ld_ac <= is_alu_inst;

                    if (opcode == 3'b111) begin
                        ld_pc <= 1;
                    end

                    if (opcode == 3'b110) begin
                        wr     <= 1;
                        data_e <= 1;
                    end
                end

                default: begin
                    sel    <= 0;
                    rd     <= 0;
                    ld_ir  <= 0;
                    halt   <= 0;
                    inc_pc <= 0;
                    ld_ac  <= 0;
                    ld_pc  <= 0;
                    wr     <= 0;
                    data_e <= 0;
                end

            endcase
        end

    end

endmodule