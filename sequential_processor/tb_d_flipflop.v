`timescale 1ns / 1ps
module tb_d_flipflop();
reg clk;
reg rst;
reg d;
wire q;

d_flipflop inst (
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

//clock- 10ns period 100 MHz
always #5 clk = ~clk;

initial begin
    $dumpfile("tb_d_flipflop.vcd");
    $dumpvars(0, tb_d_flipflop);

    clk = 0;
    rst = 1; d = 0;  //active reset
    #10 rst = 0;     //deactivate reset
    d = 1; #10;      //input = 1
    d = 0; #10;      //input = 0
    d = 1; #10;      //input = 1
    rst = 1; #10;    //activate reset
    rst = 0; #10;    //deactivate reset

    #20 $finish;
end

endmodule
