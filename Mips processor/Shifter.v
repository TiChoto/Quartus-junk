module Shifter (
		 input [1:0] funct,
		 input signed [31:0] a,
		 input [4:0] N,
		 output reg [31:0] R
);
		 wire [31:0] logical_sr = a >> N;
		 wire [31:0] logical_sl = a << N;
		 reg [31:0] Sntd;

		 always @(*) begin
			  case (funct)
					2'b00: R = logical_sl;
					2'b10: R = logical_sr;
					2'b11: begin
						 Sntd = (a[31] ? ~32'b0 : 32'b0) << (32 - N);
						 R = (a >> N) | Sntd;
					end
					default: R = 32'b0;
			  endcase
		 end
	endmodule
