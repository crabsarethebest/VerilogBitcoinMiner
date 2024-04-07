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

    logic [0:511] bits = '0; // Initialize with all zeros

    // Your input data
    logic [0:23] bits_value = 24'b011000010110001001100011;

    always_comb begin
        // Loop to set the bits from binary_input
        for (int i = 0; i < 24; i++) begin
            bits[i] = bits_value[i];
        end
        
    $display("%b",bits[0]);
    $display("%b",bits[1]);
    $display("%b",bits[2]);
    $display("%b",bits[3]);
    $display("%b",bits[4]);
    $display("%b",bits[5]);
   end 

    
//    logic [0:511] bits = 512'b011000010110001001100011; // 'abc'
    logic [9:0]  bits_width = 24;
    logic reset;
    reg clk = 0;
    sha256 sha256_instantiation(.input_length(bits_width), .binary_input(bits), .reset(reset), .clk(clk));
    
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
