`timescale 1ns/1ps
module counter_4bit_tb();

reg clk, dir;
wire [3:0] count;

counter_4bit dut(clk, dir, count);

initial begin
    clk = 0;
    repeat(40) #5 clk = ~clk;
end

initial begin
    dir = 1;
    #100 dir = 0;
    #100;
    $finish;
end

initial begin
    $dumpfile("counter_waves.vcd");
    $dumpvars(0, counter_4bit_tb);
end

endmodule