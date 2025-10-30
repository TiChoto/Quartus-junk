`timescale 1ns / 1ps
module ALU_TB;
    reg [31:0] SrcA;
    reg [31:0] SrcB;
    reg [3:0] af;
    reg i;
    wire [31:0] Alures;
    wire Zero, Neg, ovfalu;

    ALU inst (
        .SrcA(SrcA),
        .SrcB(SrcB),
        .af(af),
        .i(i),
        .Alures(Alures),
        .Zero(Zero),
        .Neg(Neg),
        .ovfalu(ovfalu)
    );

    initial begin
     	 SrcA = 32'd10; SrcB = 32'd5; af = 4'b0000; i = 0; #100;//add af 0000
        
       SrcA = 32'd20; SrcB = 32'd15; af = 4'b0001; i = 0; #100;//addu af 0001
        
       SrcA = 32'd25; SrcB = 32'd30; af = 4'b0010; i = 0; #100;//sub af 0010

       SrcA = 32'd30; SrcB = 32'd10; af = 4'b0011; i = 0; #100;//subu af 0011

       SrcA = 32'hFF00FF00; SrcB = 32'h0F0F0F0F; af = 4'b0100; i = 0; #100;//and af 0100

       SrcA = 32'hFF00FF00; SrcB = 32'h0F0F0F0F; af = 4'b0101; i = 0; #100;//or af 0101

       SrcA = 32'hFFFF0000; SrcB = 32'h0000FFFF; af = 4'b0110; i = 0; #100;//xor af 0110

       SrcA = 32'd0; SrcB = 32'h00001234; af = 4'b0111; i = 1; #100;//lui af=0111 i=1

       SrcA = -32'sd5; SrcB = 32'sd3; af = 4'b1010; i = 0; #100;//slt af  1010

       SrcA = 32'd2; SrcB = 32'd3; af = 4'b1011; i = 0; #100;//sltu af 1011

       SrcA = 32'h7FFFFFFF; SrcB = 32'd1; af = 4'b0000; i = 0; #100;//We can add so it overflows

      $stop;
   end

endmodule
