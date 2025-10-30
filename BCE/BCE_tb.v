`timescale 1ns/1ps
module BCE_tb;
    reg signed [31:0] a, b;
    reg [3:0] bf;
    wire bcres;

    BCE uut (.a(a), .b(b), .bf(bf), .bcres(bcres));

    initial begin      
        a = -1; b = 0; bf = 4'b0000; #10;
        a = 0; bf = 4'b0001; #10;
        a = 42; b = 42; bf = 4'b0010; #10;
        a = 10; b = 5; bf = 4'b0011; #10;
        a = -4; bf = 4'b0100; #10;
        a = 7; bf = 4'b0101; #10;
        $stop;
    end
endmodule
