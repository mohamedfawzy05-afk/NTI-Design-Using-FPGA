module adder_subtractor(

    input  wire [3:0] in1,
    input  wire [3:0] in2,
    input  wire en, 
    output reg  [3:0] out,      
    output reg carry   
);

    always @(*)  begin
         if (en) 
        begin
             {carry, out} = in1 + in2;
        end 
        else
         begin
             {carry, out} = in1 - in2;
         end
    end
endmodule