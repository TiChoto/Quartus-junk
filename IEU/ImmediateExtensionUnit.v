`timescale 1ns / 1ps
module ImmediateExtensionUnit #(
    parameter N = 16,  //Input width 
    parameter M = 32   //Output width 
)(
    input wire U, // 1=zero extension, 0=sign extension
    input wire [N-1:0] immediateIN,  
    output wire [M-1:0] immediateOUT 
);

    //how many bits we to extend
    localparam EXTENSION_BITS = M - N;
    
    //replicate MSB of input
    wire [EXTENSION_BITS-1:0] sign_extension = {(EXTENSION_BITS){immediateIN[N-1]}};
    
    //pad with zeros
    wire [EXTENSION_BITS-1:0] zero_extension = {EXTENSION_BITS{1'b0}};
    
    //Select extension types
    wire [EXTENSION_BITS-1:0] extension = U ? zero_extension : sign_extension;
    
    //Concatenate extension bits with input
    assign immediateOUT = {extension, immediateIN};

endmodule