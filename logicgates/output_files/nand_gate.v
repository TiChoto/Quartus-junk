module nand_gate (  //Nand gate
    input a, b,
    output y
);
    assign y = ~(a & b);
endmodule