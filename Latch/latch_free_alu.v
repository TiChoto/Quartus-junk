module latch_free_alu #(
    parameter WIDTH = 32
)(
    input wire [WIDTH-1:0] operandA,
    input wire [WIDTH-1:0] operandB,
    input wire [3:0] ALU_control,
    output reg [WIDTH-1:0] result,
    output reg zero_flag,
    output reg overflow_flag,
    output reg carry_flag,
    output reg negative_flag
);

wire [WIDTH:0] temp_result; // Extra bit for carry detection
wire sign_A, sign_B, sign_result;

assign sign_A = operandA[WIDTH-1];
assign sign_B = operandB[WIDTH-1];
assign temp_result = operandA + operandB;// For ADD operation
assign sign_result = temp_result[WIDTH-1];

always @(*) begin
    result = {WIDTH{1'b0}};
    zero_flag = 1'b0;
    overflow_flag = 1'b0;
    carry_flag = 1'b0;
    negative_flag = 1'b0;
    
    case (ALU_control)
        4'b0000: begin // ADD
            result = operandA + operandB;
            carry_flag = temp_result[WIDTH];
            // Overflow occurs when: (+A) + (+B) = (-result) OR (-A) + (-B) = (+result)
            overflow_flag = (~sign_A & ~sign_B & sign_result) | (sign_A & sign_B & ~sign_result);
        end
        
        4'b0001: begin // SUB (A - B)
            result = operandA - operandB;
            // For subtraction: A - B = A + (~B + 1)
            carry_flag = operandA >= operandB; // No borrow if A >= B
            // Overflow: (+A) - (-B) = (-result) OR (-A) - (+B) = (+result)
            overflow_flag = (~sign_A & operandB[WIDTH-1] & result[WIDTH-1]) | 
                           (sign_A & ~operandB[WIDTH-1] & ~result[WIDTH-1]);
        end
        
        4'b0010: begin // AND
            result = operandA & operandB;
            // No carry or overflow for logical operations
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b0011: begin // OR
            result = operandA | operandB;
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b0100: begin // XOR
            result = operandA ^ operandB;
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b0101: begin // NOR
            result = ~(operandA | operandB);
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b0110: begin // SLT (Set Less Than) - signed comparison
            result = ($signed(operandA) < $signed(operandB)) ? {{(WIDTH-1){1'b0}}, 1'b1} : {WIDTH{1'b0}};
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b0111: begin // SLTU (Set Less Than Unsigned)
            result = (operandA < operandB) ? {{(WIDTH-1){1'b0}}, 1'b1} : {WIDTH{1'b0}};
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b1000: begin // Shift Left Logical
            result = operandA << operandB[4:0]; // Use only lower 5 bits for shift amount
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b1001: begin // Shift Right Logical
            result = operandA >> operandB[4:0];
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b1010: begin // Shift Right Arithmetic
            result = $signed(operandA) >>> operandB[4:0];
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b1011: begin // Pass A
            result = operandA;
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b1100: begin // Pass B
            result = operandB;
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b1101: begin // NOT A
            result = ~operandA;
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        4'b1110: begin // NOT B
            result = ~operandB;
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
        
        // IMPORTANT: DEFAULT case to prevent latches
        default: begin
            result = {WIDTH{1'b0}};
            carry_flag = 1'b0;
            overflow_flag = 1'b0;
        end
    endcase
    
    // Common flag calculations (done after all operations)
    zero_flag = (result == {WIDTH{1'b0}});
    negative_flag = result[WIDTH-1];
end

endmodule

// Latch-Free Branch Condition Evaluation Unit
module latch_free_bce (
    input wire [31:0] operandA,
    input wire [31:0] operandB,
    input wire [2:0] branch_type,
    output reg branch_taken
);

always @(*) begin
    // Initialize output to prevent latch
    branch_taken = 1'b0;
    
    case (branch_type)
        3'b000: branch_taken = (operandA == operandB);// BEQ
        3'b001: branch_taken = (operandA != operandB);// BNE
        3'b010: branch_taken = ($signed(operandA) < $signed(operandB)); // BLT
        3'b011: branch_taken = ($signed(operandA) >= $signed(operandB)); // BGE
        3'b100: branch_taken = (operandA < operandB); // BLTU
        3'b101: branch_taken = (operandA >= operandB);// BGEU
        3'b110: branch_taken = 1'b1; // Unconditional branch
        // DEFAULT case prevents latches
        default: branch_taken = 1'b0;
    endcase
end

endmodule

// Latch-Free Instruction Decoder Example
module latch_free_i_decoder (
    input wire [31:0] instruction,
    output reg [5:0] opcode,
    output reg [4:0] rs,
    output reg [4:0] rt,
    output reg [4:0] rd,
    output reg [4:0] shamt,
    output reg [5:0] funct,
    output reg [15:0] immediate,
    output reg [25:0] jump_address
);

always @(*) begin
    // Initialize ALL outputs to prevent latches
    opcode = 6'b000000;
    rs = 5'b00000;
    rt = 5'b00000;
    rd = 5'b00000;
    shamt = 5'b00000;
    funct = 6'b000000;
    immediate = 16'b0000000000000000;
    jump_address = 26'b00000000000000000000000000;
    
    // Decode instruction fields
    opcode = instruction[31:26];
    
    // Use if-else with COMPLETE coverage
    if (opcode == 6'b000000) begin // R-type
        rs = instruction[25:21];
        rt = instruction[20:16];
        rd = instruction[15:11];
        shamt = instruction[10:6];
        funct = instruction[5:0];
        // immediate and jump_address remain 0 (already initialized)
    end
    else if (opcode[5:3] == 3'b001) begin // I-type (opcodes 001xxx)
        rs = instruction[25:21];
        rt = instruction[20:16];
        immediate = instruction[15:0];
        // rd, shamt, funct, jump_address remain 0
    end
    else if (opcode[5:1] == 5'b00001) begin // J-type (opcodes 00001x)
        jump_address = instruction[25:0];
        // All other fields remain 0
    end
    else begin // DEFAULT case for any other opcode
        // All outputs already initialized to 0
        // This prevents latches for unknown opcodes
    end
end

endmodule