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
    output logic [0:31] h_constants [0:63]
    );
    
    
//    always_comb begin
//        for (int i = 0; i < 64; i++) begin
//            logic [0:31] T1;
//            logic [0:31] T2;
//            message_schedule[i] = message_block[i*32+ : 32];
        
//        for (int j = 16; j < 64; j++) begin
//            logic [0:31] message;
//            message = sigma_functions::lower_sigma_one(message_schedule[j-2]) + message_schedule[j-7] + sigma_functions::lower_sigma_zero(message_schedule[j-15]) + message_schedule[j-16];
//            message_schedule[j] = message;
            
//        end
//    end
endmodule
