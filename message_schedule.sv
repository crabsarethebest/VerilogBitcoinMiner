`include "sigma_functions.sv"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// Create Date: 04/08/2024 07:55:01 PM
// Design Name: 
// Module Name: message_schedule
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


module message_schedule(
    input logic [0:511] message_block,
    output logic [0:31] message_schedule[0:63]
    );
    

    always_comb begin
        for (int i = 0; i < 16; i++) begin
            message_schedule[i] = message_block[i*32+ : 32];
        end
        
        for (int j = 16; j < 64; j++) begin
            logic [0:31] message;
            message = sigma_functions::lower_sigma_one(message_schedule[j-2]) + message_schedule[j-7] + sigma_functions::lower_sigma_zero(message_schedule[j-15]) + message_schedule[j-16];
            message_schedule[j] = message;
            
        end
    end

endmodule
