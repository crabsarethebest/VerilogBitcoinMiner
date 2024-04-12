package bit_select_functions;

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/11/2024 10:47:54 PM
// Design Name: 
// Module Name: bit_select_functions
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

function logic [0:31] choice(logic [0:31] word_A, logic [0:31] word_B, logic [0:31] word_C);
    logic [0:31] choice_output;
    
    for (int i = 0; i <= 31; i++) begin
        if (word_A[i] == 1'b1)
            choice_output[i] = word_B[i];    
        else
            choice_output[i] = word_C[i];        
    end
    
    return choice_output;
endfunction

function logic [0:31] majority(logic [0:31] word_A, logic [0:31] word_B, logic [0:31] word_C);
    int num_zeroes = 0;
    int num_ones = 0;
    logic [0:31] majority_output;
    
    for (int i = 0; i <= 31; i++) begin
        if (word_A[i] == 1'b1)
            num_ones ++;
        else
            num_zeroes ++;
            
        if (word_B[i] == 1'b1)
            num_ones ++;
        else
            num_zeroes ++;
            
        if (word_C[i] == 1'b1)
            num_ones ++;
        else
            num_zeroes ++;   
            
        if (num_ones > num_zeroes)
            majority_output[i] = 1'b1;
        else
            majority_output[i] = 1'b0;       
    end
            
    return majority_output;
endfunction

endpackage