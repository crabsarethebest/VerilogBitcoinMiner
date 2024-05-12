//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/04/2024 07:26:15 PM
// Design Name: 
// Module Name: Testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


//module Testbench(
//    input clk,
//    input rst,
//    output logic led
//);
module sha256_testbench(
//    input logic clk,
//    input logic reset,
//    output logic led
);

    logic clk, rst, led, led_output;
    assign rst = 0;
    initial clk = 0;
    always #1 clk = ~clk;

        
    always_ff @(posedge clk) begin
        if(rst) begin
            led <= (led_output && 1'b0);
        end else begin
            led <= (led_output && 1'b1);
        end           
    end
    
    logic [0:255] midstate;
    logic [0:511] block2;
    assign midstate = 256'b0100011110101111101000100000011000011100101000101101111101101110001111001110101110011001100001111001011011111011010111111000111011011000000110000010010101010000001101101000011101010110011000010101100111101000011110010111010111001011111010000001001100000100;
    assign block2 = 512'b01100010011000110110000101100010011000110110000101100010011000110110000101100010011000111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001001011000;
    sha256_wrapper sha256_wrapper(.clk(clk), .rst(rst), .midstate(midstate), .block2(block2));
        
endmodule
