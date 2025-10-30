module tristatebufferfpga (
    input wire in,      
    input wire enable,   
    output wire out      
);
    assign out = enable ? in : 1'bZ; 
endmodule