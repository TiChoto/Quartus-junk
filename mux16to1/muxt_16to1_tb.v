`timescale 1ns/1ps
module mux_16to1_tb();
    reg [15:0] data_in;
    reg [3:0] sel;
    wire out;
    
    mux_16to1 inst (
        .data_in(data_in),
        .sel(sel),
        .out(out)
    );
   
    initial begin
        data_in = 16'hABCD; 
        sel = 0;

        repeat (16) begin
            #10;
            $display(sel, out);
				sel = sel + 1;
        end
        
        data_in = 16'b1010101010101010;
        #10 sel = 4'b0101;
        #10 sel = 4'b1010;
        
        #50 $finish;
    end
endmodule