module ram(
    input wire clk,
    input wire rst_n,      // low async
    input wire wr_en,
    input wire rd_en,
    input wire [3:0] data_in,
    input wire [3:0] addr,
    output reg [3:0] data_out
);
    integer i;
    reg [3:0] mem [15:0];

    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n)
        begin
            data_out <= 'b0;
            for (i = 0; i < 16; i = i + 1)
                mem[i] <= 'b0;  

        end
        else if (wr_en)   
        begin
            mem[addr] <= data_in;
        end
        else if (rd_en)
        begin
            data_out <= mem[addr];
        end
    end

endmodule