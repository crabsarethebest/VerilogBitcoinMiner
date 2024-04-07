`timescale 1ns / 1ps
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


module Testbench();
    logic [1023:0] bits = 1024'b011000010110001001100011; // 'abc'
    integer bits_width = 24;
    logic reset;
    reg clk = 0;
    sha256 sha256_instantiation(.bits_width(bits_width), .bits(bits), .reset(reset), .clk(clk));
    
    always #1 clk = ~clk;
        
    initial begin
        #5
        reset = 1'b0;
        #5
        reset = 1'b1;
        #5
        reset = 1'b0;
        #5
        $display("hello");
        //$display(sha256_instantiation.x);
    end
endmodule
