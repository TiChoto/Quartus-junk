`timescale 1ns/1ps
module instructionflow_tb;
    reg clk = 0;
    always #5 clk = ~clk; 

    //Register file
    reg we;
    reg [2:0] ra1, ra2, wa;
    reg [7:0] wd;
    wire [7:0] rd1, rd2;

    //ALU
    reg [2:0] opcode;
    wire [3:0] result;
    wire zero;

    //Control unit
    reg [5:0] instr_opcode;
    wire [1:0] ALUop;
    wire RegDst, Br, ALUsrc, ZeroCheck;

   
    eregisterfile RF (
        .clk(clk), .we(we),
        .ra1(ra1), .ra2(ra2), .wa(wa), .wd(wd),
        .rd1(rd1), .rd2(rd2)
    );

    alubranch ALU (
        .A(rd1[3:0]), .B(rd2[3:0]), .opcode(opcode),
        .result(result), .zero(zero)
    );

    controlunit CU (
        .opcode(instr_opcode),
        .ALUop(ALUop), .RegDst(RegDst), .Br(Br),
        .ALUsrc(ALUsrc), .ZeroCheck(ZeroCheck)
    );

    initial begin     
        we = 1;
        #10;
        wa = 3'b010; wd = 8'd5; #10; // $t2
        wa = 3'b011; wd = 8'd2; #10; // $t3
        we = 0;

        //t1 = t2 - t3
        instr_opcode = 6'b000000; // R-type
        ra1 = 3'b010; ra2 = 3'b011; //$t2, $t3
        opcode = 3'b001; //SUB in ALU
        #20;

        //compare t1 and t2
        instr_opcode = 6'b000100; //beq
        opcode = 3'b101; //compare equality
        ra1 = 3'b001; 
        ra2 = 3'b010; 
        #20;
        $stop;
    end
endmodule
