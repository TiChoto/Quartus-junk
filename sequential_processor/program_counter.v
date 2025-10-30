module program_counter (
    input clk,
    input reset_n,
    output reg [3:0] pc_out
);


wire [3:0] pc_next;  


incrementer inst (
    .pc_in(pc_out),   
    .pc_out(pc_next)   
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n)
        pc_out <= 4'b0000; 
    else
        pc_out <= pc_next;  
end

endmodule
//This one is structural ERROR is in presentation