`include "sha256_constants.sv"
module sha256 (
    input logic [0:9] input_length,
    input logic [0:1023] binary_input,
    output logic led_out
    );
    
    integer multiples_of_512_output;
    logic [0:1023] padded_message;
    
    pad_bits pad_bits_instatiation(.input_length(input_length), . binary_input(binary_input), .multiples_of_512_output(multiples_of_512_output), .padded_message(padded_message));
    
    logic [0:31] message_schedule_lower_array [0:63];
    logic [0:31] message_schedule_upper_array [0:63];
    message_schedule message_schedule_lower(.message_block(padded_message[0:511]), .message_schedule(message_schedule_lower_array));
    message_schedule message_schedule_upper(.message_block(padded_message[512:1023]), .message_schedule(message_schedule_upper_array));
    
    logic [0:31] a_lower, b_lower, c_lower, d_lower, e_lower, f_lower, g_lower, h_lower;
    logic [0:31] a_upper, b_upper, c_upper, d_upper, e_upper, f_upper, g_upper, h_upper;
    logic [0:255] hash_out_lower, hash_out_upper, final_hash;
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
                                        .h_out(h_lower),
                                        .hash_out(hash_out_lower)                                   
    );
    
    hash_constants hash_constants_upper(
                                        .message_schedule(message_schedule_upper_array),
                                        .a_in(a_lower),
                                        .b_in(b_lower),
                                        .c_in(c_lower),
                                        .d_in(d_lower),
                                        .e_in(e_lower),
                                        .f_in(f_lower),
                                        .g_in(g_lower),
                                        .h_in(h_lower),      
                                        .a_out(a_upper),
                                        .b_out(b_upper),
                                        .c_out(c_upper),
                                        .d_out(d_upper),
                                        .e_out(e_upper),
                                        .f_out(f_upper),
                                        .g_out(g_upper),
                                        .h_out(h_upper),
                                        .hash_out(hash_out_upper)    
    );
    
    always_comb begin
        if (multiples_of_512_output == 1) begin
            final_hash = hash_out_lower;
        end
        if (multiples_of_512_output == 2) begin
            final_hash = hash_out_upper;
        end
        
        if (final_hash[0] == 1'b1) begin
            led_out = 1'b1;
        end else begin
            led_out = 1'b0;
        end
        
    end   
     
endmodule
