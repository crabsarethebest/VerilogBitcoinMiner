module sha256 (
    input logic clk,
    input logic reset,
    input logic [9:0] input_length,
    input logic [0:511] binary_input
    );

    int upper_bound;
    integer padded_message_width;
    logic [0:511] padded_message;
    
    // Split original message into multiples of 512
    multiples_of_512 multiples_of_512_instantiation(.bits_width(bits_width), .padded_message_width(padded_message_width));
    
    
    // Create FSM
    typedef enum logic [2:0] {SPLIT_MESSAGE, MESSAGE_SCHEDULE, C, D, E} State;
    
    State currentState, nextState;
    
    always_ff @(posedge clk)
        if(reset) currentState <= SPLIT_MESSAGE;
        else currentState <= nextState;
        
    // next state logic
    always_comb
        case(currentState)
            SPLIT_MESSAGE: nextState = MESSAGE_SCHEDULE;
            MESSAGE_SCHEDULE: nextState = C;
            C: nextState = D;
            D: nextState = E;
            E: nextState = SPLIT_MESSAGE;
            
        default: nextState = SPLIT_MESSAGE;
        endcase
        
    integer i;
    integer j = 511 - input_length;
    // output logic
    always_comb

        case(currentState)
            SPLIT_MESSAGE: begin
                // Initialize the padded message with all '0's
                padded_message = '0;
                                
                for(i=0;i<=511;i=i+1) begin
                    if (binary_input[i]) begin
                        padded_message=binary_input[i+:511];
                        break;
                    end
                end
                
                padded_message[input_length] = 1;
                
                padded_message = padded_message | input_length; // append length
                
    
//                for (i=10; i>=0;i=i-1) begin
//                        if (input_length[i]) begin
//                            padded_message[j]=input_length[i+:10];
//                            break;
//                        end
//                        j=j+1;              
//                end
                
                
//                for (i=0; i<=10;i=i+1) begin
                
//                    if (input_length[i]) begin
//                        padded_message[448+i]=input_length[i+:10];
//                        break;
//                    end               
//                end




                // Copy the binary input to the most significant bits of the padded message
                //padded_message[511:upper_bound] = binary_input;
                
/*        
                // Set the bit after the binary input to '1'
                padded_message[511 - input_length] = 1'b1;
        
                // Calculate the number of '0' bits needed for padding
                int padding_length = 448 - input_length; // 448 is congruent to 448 modulo 512 when the input length is variable
        
                // Append the '0' bits for padding
                for (int i = 0; i < padding_length; i++) begin
                    padded_message[511 - input_length - 1 - i] = 1'b0;
                end*/
        
                // Append the length of the original message as a 64-bit big-endian integer
                // We set the last 6 bits accordingly for simplicity
                //padded_message[479:474] = input_length; // Length of the input
                //padded_message[473:468] = 6'b0; // Remaining bits set to 0
                
                //padded_message = bits << (padded_message_width - bits_width);
                //padded_message = bits | (1 << (int'(bits_width)));
                //padded_message = padded_message | (bits_width << (padded_message_width - 64));  // TODO: FIX this to non-default 50
            end

            default: begin
                padded_message = 1'b0;
            end
        endcase
endmodule
