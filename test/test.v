`timescale 1ns/1ps
module test;
    // Testbench signals
    reg  a, b;  // Inputs
    wire y_and, y_or, y_xor;  // Outputs

    // Instantiate the gates
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

    // Test procedure
    initial begin
    $dumpfile("test.vcd");
    $dumpvars(0, test);
    
    $display("Starting simulation...");
    
    a = 0; b = 0; #10;
    $display("a=0, b=0, y_and=%b, y_or=%b, y_xor=%b", y_and, y_or, y_xor);

    a = 0; b = 1; #10;
    $display("a=0, b=1, y_and=%b, y_or=%b, y_xor=%b", y_and, y_or, y_xor);

    a = 1; b = 0; #10;
    $display("a=1, b=0, y_and=%b, y_or=%b, y_xor=%b", y_and, y_or, y_xor);

    a = 1; b = 1; #10;
    $display("a=1, b=1, y_and=%b, y_or=%b, y_xor=%b", y_and, y_or, y_xor);

    $display("Simulation complete.");
    $finish;
end



endmodule