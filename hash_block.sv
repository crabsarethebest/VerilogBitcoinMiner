//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 06/18/2024 01:58:34 PM
// Design Name: 
// Module Name: hash_block
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


module hash_block(
    input logic clk,
    input logic rst,
    input logic [0:31] message_schedule[0:31],
    input logic [0:31] k_constants [0:31],
    input logic [0:31] a,
    input logic [0:31] b,
    input logic [0:31] c,
    input logic [0:31] d,
    input logic [0:31] e,
    input logic [0:31] f,
    input logic [0:31] g,
    input logic [0:31] h,
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
        a_out = a;
        b_out = b;
        c_out = c;
        d_out = d;
        e_out = e;
        f_out = f;
        g_out = g;
        h_out = h;
    
        for (int i = 0; i < 32; i++) begin
            w_const = message_schedule[i];
            k_const = k_constants[i];
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
   end 

endmodule
