`timescale 1ns / 1ps
module tbreg4bit;
reg clk;
reg we;
reg [2:0] addr;
reg [3:0] wdata;
wire [3:0] rdata;

  
reg4bit inst (
        .clk(clk),
        .we(we),
        .addr(addr),
        .wdata(wdata),
        .rdata(rdata)
);

//200ns
initial begin
        clk = 0;
        repeat (20) begin
            #5 clk = ~clk;
        end
    end
initial begin
we = 0;
addr = 0;
wdata = 0;
#20;
        
we = 1; addr = 0; wdata = 4'hA; #20
we = 0; #20

       
we = 1; addr = 3; wdata = 4'h5; #20
we = 0; #20

addr = 0;
#20;  
     $stop;
    end
endmodule