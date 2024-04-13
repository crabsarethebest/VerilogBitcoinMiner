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
    input logic [0:9] input_length,
    input logic [0:1023] binary_input,
    output integer multiples_of_512_output,
    output logic [0:1023] padded_message
    );
    
    
    //logic [0:2] multiples_of_512;
    
    // Split original message into multiples of 512
    multiples_of_512 multiples_of_512_instantiation(.input_length(input_length), .multiples_of_512_output(multiples_of_512_output));
    



        
    always_comb begin
                integer i;
                padded_message = '0; // Initialize the padded message with all '0's
                
                $display("binary input is %b", binary_input);
   
                for(i=0;i<=1023;i=i+1) begin // Move message to most significant bits
                    if (binary_input[i]) begin
                        padded_message[i]=binary_input[i];
                    end
                end                
                
                padded_message[input_length] = 1; // Set bit immediately following message

                if (multiples_of_512_output == 2)             
                    padded_message = padded_message | input_length; // Append message length to least significant bits
                else begin
                    for(i=0;i<=9;i=i+1) begin
                        padded_message[511-9+i]=input_length[i];
                    end
                end
   
    end
endmodule
