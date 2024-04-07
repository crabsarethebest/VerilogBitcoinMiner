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
    logic [9:0] input_length,
    output integer padded_message_width,
    output integer multiples_of_512
    );
    
    
    assign multiples_of_512 = 1;
    
    assign padded_message_width = multiples_of_512 * 512;
    
    always_comb begin
        while ((multiples_of_512 * 512 - input_length) < 64) begin
            multiples_of_512  += 1;
        end
        $display("input length: %d", input_length);
        $display("multiples of 512: %d", multiples_of_512);
    end             
        
        
        
        
        
         
    

endmodule
