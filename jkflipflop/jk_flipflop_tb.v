`timescale 1ns/1ps
module jk_flipflop_tb();

reg clk, clear_n, preset_n, J, K;
wire Q, Q_n;


jk_flipflop dut (
    .clk(clk),
    .clear_n(clear_n),
    .preset_n(preset_n),
    .J(J),
    .K(K),
    .Q(Q),
    .Q_n(Q_n)
);


initial begin
    clk = 0;
    repeat (20) #5 clk = ~clk;
end


initial begin
   
    clear_n = 1; preset_n = 1; J = 0; K = 0;
  
    #10 clear_n = 0; 
    #10 clear_n = 1;  
    
   
    #10 preset_n = 0; 
    #10 preset_n = 1;
    
  
    #10 J = 0; K = 0; 
    #10 J = 0; K = 1;
    #10 J = 1; K = 0;
    #10 J = 1; K = 1; 
    #30;
    
   
    #10 clear_n = 0;
    #10 clear_n = 1;
    
   
    #10 preset_n = 0;
    #10 preset_n = 1;
    
    #20 $finish;
end


initial begin
    $dumpfile("jk_ff_waves.vcd");
    $dumpvars(0, jk_flipflop_tb);
    $display("Time\tClk\tClear\tPreset\tJ\tK\tQ\tQ_n");
    $monitor("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b", 
            $time, clk, clear_n, preset_n, J, K, Q, Q_n);
end

endmodule