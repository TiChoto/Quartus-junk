module nand_gate (  //Nand gate
    input a, b,
    output y
);
    assign y = ~(a & b);
endmodule

module nor_gate ( // Nor gate
    input a, b,
    output y
);
    assign y = ~(a | b);
endmodule

module xnor_gate ( // Xnor gate
    input a, b,
    output y
);
    assign y = ~(a ^ b);
endmodule