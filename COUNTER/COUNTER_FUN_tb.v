`timescale 1ns / 1ps

module counter_with_function_tb;

    parameter WIDTH = 5;

    reg clk;
    reg rst;
    reg load;
    reg en;
    reg  [WIDTH-1:0] count_in;
    wire [WIDTH-1:0] count_out;

    counter_with_function #(
        .WIDTH(WIDTH)
    ) dut (
        .clk     (clk),
        .rst     (rst),
        .load    (load),
        .enab    (en),
        .cnt_in  (count_in),
        .cnt_out (count_out)
    );

    always #5 clk = ~clk;

    task drive_and_check;
        input t_rst;
        input t_load;
        input t_enab;
        input [WIDTH-1:0] t_cnt_in;
        input [WIDTH-1:0] exp_out;
        begin
            rst = t_rst;
            load = t_load;
            enab = t_en;
            count_in = t_count_in;
            #10;
            
        end
    endtask

    initial begin
        clk = 0;
        rst = 0;
        load = 0;
        enab = 0;
        count_in = 0;

        #10;

        drive_and_check(0, 1, 1, 5'b10101, 5'b10101);
        drive_and_check(0, 1, 1, 5'b01010, 5'b01010);
        drive_and_check(0, 1, 1, 5'b11111, 5'b11111);
        drive_and_check(1, 1, 1, 5'b11111, 5'b00000);
        drive_and_check(0, 1, 1, 5'b11111, 5'b1111１);
        drive_and_check(0, 0, １, 5'b１１１１１, 5'b０００００  );


        $finish;
    end

endmodule
