module top_mips (
    input clk,
    input reset,
    input [9:0] SW,
    input [3:0] KEY,
    output reg [9:0] LEDR,
    output [31:0] aluresout,
    output [31:0] shift_resultout,
    output [31:0] GP_DATA_INout,
    output [31:0] pc_output
);

    reg [31:0] pc_reg;
    wire [31:0] pc_plus4 = pc_reg + 4;
    reg prev_key0;
    reg [31:0] pc_next;

    wire [31:0] inst;

    MEMORY instr_mem (
        .clk(clk),
        .MemWrite(0),
        .MemRead(1),
        .Address(pc_reg),
        .WriteData(0),
        .ReadData(inst)
    );

    wire [4:0] RS = inst[25:21];
    wire [4:0] RT = inst[20:16];
    wire [4:0] RD = inst[15:11];
    wire [15:0] IMM = inst[15:0];
    wire [25:0] JINDEX = inst[25:0];

    wire GP_WE, ALU_SRC, U, MemRead, MemWrite;
    wire [3:0] ALU_OP, GP_MUX_SEL, PC_MUX_SEL;
    wire [1:0] SHIFT_OP;
    wire [3:0] BCE_OP;

    InstructionDecoder decoder (
        .inst(inst),
        .GP_WE(GP_WE),
        .ALU_SRC(ALU_SRC),
        .U(U),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .ALU_OP(ALU_OP),
        .GP_MUX_SEL(GP_MUX_SEL),
        .PC_MUX_SEL(PC_MUX_SEL),
        .SHIFT_OP(SHIFT_OP),
        .BCE_OP(BCE_OP)
    );

    wire [31:0] GP_OUT_A, GP_OUT_B;
    reg [4:0] CAD_reg;
    reg [31:0] GP_DATA_IN_reg;
    reg GP_WE_reg;

    reg reg1_loaded;
    reg prev_key1;
    reg manual_load_en;
    reg [31:0] manual_load_data;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            prev_key1 <= 1'b1;
            manual_load_en <= 1'b0;
            reg1_loaded <= 1'b0;
            manual_load_data <= 32'b0;
        end else begin
            prev_key1 <= KEY[1];
            if (prev_key1 && ~KEY[1]) begin
                if (!reg1_loaded) begin
                    manual_load_en <= 1'b1;
                    manual_load_data <= {22'b0, SW};
                    reg1_loaded <= 1'b1;
                end else begin
                    manual_load_en <= 1'b0;
                end
            end else begin
                manual_load_en <= 1'b0;
            end
        end
    end

    wire effective_GP_WE = GP_WE | manual_load_en;
    wire [4:0] write_reg = manual_load_en ? 5'd1 : CAD_reg;
    wire [31:0] data_to_write = manual_load_en ? manual_load_data : GP_DATA_IN_reg;

    gpr regfile (
        .clk(clk),
        .Sw(effective_GP_WE),
        .Sin(data_to_write),
        .Sa(RS),
        .Sb(RT),
        .Sc(write_reg),
        .Souta(GP_OUT_A),
        .Soutb(GP_OUT_B)
    );

    wire [31:0] IMM_EXT;
    IE #(16, 32) imm_extender (
        .in(IMM),
        .U(U),
        .out(IMM_EXT)
    );

    wire [31:0] ALU_SRCB = ALU_SRC ? IMM_EXT : GP_OUT_B;

    wire Zero, Neg, Ovf;
    wire [31:0] alu_result;

    ALU alu_core (
        .SrcA(GP_OUT_A),
        .SrcB(GP_OUT_B),
        .Imm(IMM),
        .af(ALU_OP),
        .i(ALU_SRC),
        .U(U),
        .Alures(alu_result),
        .Zero(Zero),
        .Neg(Neg),
        .ovfalu(Ovf)
    );

    wire [31:0] shift_result;
    Shifter shifter_unit (
        .funct(SHIFT_OP),
        .a(GP_OUT_B),
        .N(GP_OUT_A[4:0]),
        .R(shift_result)
    );

    wire [31:0] mem_data_out;
    MEMORY data_mem (
        .clk(clk),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .Address(alu_result),
        .WriteData(GP_OUT_B),
        .ReadData(mem_data_out)
    );

    reg [31:0] GP_DATA_IN;
    always @(*) begin
        case (GP_MUX_SEL)
            4'b0000: GP_DATA_IN = alu_result;
            4'b0001: GP_DATA_IN = mem_data_out;
            4'b0010: GP_DATA_IN = shift_result;
            4'b0011: GP_DATA_IN = pc_plus4;
            default: GP_DATA_IN = 32'b0;
        endcase
    end

    wire [31:0] branch_target = pc_plus4 + (IMM_EXT << 2);
    wire [31:0] jump_target = {pc_plus4[31:28], JINDEX, 2'b00};
    wire [31:0] jr_target = GP_OUT_A;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            GP_DATA_IN_reg <= 0;
            CAD_reg <= 0;
            GP_WE_reg <= 0;
            pc_reg <= 0;
            prev_key0 <= 1'b1;
        end else begin
            GP_DATA_IN_reg <= GP_DATA_IN;
            CAD_reg <= write_reg;
            GP_WE_reg <= effective_GP_WE;

            prev_key0 <= KEY[0];
            if (prev_key0 && ~KEY[0]) begin
                case (PC_MUX_SEL)
                    4'b0000: pc_next = pc_plus4;
                    4'b0001: pc_next = branch_target;
                    4'b0010: pc_next = jump_target;
                    4'b0011: pc_next = jr_target;
                    default: pc_next = pc_plus4;
                endcase
                pc_reg <= pc_next;
            end
        end
    end

    assign aluresout = alu_result;
    assign shift_resultout = shift_result;
    assign pc_output = pc_reg;
    assign GP_DATA_INout = GP_DATA_IN_reg;

    reg [1:0] reg_display_sel;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            reg_display_sel <= 2'b11;
        end else begin
            if (~KEY[1]) reg_display_sel <= 2'b00;
            else if (~KEY[2]) reg_display_sel <= 2'b01;
            else if (~KEY[3]) reg_display_sel <= 2'b10;
            else reg_display_sel <= 2'b11;
        end
    end

    wire [31:0] reg1_val, reg2_val, reg3_val;

    gpr regfile_read12 (
        .clk(clk),
        .Sw(1'b0),
        .Sin(32'b0),
        .Sa(5'd1),
        .Sb(5'd2),
        .Sc(5'd0),
        .Souta(reg1_val),
        .Soutb(reg2_val)
    );

    wire [31:0] reg3_wire;
    gpr regfile_read3 (
        .clk(clk),
        .Sw(1'b0),
        .Sin(32'b0),
        .Sa(5'd3),
        .Sb(5'd0),
        .Sc(5'd0),
        .Souta(reg3_wire),
        .Soutb()
    );

    reg [31:0] reg_to_display;

    always @(*) begin
        case (reg_display_sel)
            2'b00: reg_to_display = reg1_val;
            2'b01: reg_to_display = reg2_val;
            2'b10: reg_to_display = reg3_wire;
            default: reg_to_display = 32'b0;
        endcase
    end

    always @(posedge clk or posedge reset) begin
        if (reset) LEDR <= 10'b0;
        else LEDR <= reg_to_display[9:0];
    end

endmodule
