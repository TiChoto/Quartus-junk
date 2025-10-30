`timescale 1ns/1ps
module spr_ram_tb;
reg clk;
reg Sw;
reg [4:0] Sa;
reg [31:0] Sce;
reg [1023:0] Sdin_flat;
reg [31:0] Sin;
wire [31:0] Sout;

spr_ram inst (
    .clk(clk),
    .Sw(Sw),
    .Sa(Sa),
    .Sce(Sce),
    .Sdin_flat(Sdin_flat),
    .Sin(Sin),
    .Sout(Sout)
);


always begin
        #5 clk = ~clk;
end

//Sdin for reg
task set_sdin;
    input [4:0] reg_num;
    input [31:0] value;
    begin
        Sdin_flat[reg_num*32 +: 32] = value;
    end
endtask

initial begin
    Sw = 0;
    Sa = 0;
    Sce = 0;
    Sin = 0;
    Sdin_flat = 0;
    #10;

    //reg5 using Sdin 
    Sce = 32'h00000020;  
    set_sdin(5, 32'hA5A5A5A5);  
    Sw = 1;  
    #10;  
    Sw = 0;
    Sa = 5;  
    #5;

    //reg10 using Sin 
    Sce = 0;  
    Sin = 32'hDEADBEEF;
    Sw = 1;
    #10;
    Sw = 0;
    Sa = 10;
    #5;

    //reg7 didn't change change
    Sa = 7;
    #5;
	 
    $stop;
end

endmodule