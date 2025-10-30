module gpr (
    input clk,
    input Sw,
    input [31:0] Sin,
    input [4:0] Sa, Sb, Sc,
    output reg [31:0] Souta,
    output reg [31:0] Soutb
);
    reg [31:0] regfile [31:0];
    integer i;

    // Write on rising clock edge if write enabled and not writing to zero reg
    always @(posedge clk) begin
        if (Sw && (Sc != 0))
            regfile[Sc] <= Sin;
        regfile[0] <= 32'b0;  // reg0 always zero
    end

    // Read registers asynchronously
    always @(*) begin
        Souta = regfile[Sa];
        Soutb = regfile[Sb];
    end
endmodule
