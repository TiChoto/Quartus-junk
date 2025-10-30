`timescale 1ns / 1ps
module tb_instruction_decoder;
    reg [31:0] instruction;
    wire [3:0] alu_op;
    wire reg_write;
    wire mem_read;
    wire mem_write;
    wire branch;

   
    instruction_decoder inst (
        .instruction(instruction),
        .alu_op(alu_op),
        .reg_write(reg_write),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .branch(branch)
    );

    initial begin
        $display("=== Starting Testbench ===");
        $monitor("Time=%0t | Instr=%h | ALU_OP=%b | RegWrite=%b | MemRead=%b | MemWrite=%b | Branch=%b",
                 $time, instruction, alu_op, reg_write, mem_read, mem_write, branch);

        //R-type: ADD (opcode 0110011)
        instruction = 32'b0000000_00010_00001_000_00011_0110011; // ADD x3, x1, x2
        #10;

        //I-type: LW (opcode 0000011)
        instruction = 32'b000000000100_00001_010_00011_0000011; // LW x3, 4(x1)
        #10;

        //S-type: SW (opcode 0100011)
        instruction = 32'b0000000_00011_00001_010_00100_0100011; // SW x3, 4(x1)
        #10;

        //B-type: BEQ (opcode 1100011)
        instruction = 32'b0000000_00001_00010_000_00000_1100011; // BEQ x1, x2, offset
        #10;

        //U-type: LUI (opcode 0110111)
        instruction = 32'b00000000000000000001_00011_0110111; // LUI x3, 0x1000
        #10;

        //J-type: JAL (opcode 1101111)
        instruction = 32'b00000000000100000000_00011_1101111; // JAL x3, offset
        #10;

        //Invalid opcode
        instruction = 32'b00000000000000000000_00000_1111111; // Invalid opcode
        #10;

        $finish;
    end

endmodule
