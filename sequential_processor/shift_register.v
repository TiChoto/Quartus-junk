module shift_register (
    input clk,
    input rst,
    input load,          
    input dir,           
    input serial_in,     
    input [3:0] parallel_in,  
    output [3:0] parallel_out,
    output serial_out     
);

//inst 4 D flip-flops
wire [3:0] d_in; 

//logic to determine D inputs based on load/dir
assign d_in[0] = load ? parallel_in[0] : (dir ? serial_in : parallel_out[1]);
assign d_in[1] = load ? parallel_in[1] : (dir ? parallel_out[0] : parallel_out[2]);
assign d_in[2] = load ? parallel_in[2] : (dir ? parallel_out[1] : parallel_out[3]);
assign d_in[3] = load ? parallel_in[3] : (dir ? parallel_out[2] : serial_in);

d_flipflop ff0 (.clk(clk), .rst(rst), .d(d_in[0]), .q(parallel_out[0]));
d_flipflop ff1 (.clk(clk), .rst(rst), .d(d_in[1]), .q(parallel_out[1]));
d_flipflop ff2 (.clk(clk), .rst(rst), .d(d_in[2]), .q(parallel_out[2]));
d_flipflop ff3 (.clk(clk), .rst(rst), .d(d_in[3]), .q(parallel_out[3]));

assign serial_out = dir ? parallel_out[0] : parallel_out[3];

endmodule