module spr_ram(
    input clk,                   
    input Sw,                   
    input [4:0] Sa,              
    input [31:0] Sce,            
    input [1023:0] Sdin_flat,    //I can't create multiple arrays so I had to do this
    input [31:0] Sin,            
    output reg [31:0] Sout       
);

reg [31:0] registers [0:31];

integer i;
always @(posedge clk) begin
    if (Sw) begin
        for (i = 0; i < 32; i = i + 1) begin
            if (Sce[i]) begin
                //Extract 32-bit chunk from Sdin_flat
                registers[i] <= Sdin_flat[i*32 +: 32];
            end else begin
                registers[i] <= Sin;
            end
        end
    end
end

always @(*) begin
    Sout = registers[Sa];
end

endmodule