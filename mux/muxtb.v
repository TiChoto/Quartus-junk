module muxtb;
    reg [3:0] data;  
    reg [1:0] sel;   
    wire out;      

    muxgate inst (
        .data(data),
        .sel(sel),
        .y(out)
    );

    initial begin
        data = 4'b1011; 
        sel = 2'b00; #10; 
        sel = 2'b01; #10;
        sel = 2'b10; #10; 
        sel = 2'b11; #10; 
        $stop;
    end
endmodule

module muxgate (
    input [3:0] data,  
    input [1:0] sel,   
    output reg y     
);
    always @(*) begin
        case (sel)
            2'b00: y = data[0];
            2'b01: y = data[1];
            2'b10: y = data[2];
            2'b11: y = data[3];
            default: y = 1'b0; 
        endcase
    end
endmodule