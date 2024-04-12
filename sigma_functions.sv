package sigma_functions;

function logic [0:31] lower_sigma_zero(logic [0:31] bits);
    logic [0:31] rotate_right_7;
    logic [0:31] rotate_right_18;
    logic [0:31] shift_right_3;
    logic [0:31] xor_intermediate;
    logic [0:31] lower_sigma_zero_output;

    rotate_right_7 = (bits >> 7) | (bits << (32-7));
    rotate_right_18 = (bits >> 18) | (bits << (32 - 18));
    shift_right_3 = bits >> 3;
    
    xor_intermediate = rotate_right_7 ^ rotate_right_18;
    lower_sigma_zero_output = xor_intermediate ^ shift_right_3;    
       
    return lower_sigma_zero_output;   
endfunction

function logic [0:31] lower_sigma_one(logic [0:31] bits);
    logic [0:31] rotate_right_17;
    logic [0:31] rotate_right_19;
    logic [0:31] shift_right_10;
    logic [0:31] xor_intermediate;
    logic [0:31] lower_sigma_one_output;

    rotate_right_17 = (bits >> 17) | (bits << (32-17));
    rotate_right_19 = (bits >> 19) | (bits << (32 - 19));
    shift_right_10 = bits >> 10;
    
    xor_intermediate = rotate_right_17 ^ rotate_right_19;
    lower_sigma_one_output = xor_intermediate ^ shift_right_10;    
       
    return lower_sigma_one_output;   
endfunction

function logic [0:31] upper_sigma_zero(logic [0:31] bits);
    logic [0:31] rotate_right_2;
    logic [0:31] rotate_right_13;
    logic [0:31] rotate_right_22;
    logic [0:31] xor_intermediate;
    logic [0:31] upper_sigma_zero_output;

    rotate_right_2 = (bits >> 2) | (bits << (32-2));
    rotate_right_13 = (bits >> 13) | (bits << (32 - 13));
    rotate_right_22 = (bits >> 22) | (bits << (32 - 22));
    
    xor_intermediate = rotate_right_2 ^ rotate_right_13;
    upper_sigma_zero_output = xor_intermediate ^ rotate_right_22;    
       
    return upper_sigma_zero_output;   
endfunction

function logic [0:31] upper_sigma_one(logic [0:31] bits);
    logic [0:31] rotate_right_6;
    logic [0:31] rotate_right_11;
    logic [0:31] rotate_right_25;
    logic [0:31] xor_intermediate;
    logic [0:31] upper_sigma_one_output;

    rotate_right_6 = (bits >> 6) | (bits << (32-6));
    rotate_right_11 = (bits >> 11) | (bits << (32 - 11));
    rotate_right_25 = (bits >> 25) | (bits << (32 - 25));
    
    xor_intermediate = rotate_right_6 ^ rotate_right_11;
    upper_sigma_one_output = xor_intermediate ^ rotate_right_25;    
       
    return upper_sigma_one_output;   
endfunction

endpackage
