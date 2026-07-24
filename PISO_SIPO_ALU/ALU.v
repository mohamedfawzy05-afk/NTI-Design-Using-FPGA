module alu #
(
    parameter W = 8 
)
(
    input wire [W-1:0] in_a,
    input wire [W-1:0] in_b,
    input wire [2:0] opsel,
    input wire alu_en,
    output reg a_zero,
    output reg [W-1:0] alu_out
);

always @(*) begin
    if (in_a =='b0) 
    begin 
        a_zero = 1'b1;
    end
     else
    begin
        a_zero = 1'b0;
    end
end

always @(*) begin

    if (alu_en) begin
        case (opsel)

            3'b000: alu_out = in_a + in_b; // ADD
            3'b001: alu_out = in_a - in_b; // SUB
            3'b010: alu_out = in_a & in_b; // AND
            3'b011: alu_out = in_a ^ in_b; // XOR
            3'b100: alu_out = in_a | in_b; // OR
            3'b101: alu_out = in_a;        // A

          default:alu_out ='b0;            //default
        endcase
    end 
    else 
    begin
        alu_out ='b0;                      
    end
end

endmodule
