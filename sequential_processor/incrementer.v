module incrementer (
    input [3:0] pc_in,   //current PC value
    output [3:0] pc_out  //new PC value
);

assign pc_out = pc_in + 1;

endmodule
