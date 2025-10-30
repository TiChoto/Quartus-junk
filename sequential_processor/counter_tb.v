`timescale 1ns/1ps
module counter_tb;

reg clk;
reg reset_n;
wire [3:0] count_out;

counter inst (
    .clk(clk),
    .reset_n(reset_n),
    .count_out(count_out)
);


initial begin
    clk = 0;
     repeat (500) begin  //5000ns
        #5 clk = ~clk;
    end
end


initial begin

    reset_n = 0;
    #20;
    
    reset_n = 1;   
    #100;          

    $stop;         
end

endmodule
