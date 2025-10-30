module eregisterfile (
    input clk,
    input we,                    
    input [2:0] ra1, ra2, wa, 
    input [7:0] wd,              
    output reg [7:0] rd1, rd2    
);
    reg [7:0] registers [0:7];

    always @(posedge clk) begin
        if (we) begin
            registers[wa] <= wd;
        end
    end

    always @(*) begin
        rd1 = registers[ra1];
        rd2 = registers[ra2];
    end
endmodule
