`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2024 03:34:53 PM
// Design Name: 
// Module Name: fpga_raspberry_pi_fsm_testbench
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


module fpga_raspberry_pi_fsm_testbench(

    );
    
    logic clk, rst, led, led_output, recieved_midstate_and_block_2;
    initial clk = 0;
    always #1 clk = ~clk;
    initial begin
        recieved_midstate_and_block_2 = 0;
        rst = 0;
        #1
        rst = 1;
        #1
        rst = 0;
        #10
        recieved_midstate_and_block_2 = 1;
    end
    
    fpga_raspberry_pi_fsm fpga_raspberry_pi_fsm_0(.clk(clk), .rst(rst), .recieved_midstate_and_block_2(recieved_midstate_and_block_2));
endmodule
