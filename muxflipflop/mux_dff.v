module mux_dff(
    input clk,
    input sel,
    input data0,
    input data1,
    output reg Q
);

wire mux_out = sel ? data1 : data0;

always @(posedge clk) begin
    Q <= mux_out;
end

endmodule