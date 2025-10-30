module alubranch (
    input [3:0] A,          
    input [3:0] B,        
    input [2:0] opcode,     //000-add 001-sub 010-and 011-or 100-slt
    output reg [3:0] result,
    output reg zero             //beq and bne
);

    wire [4:0] add_result = A + B;
    wire [4:0] sub_result = A - B; //4:0 cause of overflow but we store 4 bits

    always @(*) begin
        case (opcode)
            3'b000: result = add_result[3:0];             
            3'b001: result = sub_result[3:0];             
            3'b010: result = A & B;                       
            3'b011: result = A | B;                       
            3'b100: result = (sub_result[4]) ? 4'b1 : 4'b0; //signed
				3'b101: result = 4'b0;
				3'b110: result = 4'b0;
            default: result = 4'b0;
        endcase
		  
		  case(opcode)
				3'b101: zero = (A == B);
				3'b110: zero = (A != B);
				default: zero = (result == 0);
		  endcase
    end
endmodule
