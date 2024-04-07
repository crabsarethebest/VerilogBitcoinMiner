module sha256 (
    input logic clk,
    input logic reset,
    input integer bits_width,
    input logic [1023: 0] bits
    );

    integer padded_message_width;
    logic [1023:0] padded_message;
    
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
        
    // output logic
    always_comb
        case(currentState)
            SPLIT_MESSAGE: begin
                padded_message = bits | (1 << (int'(bits_width)));
                padded_message = padded_message | (bits_width << 50);  // TODO: FIX this to non-default 50
            end

            default: begin
                padded_message = 1'b0;
            end
        endcase
endmodule
