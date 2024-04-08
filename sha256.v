module sha256 (
    input logic [0:9] input_length,
    input logic [0:1023] binary_input
    );
    logic [0:1023] padded_message;
    
    pad_bits pad_bits_instatiation(.input_length(input_length), . binary_input(binary_input), .padded_message(padded_message));
    
    always_comb
        $display("padded message is %h", padded_message);
     
endmodule
