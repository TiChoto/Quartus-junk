module gpr_fpga (
    input clk,                  
    input Sw,                  
    input [4:0] Sa, Sb, Sc,     
    input [31:0] Sin,           //switches in sequence
    output reg [31:0] Souta, South, //LEDs and HEX
    output [7:0] LEDG,          //Status LEDs
    output [9:0] LEDR,          //Partial display
    output [6:0] HEX0, HEX1, HEX2, HEX3 //Full display
);

    
    reg [31:0] regfile [31:0];
    wire [31:0] decSa = (1 << Sa);
    wire [31:0] decSb = (1 << Sb);
    wire [31:0] decSc = (1 << Sc);
    
    integer i;
    
    always @(posedge clk) begin
        if (Sw) begin
            for (i = 1; i < 32; i = i + 1) begin //Skip reg0
                if (decSc[i])
                    regfile[i] <= Sin;
            end
            regfile[0] <= 32'b0; //reg0 - 0
        end
    end
    
    always @(*) begin
        Souta = 32'b0;
        South = 32'b0;
        for (i = 0; i < 32; i = i + 1) begin
            if (decSa[i]) Souta = Souta | regfile[i];
            if (decSb[i]) South = South | regfile[i];
        end
    end
    
    assign LEDG = {Sw, Sa[2:0], Sb[2:0]}; 
    assign LEDR = Souta[9:0];             //low 10 bit output
    
    //full 32-bit output
    seg7 hex0_display(.in(Souta[3:0]),   .out(HEX0));
    seg7 hex1_display(.in(Souta[7:4]),   .out(HEX1));
    seg7 hex2_display(.in(Souta[11:8]),  .out(HEX2));
    seg7 hex3_display(.in(Souta[15:12]), .out(HEX3));
endmodule

// 7-segment display helper module
module seg7(input [3:0] in, output reg [6:0] out);
    always @(*) begin
        case (in)
            0: out = 7'b1000000; 1: out = 7'b1111001;
            2: out = 7'b0100100; 3: out = 7'b0110000;
            4: out = 7'b0011001; 5: out = 7'b0010010;
            6: out = 7'b0000010; 7: out = 7'b1111000;
            8: out = 7'b0000000; 9: out = 7'b0010000;
            10: out = 7'b0001000; 11: out = 7'b0000011;
            12: out = 7'b1000110; 13: out = 7'b0100001;
            14: out = 7'b0000110; 15: out = 7'b0001110;
            default: out = 7'b1111111;
        endcase
    end
endmodule