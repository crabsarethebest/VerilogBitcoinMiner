`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/06/2024 04:23:00 PM
// Design Name: 
// Module Name: pad512
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


module multiples_of_512(
    input integer bits_width,
    output integer padded_message_width
    );
    
    
    integer number_512_multiples = 1;
    
    assign padded_message_width = number_512_multiples * 512;
    
    always_comb
        while ((number_512_multiples * 512 - bits_width) < 64) begin
            number_512_multiples += 1;
        end
                
        
        
        
        
        
         
    

endmodule
