module add_sub (
    input [3:0] in1,   
    input [3:0] in2,    
    input en,       
    output [3:0] R,   
    output cout,      

if(en) begin
    assign R = in1 + in2; 
end
 else 
 begin
    assign R = in1 - in2; 

 end



endmodule

