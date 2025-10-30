`timescale 1ns/1ps
module dflipflop_tb;

//inputs
reg clk;
reg rst_async;
reg rst_sync;
reg D;

//output
wire Q;

//instantiate
dflipflop inst (.*);

//clock generation
initial begin
    clk = 0;
    repeat(20) #5 clk = ~clk; 
end
initial begin
    rst_async = 1; rst_sync = 0; D = 0;
    #20;    
    //release async reset
    rst_async = 0;
	 #10
    
    D = 1; #10; //Q should capture 1
    rst_sync = 1; #10; //Q sync to 0
    rst_sync = 0; D = 0; #10;
    D = 1; #10;
    rst_async = 1; #10; //immediate reset
    rst_async = 0; #10;
	 
    $finish;
end
initial begin
    $monitor("Time, D, Q, AsyncRst, SyncRst)", 
             $time, D, Q, rst_async, rst_sync);
end

endmodule