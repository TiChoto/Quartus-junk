module test_fpga(
    input wire a,  
    input wire b,  
    output wire y_and,
    output wire y_or,
    output wire y_xor
);

    // Instantiate logic gates
    and_gate and_inst (
        .a(a),
        .b(b),
        .y(y_and)
    );

    or_gate or_inst (
        .a(a),
        .b(b),
        .y(y_or)
    );

    xor_gate xor_inst (
        .a(a),
        .b(b),
        .y(y_xor)
    );

endmodule
