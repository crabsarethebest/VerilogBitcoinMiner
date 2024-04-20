`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2024 03:59:24 PM
// Design Name: 
// Module Name: Testbench_wrapper
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


module Testbench_wrapper(

    );



    BitcoinMinerBlockDesign_wrapper wrap1(.sys_clock(clkin));
    
  // Instantiate Clocking Wizard IP (replace <ClockWizardModule> with actual module name)
//  <ClockWizardModule> clock_wiz (
//    // Connect Clocking Wizard inputs and outputs here
//    // ...
//  );

  // Define clock input signal
  reg clkin;

 initial begin
    clkin = 1'b0; // Initialize the clock signal
    forever #5 clkin = ~clkin; // Toggle clkin every 5 time units (adjust as needed)
 end

  // Instantiate your design module here and connect it to clock outputs, if applicable

  // Your testbench code continues...
  
  endmodule