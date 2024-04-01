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

if __name__ == "__main__":
    input = 'abc'
    input_binary = ''.join(format(ord(char), '08b') for char in input) # convert input to binary
    pad_to_512(input_binary)