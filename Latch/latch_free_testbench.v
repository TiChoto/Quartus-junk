`timescale 1ns / 1ps
module latch_free_testbench;
parameter WIDTH = 32;
reg [WIDTH-1:0] alu_A, alu_B;
reg [3:0] alu_ctrl;
wire [WIDTH-1:0] alu_result;
wire alu_zero, alu_overflow, alu_carry, alu_negative;
reg [31:0] bce_A, bce_B;
reg [2:0] bce_type;
wire bce_taken;
reg [31:0] instruction;
wire [5:0] opcode;
wire [4:0] rs, rt, rd, shamt;
wire [5:0] funct;
wire [15:0] immediate;
wire [25:0] jump_address;
latch_free_alu #(.WIDTH(WIDTH)) alu_uut (
    .operandA(alu_A),
    .operandB(alu_B),
    .ALU_control(alu_ctrl),
    .result(alu_result),
    .zero_flag(alu_zero),
    .overflow_flag(alu_overflow),
    .carry_flag(alu_carry),
    .negative_flag(alu_negative)
);

latch_free_bce bce_uut (
    .operandA(bce_A),
    .operandB(bce_B),
    .branch_type(bce_type),
    .branch_taken(bce_taken)
);

latch_free_i_decoder decoder_uut (
    .instruction(instruction),
    .opcode(opcode),
    .rs(rs),
    .rt(rt),
    .rd(rd),
    .shamt(shamt),
    .funct(funct),
    .immediate(immediate),
    .jump_address(jump_address)
);

// Test procedure
initial begin
    $display("=== Latch-Free Modules Testbench ===");
    
    // Test ALU
    $display("\n--- ALU Tests ---");
    test_alu();
    
    // Test BCE
    $display("\n--- Branch Condition Evaluation Tests ---");
    test_bce();
    
    // Test Decoder
    $display("\n--- Instruction Decoder Tests ---");
    test_decoder();
    
    $display("\n=== All Tests Complete ===");
    $finish;
end

// ALU Test Task
task test_alu;
begin
    $display("Testing ALU operations...");
    
    // Test ADD operation
    #10;
    alu_A = 32'd15;
    alu_B = 32'd25;
    alu_ctrl = 4'b0000; // ADD
    #10;
    $display("ADD: %d + %d = %d (Expected: 40) %s", 
             alu_A, alu_B, alu_result, (alu_result == 32'd40) ? "PASS" : "FAIL");
    
    // Test SUB operation
    #10;
    alu_A = 32'd50;
    alu_B = 32'd30;
    alu_ctrl = 4'b0001; // SUB
    #10;
    $display("SUB: %d - %d = %d (Expected: 20) %s", 
             alu_A, alu_B, alu_result, (alu_result == 32'd20) ? "PASS" : "FAIL");
    
    // Test AND operation
    #10;
    alu_A = 32'hF0F0F0F0;
    alu_B = 32'h0F0F0F0F;
    alu_ctrl = 4'b0010; // AND
    #10;
    $display("AND: %h & %h = %h (Expected: 00000000) %s", 
             alu_A, alu_B, alu_result, (alu_result == 32'h00000000) ? "PASS" : "FAIL");
    
    // Test OR operation
    #10;
    alu_A = 32'hF0F0F0F0;
    alu_B = 32'h0F0F0F0F;
    alu_ctrl = 4'b0011; // OR
    #10;
    $display("OR: %h | %h = %h (Expected: FFFFFFFF) %s", 
             alu_A, alu_B, alu_result, (alu_result == 32'hFFFFFFFF) ? "PASS" : "FAIL");
    
    // Test Zero flag
    #10;
    alu_A = 32'd0;
    alu_B = 32'd0;
    alu_ctrl = 4'b0000; // ADD
    #10;
    $display("Zero Flag Test: %d + %d = %d, Zero = %b %s", 
             alu_A, alu_B, alu_result, alu_zero, (alu_zero == 1'b1) ? "PASS" : "FAIL");
    
    // Test SLT (Set Less Than)
    #10;
    alu_A = 32'd10;
    alu_B = 32'd20;
    alu_ctrl = 4'b0110; // SLT
    #10;
    $display("SLT: %d < %d = %d (Expected: 1) %s", 
             alu_A, alu_B, alu_result, (alu_result == 32'd1) ? "PASS" : "FAIL");
    
    // Test with undefined control (should not create latch)
    #10;
    alu_ctrl = 4'b1111; // Undefined operation
    #10;
    $display("Undefined operation test: Result = %h %s", 
             alu_result, (alu_result == 32'h00000000) ? "PASS (Default case)" : "FAIL");
end
endtask

// BCE Test Task
task test_bce;
begin
    $display("Testing Branch Condition Evaluation...");
    
    // Test BEQ (Branch if Equal)
    #10;
    bce_A = 32'd100;
    bce_B = 32'd100;
    bce_type = 3'b000; // BEQ
    #10;
    $display("BEQ: %d == %d = %b (Expected: 1) %s", 
             bce_A, bce_B, bce_taken, (bce_taken == 1'b1) ? "PASS" : "FAIL");
    
    // Test BNE (Branch if Not Equal)
    #10;
    bce_A = 32'd100;
    bce_B = 32'd200;
    bce_type = 3'b001; // BNE
    #10;
    $display("BNE: %d != %d = %b (Expected: 1) %s", 
             bce_A, bce_B, bce_taken, (bce_taken == 1'b1) ? "PASS" : "FAIL");
    
    // Test BLT (Branch if Less Than)
    #10;
    bce_A = 32'd50;
    bce_B = 32'd100;
    bce_type = 3'b010; // BLT
    #10;
    $display("BLT: %d < %d = %b (Expected: 1) %s", 
             bce_A, bce_B, bce_taken, (bce_taken == 1'b1) ? "PASS" : "FAIL");
    
    // Test BGE (Branch if Greater or Equal)
    #10;
    bce_A = 32'd100;
    bce_B = 32'd50;
    bce_type = 3'b011; // BGE
    #10;
    $display("BGE: %d >= %d = %b (Expected: 1) %s", 
             bce_A, bce_B, bce_taken, (bce_taken == 1'b1) ? "PASS" : "FAIL");
    
    // Test undefined branch type (should not create latch)
    #10;
    bce_type = 3'b111; // Undefined branch type
    #10;
    $display("Undefined branch type test: Result = %b %s", 
             bce_taken, (bce_taken == 1'b0) ? "PASS (Default case)" : "FAIL");
end
endtask

// Decoder Test Task
task test_decoder;
begin
    $display("Testing Instruction Decoder...");
    
    // Test R-type instruction (ADD $1, $2, $3)
    // Format: [6-bit opcode][5-bit rs][5-bit rt][5-bit rd][5-bit shamt][6-bit funct]
    #10;
    instruction = 32'b000000_00010_00011_00001_00000_100000; // opcode=0, rs=2, rt=3, rd=1, shamt=0, funct=32 (ADD)
    #10;
    $display("R-type: opcode=%b, rs=%d, rt=%d, rd=%d, shamt=%d, funct=%b %s", 
             opcode, rs, rt, rd, shamt, funct,
             (opcode == 6'b000000 && rs == 5'd2 && rt == 5'd3 && rd == 5'd1 && funct == 6'b100000) ? "PASS" : "FAIL");
    
    // Test I-type instruction (ADDI $1, $2, 1999)
    // Format: [6-bit opcode][5-bit rs][5-bit rt][16-bit immediate]
    #10;
    instruction = 32'b001000_00010_00001_0000011111001111; // opcode=8 (ADDI), rs=2, rt=1, imm=1999
    #10;
    $display("I-type: opcode=%b, rs=%d, rt=%d, immediate=%d %s", 
             opcode, rs, rt, immediate,
             (opcode == 6'b001000 && rs == 5'd2 && rt == 5'd1 && immediate == 16'd1999) ? "PASS" : "FAIL");
    
    // Test J-type instruction (J 0x100000)
    // Format: [6-bit opcode][26-bit jump_address]
    #10;
    instruction = 32'b000010_00000001000000000000000000; // opcode=2 (J), address=0x100000
    #10;
    $display("J-type: opcode=%b, jump_address=%h %s", 
             opcode, jump_address,
             (opcode == 6'b000010 && jump_address == 26'h100000) ? "PASS" : "FAIL");
    
    // Test unknown instruction type (should use default case)
    #10;
    instruction = 32'b111111_11111_11111_1111111111111111; // All 1s - undefined
    #10;
    $display("Unknown instruction: All fields should be 0 except opcode %s", 
             (rs == 5'd0 && rt == 5'd0 && rd == 5'd0 && immediate == 16'd0) ? "PASS (Default case)" : "FAIL");
end
endtask

// Generate waveform dump
initial begin
    $dumpfile("latch_free_modules.vcd");
    $dumpvars(0, latch_free_testbench);
end

endmodule