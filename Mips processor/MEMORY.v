module MEMORY (
    input clk,
    input MemRead,
    input MemWrite,
    input [31:0] Address,
    input [31:0] WriteData,
    output reg [31:0] ReadData
);
    parameter MEM_SIZE = 256;
    reg [31:0] mem [0:MEM_SIZE-1];

    initial begin
        $readmemh("instr_mem.hex", mem);
    end

    always @(posedge clk) begin
        if (MemWrite) begin
            mem[Address[31:2]] <= WriteData;
        end
    end

    always @(*) begin
        if (MemRead) begin
            ReadData = mem[Address[31:2]];
        end else begin
            ReadData = 32'b0;
        end
    end
endmodule
