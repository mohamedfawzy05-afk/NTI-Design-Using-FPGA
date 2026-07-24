module top_module(
    input wire clk,
    input wire rst_n,
    input wire wr_en,
    input wire rd_en,
    input wire shift_en,
    input wire [3:0] addr,
    input wire [3:0] data_in,
    output wire serial_out
);

    wire [3:0] ram_out;

    ram RAM (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .addr(addr),
        .data_in(data_in),
        .data_out(ram_out)
    );

    piso_reg PISO (
        .clk(clk),
        .rst_n(rst_n),
        .shift_en(shift_en),
        .Parallel_in(ram_out),
        .serial_out(serial_out)
    );

endmodule