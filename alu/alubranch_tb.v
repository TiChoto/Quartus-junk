`timescale 1ns/1ps
module alubranch_tb;
    reg [3:0] A, B;
    reg [2:0] opcode;
    wire [3:0] result;
    wire zero;

    alubranch inst (
        .A(A), 
		  .B(B), 
		  .opcode(opcode), 
		  .result(result),
		  .zero(zero)
    );

    initial begin 
        A = 4'd3; B = 4'd4; opcode = 3'b000; #20;

        A = 4'd5; B = 4'd2; opcode = 3'b001; #20; 

        A = 4'd5; B = 4'd5; opcode = 3'b001; #20;

        A = 4'd9; B = 4'd9; opcode = 3'b101; #20;
		  
        A = 4'd3; B = 4'd4; opcode = 3'b110; #20;

        A = 4'd2; B = 4'd2; opcode = 3'b110; #20;

        #20;
        $stop;
    end

endmodule
