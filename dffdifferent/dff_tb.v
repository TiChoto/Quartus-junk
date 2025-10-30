`timescale 1ns/1ps
module dff_tb();

reg clk, rst_async, rst_sync, D;
wire Q_structural, Q_behavioral;

dff_structural structural_dff (
    .clk(clk),
    .rst_async(rst_async),
    .rst_sync(rst_sync),
    .D(D),
    .Q(Q_structural)
);

dff_behavioral behavioral_dff (
    .clk(clk),
    .rst_async(rst_async),
    .rst_sync(rst_sync),
    .D(D),
    .Q(Q_behavioral)
);


initial begin
    clk = 0;
    repeat (20) #5 clk = ~clk; 
end

initial begin
    
    rst_async = 1; rst_sync = 0; D = 0;
    #20 rst_async = 0;
    
   
    D = 1; #20;        
    rst_sync = 1; #20;   
    rst_sync = 0; D = 0; #20;
    D = 1; #20;
    rst_async = 1; #20;  
    rst_async = 0; #40;
    
    $finish;
end

initial begin
    $dumpfile("dff_waves.vcd");
    $dumpvars(0, dff_tb);
end

endmodule