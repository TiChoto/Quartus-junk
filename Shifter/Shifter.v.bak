module Shifter (
    input [1:0] funct,  // 00 = sll, 10 = srl, 11 = sra
    input signed [31:0] a,
    input [4:0] N,
    output reg [31:0] R
);
    wire [31:0] logical_sr = a >> N;
    wire [31:0] logical_sl = a << N;
    reg [31:0] Sntd;

    always @(*) begin
        case (funct)
            2'b00: R = logical_sl;// shift left logical
            2'b10: R = logical_sr;// shift right logical
            2'b11: begin   // shift right arithmetic (manual)
                if (a[31] == 1'b1)
                    Sntd = ~32'b0; // all 1s
                else
                    Sntd = 32'b0; // all 0s

                Sntd = Sntd << (32 - N);
                R = (a >> N) | Sntd;
            end
            default: R = 32'b0;
        endcase
    end
endmodule
