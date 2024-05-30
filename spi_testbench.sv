`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2024 03:43:31 PM
// Design Name: 
// Module Name: spi_testbench
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


module spi_slave_testbench(
    );
    
    // Clock signal declaration
    logic clk;
    logic chip_enable;
    logic send_byte;


    // Clock generation block
    initial begin
        clk = 1; // Initialize the clock to 0
        chip_enable = 1;
        forever #1 clk = ~clk;
    end

    // Simulation run time
    initial begin
        send_byte = 0;
        chip_enable = 1;
        #10;
        send_byte = 1;
        chip_enable = 0;
        // Simulation will run for 100 clock cycles
        #1000; // Assuming 10 ns clock period, 1000 ns simulation time
        $finish; // End the simulation
    end

    // Add any testbench components or DUT connections here
    // Example: instantiation of a Device Under Test (DUT) with clock connected
    // DUT dut_instance (.clk(clk), .other_signals(...));
    
    spi_slave spli_slave0 (.clk(clk), .chip_enable(chip_enable));
endmodule
