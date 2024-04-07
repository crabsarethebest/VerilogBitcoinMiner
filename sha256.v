module sha256 (
    input logic clk,
    input logic reset,
    input logic [0:9] input_length,
    input logic [0:1023] binary_input
    );

    integer padded_message_width;
    logic [0:1023] padded_message;
    logic [0:2] multiples_of_512;
    
    // Split original message into multiples of 512
    multiples_of_512 multiples_of_512_instantiation(.input_length(input_length), .padded_message_width(padded_message_width), .multiples_of_512(multiples_of_512));
    
    
    // Create FSM
    typedef enum logic [2:0] {PAD_MESSAGE, MESSAGE_SCHEDULE, C, D, E} State;
    
    State currentState, nextState;
    
    always_ff @(posedge clk)
        if(reset) currentState <= PAD_MESSAGE;
        else currentState <= nextState;
        
    // next state logic
    always_comb
        case(currentState)
            PAD_MESSAGE: nextState = MESSAGE_SCHEDULE;
            MESSAGE_SCHEDULE: nextState = C;
            C: nextState = D;
            D: nextState = E;
            E: nextState = PAD_MESSAGE;
            
        default: nextState = PAD_MESSAGE;
        endcase
        
    integer i;
    integer j = 511 - input_length;
    // output logic
    always_comb

        case(currentState)
            PAD_MESSAGE: begin
                // Initialize the padded message with all '0's
                padded_message = '0;
                                
                for(i=0;i<=1023;i=i+1) begin
                    if (binary_input[i]) begin
                        padded_message=binary_input[i+:1023];
                        break;
                    end
                end
                
                padded_message[input_length] = 1;
//put this back in a second
                if (multiples_of_512 == 2)             
                    padded_message = padded_message | input_length; // append length
                else begin
                    for(i=0;i<=9;i=i+1) begin
                        $display("input length here is %b", input_length[i]);
                        padded_message[511-9+i]=input_length[i];
                    end
                end
                
            end // PAD_MESSAGE

            default: begin
                padded_message = 1'b0;
            end
        endcase
endmodule
