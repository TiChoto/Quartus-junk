module logicgatesfpga (
    input wire a, b,       //Mapped inputs for switches
    output wire y_nand,    //Mapped outputs for LEDs
    output wire y_nor,
    output wire y_xnor
);
    nand_gate nand_inst (.a(a), .b(b), .y(y_nand));
    nor_gate nor_inst (.a(a), .b(b), .y(y_nor));
    xnor_gate xnor_inst (.a(a), .b(b), .y(y_xnor));
endmodule