`timescale 1ns/1ps
module Shifter_tb;
    reg [1:0] funct;
    reg signed [31:0] a;
    reg [4:0] N;
    wire [31:0] R;
    Shifter uut (.funct(funct), .a(a), .N(N), .R(R));

    initial begin    
        //logical shift left
        a = 32'b00000000000000000000000000001010; N = 1; funct = 2'b00; #10;
       
        //logical shift right
        a = 32'b00000000000000000000000000001010; N = 1; funct = 2'b10; #10;


        //arithmetic shift right sign 1
        a = -5; N = 1; funct = 2'b11; #10;
  
        //arithmetic shift right sign 0
        a = 5; N = 1; funct = 2'b11; #10;

        //Shift by 0
        a = 32'hAABBCCDD; N = 0; funct = 2'b11; #10;
        
        //Shift by 31
        a = -1; N = 31; funct = 2'b11; #10;
        
        $stop;
    end
endmodule
