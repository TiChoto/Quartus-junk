`timescale 1ns/1ps
module rca_8bit_tb;
    reg [7:0] A;
    reg [7:0] B;
    reg Cin;
    wire [7:0] Sum;
    wire Cout;
    
    rca_8bit inst (
        .A(A),
        .B(B),
        .Cin(Cin),
        .Sum(Sum),
        .Cout(Cout)
    );
    
    reg [8:0] test_vectors[0:11];
    integer i;
    reg [7:0] expected_sum;
    reg expected_cout;
    
    initial begin       
        //test vectors - Cin B A
        test_vectors[0]  = {1'b0, 8'h00, 8'h00};  //zeros
        test_vectors[1]  = {1'b0, 8'hFF, 8'hFF};  //ones no carry
        test_vectors[2]  = {1'b1, 8'hFF, 8'hFF};  //ones carry
        test_vectors[3]  = {1'b0, 8'h01, 8'hFF};  //overflow
        test_vectors[4]  = {1'b0, 8'h55, 8'hAA};  //random 
        test_vectors[5]  = {1'b0, 8'hC3, 8'h3C};  //random 
        test_vectors[6]  = {1'b1, 8'h01, 8'h01};  //single bit carry
        test_vectors[7]  = {1'b0, 8'h80, 8'h80};  //carry propagation
        test_vectors[8]  = {1'b1, 8'hAA, 8'h55};  //alternate pattern
        test_vectors[9]  = {1'b1, 8'hFF, 8'h00};  //boundary values
        test_vectors[10] = {1'b1, 8'h7F, 8'h7F};  //middle value
        test_vectors[11] = {1'b0, 8'h04, 8'h04};  //power of two
        
        for (i = 0; i < 12; i = i + 1) begin
            {Cin, B, A} = test_vectors[i];
            
            // expected results
            {expected_cout, expected_sum} = A + B + Cin;
            
            #20; //propagation
            $display("Test %0d: A=%h B=%h Cin=%b => Sum=%h (expected %h) Cout=%b (expected %b) %s",
                    i, A, B, Cin, 
                    Sum, expected_sum,
                    Cout, expected_cout,
                    ((Sum === expected_sum) && (Cout === expected_cout)) ? "PASS" : "FAIL");
            
            //verify results
            if ((Sum !== expected_sum) || (Cout !== expected_cout)) begin
                $display("ERROR: Mismatch detected!");
                $stop;
            end
        end
        
        $display("All tests completed successfully");
        $finish;
    end
endmodule