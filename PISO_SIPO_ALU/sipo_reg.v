module sipo_reg #(
    parameter SIPO_W = 20,
    parameter ALU_W = 8
)(
    input wire clk,               
    input wire rst_n,  //low asynch
    input wire shift_en,        
    input wire serial_in,         
    output wire [ALU_W-1:0] alu_out,
    output wire a_zero         
);

    reg [SIPO_W-1:0] parallel_out;

    always @(posedge clk or negedge rst_n) 
    begin
        if (!rst_n) 
        begin
            parallel_out <= 'b0;
        end
        else if (shift_en) 
        begin
            parallel_out <= {parallel_out[SIPO_W-2:0], serial_in};
        end
        
    end

 //mapping
alu u_alu (
    .in_a(parallel_out[15:8]),
    .in_b(parallel_out[7:0]),
    .opsel(parallel_out[18:16]),
    .alu_en(parallel_out[19]),
    .a_zero(a_zero),
    .alu_out(alu_out)
);

endmodule