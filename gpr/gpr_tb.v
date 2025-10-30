`timescale 1ns/1ps
module gpr_tb;
    reg clk;
    reg Sw;
    reg [31:0] Sin;
    reg [4:0] Sa, Sb, Sc;
    wire [31:0] Souta, Soutb;

    gpr inst (
        .clk(clk),
        .Sw(Sw),
        .Sin(Sin),
        .Sa(Sa),
        .Sb(Sb),
        .Sc(Sc),
        .Souta(Souta),
        .Soutb(Soutb)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        Sw = 0;
        Sin = 0;
        Sa = 0;
        Sb = 0;
        Sc = 0;    
        #10;

        Sw = 1;
        Sc = 5'd0;
        Sin = 32'hDEADBEEF;
        #10;

        //Hexadecimal cuz binary 32 is too long
        Sc = 5'd5;
        Sin = 32'hAAAA5555;
        #10;
        Sc = 5'd10;
        Sin = 32'h12345678;
        #10;

        Sw = 0;

        Sa = 5'd5;
        Sb = 5'd10;
        #10;

        Sa = 5'd0;
        Sb = 5'd0;
        #10;

        Sa = 5'd15;
        Sb = 5'd15;
        #10;

        $stop;
    end

endmodule
