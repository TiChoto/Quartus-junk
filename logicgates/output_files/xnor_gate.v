module xnor_gate ( // Xnor gate
    input a, b,
    output y
);
    assign y = ~(a ^ b);
endmodule