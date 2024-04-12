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
    output logic [0:31] h_out,
    output logic [0:255] hash_out
    );

    logic [0:31] w_const;
    logic [0:31] k_const;
    logic [0:31] T1;
    logic [0:31] T2;
    always_comb begin
        a_out = a_in;
        b_out = b_in;
        c_out = c_in;
        d_out = d_in;
        e_out = e_in;
        f_out = f_in;
        g_out = g_in;
        h_out = h_in;
    
        for (int i = 0; i < 64; i++) begin
            w_const = message_schedule[i];
            k_const = sha256_constants::k_constants[i];
            T1 = sigma_functions::upper_sigma_one(e_out) + bit_select_functions::choice(e_out, f_out, g_out) +
            h_out + k_const + w_const;
            T2 = sigma_functions::upper_sigma_zero(a_out) + bit_select_functions::majority(a_out, b_out, c_out);
            
            h_out = g_out;
            g_out = f_out;
            f_out = e_out;
            e_out = d_out;
            d_out = c_out;
            c_out = b_out;
            b_out = a_out;
       
            a_out = T1 + T2; 
            e_out = e_out + T1;           
        end
        
        a_out = a_in + a_out;
        b_out = b_in + b_out;
        c_out = c_in + c_out;
        d_out = d_in + d_out;
        e_out = e_in + e_out;
        f_out = f_in + f_out;
        g_out = g_in + g_out;
        h_out = h_in + h_out;

        hash_out = {a_out, b_out, c_out, d_out, e_out, f_out, g_out, h_out};

   end 
endmodule
