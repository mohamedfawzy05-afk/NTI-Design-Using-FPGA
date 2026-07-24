module full_adder (
    input a,
    input b,
    input cin,
    output sum,
    output cout                         
);

    // Sum is the XOR of all three inputs
    assign sum = a ^ b ^ cin;
    
    // Carry out logic
    assign cout = (a & b) | (cin & (a ^ b));

endmodule