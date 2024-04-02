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
            

if __name__ == "__main__":
    input = 'abc'
    input_binary = ''.join(format(ord(char), '08b') for char in input) # convert input to binary
#    pad_to_512(input_binary)
    xor_str = xor('10011', '00011')
    print(xor_str)