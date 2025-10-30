module dflipflop (
    input wire clk,        //clock in
    input wire rst_async,  //asyn reset 
    input wire rst_sync,   //sync reset 
    input wire D,          //data in
    output reg Q           //data out
);
always @(posedge clk or posedge rst_async) begin
    if (rst_async) 
        Q <= 1'b0;        //reset imm
    else if (rst_sync) 
        Q <= 1'b0;        //Or reset ce
    else 
        Q <= D;           //Or normal op
end

endmodule