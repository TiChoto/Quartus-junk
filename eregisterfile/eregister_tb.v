`timescale 1ns / 1ps
module eregister_tb;
    reg clk = 0;
    reg we;
    reg [2:0] ra1, ra2, wa;
    reg [7:0] wd;
    wire [7:0] rd1, rd2;

 
    eregisterfile inst (
        .clk(clk),
        .we(we),
        .ra1(ra1),
        .ra2(ra2),
        .wa(wa),
        .wd(wd),
        .rd1(rd1),
        .rd2(rd2)
    );

    always #5 clk = ~clk;
    initial begin
        we = 0; ra1 = 0; ra2 = 0; wa = 0; wd = 0;
        #10;

        //write 42 to register 3
        we = 1; wa = 3; wd = 8'd42;
        #10;

        //write 99 to register 5
        wa = 5; wd = 8'd99;
        #10;

        //we = 0, so read happens
        we = 0;
        ra1 = 3; ra2 = 5;
        #10;

        //read same register
        ra1 = 3; ra2 = 3;
        #10;

        //check
        ra1 = 0; ra2 = 7;
        #10;

        $stop;
    end
endmodule
