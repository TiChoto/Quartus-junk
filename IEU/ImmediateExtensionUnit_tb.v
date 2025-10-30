`timescale 1ns / 1ps
module ImmediateExtensionUnit_tb;
    localparam N = 16;
    localparam M = 32;
    reg U;
    reg [N-1:0] immediateIN;
    wire [M-1:0] immediateOUT;
    ImmediateExtensionUnit #(.N(N), .M(M)) inst (
        .U(U),
        .immediateIN(immediateIN),
        .immediateOUT(immediateOUT)
    );
    
    initial begin
        U = 0;
        immediateIN = 0;
        
        //sign extension
        $display("Testing sign extension:");
        U = 0;
        
        //Positive number MSB 0
        immediateIN = 16'h7FFF; // 0111 1111 1111 1111
        #10;
        $display("Input: %h, Output: %h (Expected: 00007FFF)", immediateIN, immediateOUT);
        
        //Negative number MSB 1
        immediateIN = 16'h8000; // 1000 0000 0000 0000
        #10;
        $display("Input: %h, Output: %h (Expected: FFFF8000)", immediateIN, immediateOUT);
        
        //zero extension U 1
        $display("\nTesting zero extension:");
        U = 1;
        
        //Positive number
        immediateIN = 16'h7FFF;
        #10;
        $display("Input: %h, Output: %h (Expected: 00007FFF)", immediateIN, immediateOUT);
        
        //Negative number zero-extended
        immediateIN = 16'h8000;
        #10;
        $display("Input: %h, Output: %h (Expected: 00008000)", immediateIN, immediateOUT);
        
        //different sizes
        $display("\nTesting parameterized extension (12 to 26 bits):");
        U = 0;
        immediateIN = 12'h800; // 1000 0000 0000
        #10;
        $display("Sign extended: %h (Expected: 3FF800)", immediateOUT[25:0]);
        
        U = 1;
        #10;
        $display("Zero extended: %h (Expected: 000800)", immediateOUT[25:0]);
        
        $finish;
    end

endmodule