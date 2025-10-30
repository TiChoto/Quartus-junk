module d_flipflop (
    input wire clk,      //clock Signal
    input wire rst,      //asynchronous Reset
    input wire d,        //input
    output reg q         //output
);

always @(posedge clk or posedge rst) begin
    if (rst) 
        q <= 1'b0;       //reset output to 0
    else 
        q <= d;          //store input on rising edge of clock
end

endmodule
