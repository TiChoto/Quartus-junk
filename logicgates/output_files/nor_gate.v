module nor_gate ( // Nor gate
    input a, b,
    output y
);
    assign y = ~(a | b);
endmodule