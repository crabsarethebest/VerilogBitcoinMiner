import sys

def pad_to_512(message: str):
    # determine length of string
    message_len = len(message)

    # must be 64 less than multiple of 512
    num_512s = 1
    while (num_512s * 512 - message_len < 64):
        num_512s += 1
    padded_message_width = num_512s * 512

    # pad message with a 1 and 0s
    message = message + '1' # pad message with 1
    while (len(message) < padded_message_width - 64):
        message += '0'

    # pad message with message length
    message_len_bin = format(message_len, 'b')
    while len(message_len_bin) < 64:
        message_len_bin = '0' + message_len_bin

    message = message + message_len_bin
    return message

def shift_binary_string(binary_string: str, amount: int):
    if len(binary_string) < amount:
        print('error: cannot shift by more than string length')
        sys.exit(1)

    # Backfill with zeros to the left
    shifted_string = '0' * amount + binary_string[:-amount]

    # Return the shifted string
    return shifted_string

def rotate_binary_string(binary_string: str, amount: int):
    # Calculate the effective rotation amount modulo the length of the string
    amount %= len(binary_string)

    # Rotate the binary string by slicing and concatenating
    rotated_string = binary_string[-amount:] + binary_string[:-amount]

    # Return the rotated string
    return rotated_string

def xor (binary_str1: str, binary_str2: str):
    if len(binary_str1) != len(binary_str2):
        print('error: must XOR values of equal length')
        sys.exit(0)

    xor_str = ''
    char_index = 0
    while char_index != len(binary_str1):
        if binary_str1[char_index] == '1' and binary_str2[char_index] == '0':
            xor_str += '1'
        elif binary_str1[char_index] == '0' and binary_str2[char_index] == '1':
            xor_str += '1'
        else:
            xor_str += '0'
        char_index += 1

    return xor_str
            
def add_binary_strings(bin_str1: str, bin_str2: str):
    # Convert binary strings to integers
    num1 = int(bin_str1, 2)
    num2 = int(bin_str2, 2)
    
    # Add the integers and take modulo 32
    result = (num1 + num2) % (2**32)
    
    # Convert the result back to a binary string
    result_binary = bin(result)[2:].zfill(32)
    
    return result_binary

def lower_sigma_template(bin_str: str, rot1: int, rot2: int, shift1: int):
    value1 = rotate_binary_string(bin_str, rot1)
    value2 = rotate_binary_string(bin_str, rot2)
    value3 = shift_binary_string(bin_str, shift1)
    return(xor(xor(value1, value2),value3))

def lower_sigma_zero(bin_str: str):
    return lower_sigma_template(bin_str, 7, 18, 3)

def lower_sigma_one(bin_str: str):
    return lower_sigma_template(bin_str, 17, 19, 10)

def upper_sigma_template(bin_str: str, rot1: int, rot2: int, rot3: int):
    value1 = rotate_binary_string(bin_str, rot1)
    value2 = rotate_binary_string(bin_str, rot2)
    value3 = rotate_binary_string(bin_str, rot3)
    return(xor(xor(value1, value2),value3))

def upper_sigma_zero(bin_str: str):
    return upper_sigma_template(2, 13, 22)

def upper_sigma_one(bin_str: str):
    return upper_sigma_template(6, 11, 25)

def choice(bin_str1: str, bin_str2: str, bin_str3: str):
    if not all(bit in '01' for bit in bin_str1) or not all(bit in '01' for bit in bin_str2) or not all(bit in '01' for bit in bin_str3):
        raise ValueError("Input strings must consist only of '0's and '1's.")
    
    if len(bin_str1) != len(bin_str2) or len(bin_str1) != len(bin_str3):
        raise ValueError("Input strings must be of equal length.")    

    choice_str = ''
    char_index = 0
    while char_index != len(bin_str1):
        if bin_str1[char_index] == '1':
            choice_str += bin_str2[char_index]
        elif bin_str1[char_index] == '0':
            choice_str += bin_str3[char_index]
        else:
            print("error: bin_str1 must only contain ones and zeroes")
            sys.exit(0)
        char_index += 1
    return choice_str

def majority(bin_str1: str, bin_str2: str, bin_str3: str):
    if not all(bit in '01' for bit in bin_str1) or not all(bit in '01' for bit in bin_str2) or not all(bit in '01' for bit in bin_str3):
        raise ValueError("Input strings must consist only of '0's and '1's.")
    
    if len(bin_str1) != len(bin_str2) or len(bin_str1) != len(bin_str3):
        raise ValueError("Input strings must be of equal length.")
    
    maj_str = ''
    char_index = 0

    while char_index != len(bin_str1):
        num_ones = 0
        num_zeroes = 0
        if bin_str1[char_index] == '1':
            num_ones += 1
        else:
            num_zeroes += 1

        if bin_str2[char_index] == '1':
            num_ones += 1
        else:
            num_zeroes += 1

        if bin_str3[char_index] == '1':
            num_ones += 1
        else:
            num_zeroes += 1
        
        if num_ones > num_zeroes:
            maj_str += '1'
        else:
            maj_str += '0'
        
        char_index += 1
    
    return maj_str




if __name__ == "__main__":
    input = 'abc'
    input_binary = ''.join(format(ord(char), '08b') for char in input) # convert input to binary
    pad_to_512(input_binary)

    
