`timescale 1ns / 1ps
module InstructionDecoder (
    input [31:0] inst,
    output reg GP_WE,
    output reg ALU_SRC,
    output reg U,
    output reg MemRead,
    output reg MemWrite,
    output reg [3:0] ALU_OP,
    output reg [3:0] GP_MUX_SEL,
    output reg [3:0] PC_MUX_SEL,
    output reg [1:0] SHIFT_OP,
    output reg [3:0] BCE_OP
);

    wire [5:0] opcode = inst[31:26];
    wire [5:0] funct  = inst[5:0];

    always @(*) begin
        GP_WE = 0;
        ALU_SRC = 0;
        U = 0;
        MemRead = 0;
        MemWrite = 0;
        ALU_OP = 4'b0000;
        GP_MUX_SEL = 4'b0000;
        PC_MUX_SEL = 4'b0000;
        SHIFT_OP = 2'b00;
        BCE_OP = 4'b0000;

        case (opcode)
            6'b000000: begin // R-type
                GP_WE = 1;
                case (funct)
                    6'b100000: ALU_OP = 4'b0000; // ADD
                    6'b100010: ALU_OP = 4'b0010; // SUB
                    6'b100100: ALU_OP = 4'b0100; // AND
                    6'b100101: ALU_OP = 4'b0101; // OR
                    6'b101010: ALU_OP = 4'b1010; // SLT
                    6'b000000: begin ALU_OP = 4'b0000; SHIFT_OP = 2'b00; GP_MUX_SEL = 4'b0010; end // SLL
                    6'b000010: begin ALU_OP = 4'b0000; SHIFT_OP = 2'b10; GP_MUX_SEL = 4'b0010; end // SRL
                    6'b001000: PC_MUX_SEL = 4'b0011; // JR
                    default: ALU_OP = 4'b0000;
                endcase
                GP_MUX_SEL = 4'b0000; // ALU result
            end
            6'b100011: begin // LW
                GP_WE = 1;
                MemRead = 1;
                ALU_SRC = 1;
                ALU_OP = 4'b0000;
                GP_MUX_SEL = 4'b0001;
            end
            6'b101011: begin // SW
                MemWrite = 1;
                ALU_SRC = 1;
                ALU_OP = 4'b0000;
            end
            6'b001000: begin // ADDI
                GP_WE = 1;
                ALU_SRC = 1;
                ALU_OP = 4'b0000;
                GP_MUX_SEL = 4'b0000;
            end
            6'b000010: begin // J
                PC_MUX_SEL = 4'b0010;
            end
            6'b000011: begin // JAL
                PC_MUX_SEL = 4'b0010;
                GP_WE = 1;
                GP_MUX_SEL = 4'b0011; // PC+4
            end
            default: begin
                GP_WE = 0;
            end
        endcase
    end
endmodule
