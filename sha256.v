`include "sha256_constants.sv"
module sha256 (
    input logic [0:9] input_length,
    input logic [0:1023] binary_input
    );
    logic [0:1023] padded_message;
    
    pad_bits pad_bits_instatiation(.input_length(input_length), . binary_input(binary_input), .padded_message(padded_message));
    
    logic [0:31] message_schedule_lower_array [0:63];
    logic [0:31] message_schedule_upper_array [0:63];
    message_schedule message_schedule_lower(.message_block(padded_message[0:511]), .message_schedule(message_schedule_lower_array));
    message_schedule message_schedule_upper(.message_block(padded_message[512:1023]), .message_schedule(message_schedule_upper_array));
    
    logic [0:31] a_lower, b_lower, c_lower, d_lower, e_lower, f_lower, g_lower, h_lower;
    logic [0:31] a_upper, b_upper, c_upper, d_upper, e_upper, f_upper, g_upper, h_upper;
    hash_constants hash_constants_lower(
                                        .message_schedule(message_schedule_lower_array),
                                        .a_in(sha256_constants::h_constants[0]),
                                        .b_in(sha256_constants::h_constants[1]),
                                        .c_in(sha256_constants::h_constants[2]),
                                        .d_in(sha256_constants::h_constants[3]),
                                        .e_in(sha256_constants::h_constants[4]),
                                        .f_in(sha256_constants::h_constants[5]),
                                        .g_in(sha256_constants::h_constants[6]),
                                        .h_in(sha256_constants::h_constants[7]),      
                                        .a_out(a_lower),
                                        .b_out(b_lower),
                                        .c_out(c_lower),
                                        .d_out(d_lower),
                                        .e_out(e_lower),
                                        .f_out(f_lower),
                                        .g_out(g_lower),
                                        .h_out(h_lower)
                                        
    );
    
    hash_constants hash_constants_upper(); // still needs to be done
    
    always_comb
        $display("padded message is %h", padded_message);
     
endmodule
