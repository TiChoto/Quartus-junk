module dff_structural(
    input clk,
    input rst_async,
    input rst_sync,
    input D,
    output Q
);


wire nand1_out, nand2_out;
wire master_out, master_feedback;


wire nand3_out, nand4_out;
wire slave_out, slave_feedback;


nand nand1(nand1_out, D, clk);
nand nand2(nand2_out, ~D, clk);
nand nand3(master_out, nand1_out, master_feedback);
nand nand4(master_feedback, nand2_out, master_out);


nand nand5(nand3_out, master_out, ~clk);
nand nand6(nand4_out, ~master_out, ~clk);
nand nand7(slave_out, nand3_out, slave_feedback);
nand nand8(slave_feedback, nand4_out, slave_out);

assign Q = rst_async ? 1'b0 : 
           (rst_sync & clk) ? 1'b0 : slave_out;

endmodule