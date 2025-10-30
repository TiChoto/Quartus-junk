module jk_flipflop(
    input clk,
    input clear_n,    
    input preset_n,   
    input J,
    input K,
    output reg Q,
    output reg Q_n     
);

always @(posedge clk or negedge clear_n or negedge preset_n) begin
    if (!clear_n) begin    
        Q <= 1'b0;
        Q_n <= 1'b1;
    end
    else if (!preset_n) begin 
        Q <= 1'b1;
        Q_n <= 1'b0;
    end
    else begin               
        case ({J,K})
            2'b00: Q <= Q;     
            2'b01: Q <= 1'b0; 
            2'b10: Q <= 1'b1;  
            2'b11: Q <= ~Q;    
        endcase
        Q_n <= ~Q;           
    end
end

endmodule