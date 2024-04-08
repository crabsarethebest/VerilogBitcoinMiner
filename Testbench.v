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

    logic [0:1023] binary_input = '0; // Initialize with all zeros

    logic [0:23] bits_value = 24'b011000010110001001100011;
    logic [0:9]  input_length = 24;

    always_comb begin
        // Loop to set the bits from binary_input
        for (int i = 0; i < 24; i++) begin
            binary_input[i] = bits_value[i];
        end
   end 

    sha256 sha256_instantiation(.input_length(input_length), .binary_input(binary_input));
    
endmodule
