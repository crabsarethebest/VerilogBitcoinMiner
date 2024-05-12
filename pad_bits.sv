//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/07/2024 04:33:29 PM
// Design Name: 
// Module Name: pad_bits
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

module pad_bits(
    input logic [0:255] unpadded_message,
    output logic [0:511] padded_message
    );
    
    always_comb begin
        integer i;
        logic [0:9] message_length;
        message_length = 10'd256;
        padded_message = '0; // Initialize the padded message with all '0's
        
        for(i=0;i<=255;i=i+1) begin // Move message to most significant bits
            if (unpadded_message[i]) begin
                padded_message[i]=unpadded_message[i];
            end
        end
        
        padded_message[256] = 1; // Set bit immediately following message
        
        for(i=0;i<=9;i=i+1) begin
            padded_message[511-9+i]=message_length[i];
        end 
    end          
       
//    always_comb begin
//                integer i;
//                padded_message = '0; // Initialize the padded message with all '0's
                
//                $display("binary input is %b", binary_input);
   
//                for(i=0;i<=1023;i=i+1) begin // Move message to most significant bits
//                    if (binary_input[i]) begin
//                        padded_message[i]=binary_input[i];
//                    end
//                end                
                
//                padded_message[input_length] = 1; // Set bit immediately following message

//                if (multiples_of_512_output == 2)             
//                    padded_message = padded_message | input_length; // Append message length to least significant bits
//                else begin
//                    for(i=0;i<=9;i=i+1) begin
//                        padded_message[511-9+i]=input_length[i];
//                    end
//                end
   
//    end
endmodule
