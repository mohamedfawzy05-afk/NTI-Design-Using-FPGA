    module behavioral_FA( 
    input A,
    input B,
    input Cin,
    output reg S,
    output reg Cout
    );

    always @(*) begin

    {Cout, S} = A + B + Cin;

    end
    endmodule



    