`timescale 1ns/1ps
module mux4to1_tb;
    reg  [3:0] in0, in1, in2, in3;
    reg  [1:0] sel;
    wire [3:0] out;

    mux4to1 #(.wd(4)) inst (
        .in0(in0), 
		  .in1(in1), 
		  .in2(in2), 
		  .in3(in3), 
		  .sel(sel), 
		  .out(out)
    );

    initial begin
        in0 = 4'd1; in1 = 4'd3; in2 = 4'd7; in3 = 4'd15;
        sel = 2'b00; #20;
        sel = 2'b01; #20;
        sel = 2'b10; #20;
        sel = 2'b11; #20;
        $stop;
    end

endmodule
