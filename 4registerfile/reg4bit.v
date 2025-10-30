module reg4bit (
    input clk,         
    input we,           
    input [2:0] addr,   //Why 3 idk
    input [3:0] wdata,  //write data
    output [3:0] rdata  //read data
);

reg [3:0] registers [0:3]; 

//synch write 
always @(posedge clk) begin
    if (we)
        registers[addr[1:0]] <= wdata;
end

//asynch read
assign rdata = registers[addr[1:0]];

endmodule