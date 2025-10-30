module dff_behavioral(
    input clk,
    input rst_async,
    input rst_sync,
    input D,
    output reg Q
);

always @(posedge clk or posedge rst_async) begin
    if (rst_async) 
        Q <= 1'b0;
    else if (rst_sync) 
        Q <= 1'b0;
    else 
        Q <= D;
end

endmodule