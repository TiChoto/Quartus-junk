module instruction_decoder(
    input wire [31:0] instruction,
    output reg [3:0]  alu_op,
    output reg reg_write,
    output reg mem_read,
    output reg mem_write,
    output reg branch
);

    wire [6:0] opcode;
    assign opcode = instruction[6:0];

    always @(*) begin
        //default 
        alu_op     = 4'b0000;
        reg_write  = 0;
        mem_read   = 0;
        mem_write  = 0;
        branch     = 0;

        case (opcode)
            7'b0110011: begin //R-type 
                alu_op     = 4'b0001; 
                reg_write  = 1;
            end

            7'b0000011: begin //I-type 
                alu_op     = 4'b0010; 
                reg_write  = 1;
                mem_read   = 1;
            end

            7'b0100011: begin //S-type 
                alu_op     = 4'b0010; 
                mem_write  = 1;
            end

            7'b1100011: begin //B-type 
                alu_op     = 4'b0011; 
                branch     = 1;
            end

            7'b0110111: begin //U-type 
                alu_op     = 4'b0100; 
                reg_write  = 1;
            end

            7'b1101111: begin //J-type 
                alu_op     = 4'b0101; 
                reg_write  = 1;
            end

            default: begin
                //Invalid instruction: all control signals remain at 0
            end
        endcase
    end

endmodule
