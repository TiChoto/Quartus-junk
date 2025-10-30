`timescale 1ns/1ps
module tb_program_counter;

reg clk;
reg reset_n;
wire [3:0] pc_out;

program_counter inst (
    .clk(clk),
    .reset_n(reset_n),
    .pc_out(pc_out)
);

initial begin
    clk = 0;
    repeat (500) begin  //5000ns
        #5 clk = ~clk;
    end
end


initial begin
    reset_n = 0;
    #10;
    reset_n = 1;

    #100;  
    $stop; 
end

endmodule
