module counter (
    input clk,          
    input reset_n,     
    output reg [3:0] count_out  
);


always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        count_out <= 4'b0000;  
    else
        count_out <= count_out + 1'b1;  
end

endmodule
