module gpr (
    input clk,
    input Sw,
    input [31:0] Sin,
    input [4:0] Sa, Sb, Sc,
    output reg [31:0] Souta,
    output reg [31:0] Soutb
);
    reg [31:0] regfile [31:0];
    wire [31:0] decSa;
    wire [31:0] decSb;
    wire [31:0] decSc;
    integer i;

    //5 to 32
    assign decSa = (1 << Sa);
    assign decSb = (1 << Sb);
    assign decSc = (1 << Sc);

    always @(posedge clk) begin
        for (i = 1; i < 32; i = i + 1) begin //start from 1 to skip reg0
            if (Sw && decSc[i])
                regfile[i] <= Sin;
        end

        //reg0 to 0
        regfile[0] <= 32'b0;
    end
	 
    always @(*) begin
        Souta = 32'b0;
        Soutb = 32'b0;
        for (i = 0; i < 32; i = i + 1) begin
            if (decSa[i])
                Souta = Souta | regfile[i]; if (decSb[i])
                                                  Soutb = Soutb | regfile[i]; 
        end
    end
endmodule
