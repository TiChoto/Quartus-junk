module IE #(parameter N = 16, M = 32)( //Parameters for our case
    input [N-1:0] in,
    input U, // 1 = zero extend, 0 = sign extend
    output [M-1:0] out
);
    assign out = (U == 1'b1) ? {{(M-N){1'b0}}, in} : {{(M-N){in[N-1]}}, in};
endmodule
