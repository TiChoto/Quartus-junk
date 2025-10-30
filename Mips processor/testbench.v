`timescale 1ns / 1ps

module testbench;

    reg clk;
    reg reset;
    reg [9:0] SW;
    reg [3:0] KEY;
    wire [9:0] LEDR;
    wire [31:0] aluresout;
    wire [31:0] shift_resultout;
    wire [31:0] GP_DATA_INout;
    wire [31:0] pc_output;

    // Instantiate your updated top_mips
    top_mips uut (
        .clk(clk),
        .reset(reset),
        .SW(SW),
        .KEY(KEY),
        .LEDR(LEDR),
        .aluresout(aluresout),
        .shift_resultout(shift_resultout),
        .GP_DATA_INout(GP_DATA_INout),
        .pc_output(pc_output)
    );

    // Clock generation
    always #5 clk = ~clk;  // 100 MHz clock

    initial begin
        $display("==== MIPS Processor Simulation Start ====");
        $dumpfile("waveform.vcd");   // For GTKWave
        $dumpvars(0, testbench);

        clk = 0;
        reset = 1;
        SW = 10'b0000000000;
        KEY = 4'b1111; // All keys unpressed (active low)

        // Release reset
        #20 reset = 0;

        // Simulate loading value into reg1:
        SW = 10'b0000000101; // Load binary 5 via switches

        // Simulate KEY[1] press (active low) to load reg1
        #20 KEY[1] = 0; // Press KEY[1]
        #20 KEY[1] = 1; // Release KEY[1]

        // Step 1: Press KEY[0] to execute first MIPS instruction
        #50 KEY[0] = 0; // Press KEY[0]
        #20 KEY[0] = 1; // Release KEY[0]

        // Step 2: Press KEY[0] to execute second MIPS instruction
        #100 KEY[0] = 0; // Press KEY[0]
        #20 KEY[0] = 1; // Release KEY[0]

        // Display reg1 on LEDs
        #50 KEY[1] = 0;
        #20 KEY[1] = 1;

        // Display reg2 on LEDs
        #50 KEY[2] = 0;
        #20 KEY[2] = 1;

        // Display reg3 on LEDs
        #50 KEY[3] = 0;
        #20 KEY[3] = 1;

        // Let signals stabilize
        #200;

        $display("==== Simulation Finished ====");
        $finish;
    end

endmodule
