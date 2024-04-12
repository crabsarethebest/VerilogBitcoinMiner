`include "sha256_constants.sv"
`include "sigma_functions.sv"
`include "bit_select_functions.sv"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/10/2024 04:19:32 PM
// Design Name: 
// Module Name: hash_constants
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


module hash_constants(
    input logic [0:31] message_schedule[0:63],
    input logic [0:31] a_in,
    input logic [0:31] b_in,
    input logic [0:31] c_in,
    input logic [0:31] d_in,
    input logic [0:31] e_in,
    input logic [0:31] f_in,
    input logic [0:31] g_in,
    input logic [0:31] h_in,
    output logic [0:31] a_out,
    output logic [0:31] b_out,
    output logic [0:31] c_out,
    output logic [0:31] d_out,
    output logic [0:31] e_out,
    output logic [0:31] f_out,
    output logic [0:31] g_out,
    output logic [0:31] h_out
    );
    
    logic [0:31] w_const;
    logic [0:31] k_const;
    logic [0:31] T1;
    logic [0:31] T2;
    always_comb begin
        for (int i = 0; i < 64; i++) begin
            w_const = message_schedule[i];
            k_const = sha256_constants::k_constants[i];
            T1 = sigma_functions::upper_sigma_one(e_in); // Todo, pick it up from here.  Right choice function.
            // Todo: for T2 write majority function
        end
   end 
endmodule
