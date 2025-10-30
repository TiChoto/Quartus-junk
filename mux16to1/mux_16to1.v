module mux_16to1 (
    input [15:0] data_in,  
    input [3:0] sel,       
    output reg out        
);

always @(*) begin
    out = data_in[sel];  
end

endmodule