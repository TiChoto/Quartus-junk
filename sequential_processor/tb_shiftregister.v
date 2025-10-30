`timescale 1ns/1ps
module tb_shiftregister;
    reg clk, rst, load, dir, serial_in;
    reg [3:0] parallel_in;
    wire [3:0] parallel_out;
    wire serial_out;

shift_register inst (
     .clk(clk),
     .rst(rst),
     .load(load),
     .dir(dir),
     .serial_in(serial_in),
     .parallel_in(parallel_in),
     .parallel_out(parallel_out),
     .serial_out(serial_out)
);
	 
initial begin
 clk = 0;
   repeat (500) begin  //5000ns
      #5 clk = ~clk;
   end
end

    
initial begin
     rst = 1; load = 0; dir = 0; serial_in = 0; parallel_in = 0;
     #20 rst = 0;
   
     parallel_in = 4'b1100;
     load = 1;
     #20 load = 0;

     dir = 1;
     serial_in = 1; 
     #20; 
     #20; 
        
     dir = 0;
     serial_in = 0;
     #20; 
     #20; 
     #40 $finish;
    end
endmodule