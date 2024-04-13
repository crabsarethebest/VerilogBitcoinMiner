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
    output integer multiples_of_512_output
    );
     
    assign padded_message_width = multiples_of_512_output * 512;
    
    always_comb begin
        multiples_of_512_output = 1;
        if ((multiples_of_512_output * 512 - int'(input_length)) < 64) begin
            multiples_of_512_output++;
        end
    end             
        
endmodule
