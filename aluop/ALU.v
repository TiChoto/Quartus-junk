module ALU (
    input [31:0] SrcA,
    input [31:0] SrcB,         
    input [15:0] Imm,          //I type 
    input [3:0] af,            //selector
    input i,                   //1-I 0-R
    input U,                   //1 = zero extend, 0 = sign extend
    output reg [31:0] Alures,
    output reg Zero,
    output reg Neg,
    output reg ovfalu
);

    wire [31:0] ExtImm;
    wire [31:0] B = i ? ExtImm : SrcB;
    wire signed [31:0] A = SrcA;
    wire signed [31:0] SB = B;

    IE #(16, 32) extender (
        .in(Imm),
        .U(U),
        .out(ExtImm)
    );

    always @(*) begin
        ovfalu = 0;
        case (af)
            4'b0000: begin
                Alures = A + SB;
                if ((A[31] == SB[31]) && (Alures[31] != A[31]))
                    ovfalu = 1;
            end
            4'b0001: Alures = A + SB;
            4'b0010: begin
                Alures = A - SB;
                if ((A[31] != SB[31]) && (Alures[31] != A[31]))
                    ovfalu = 1;
            end
            4'b0011: Alures = A - SB;
            4'b0100: Alures = A & SB;
            4'b0101: Alures = A | SB;
            4'b0110: Alures = A ^ SB;
            4'b0111: Alures = {SB[15:0], 16'b0};
            4'b1010: Alures = (A < SB) ? 32'b1 : 32'b0;
            4'b1011: Alures = ($unsigned(SrcA) < $unsigned(SB)) ? 32'b1 : 32'b0;
            default: Alures = 32'b0;
        endcase

        Zero = (Alures == 32'b0);
        Neg = Alures[31];
    end
endmodule
