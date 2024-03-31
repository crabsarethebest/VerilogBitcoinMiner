from dateutil import parser, tz
from hashlib import sha256
import pandas as pd
import numpy as np

def unix_time(time: str, utc: bool=True):
    '''Accepts time as a string and returns unix time.'''
    t = parser.parse(time)
    if utc:
        t = t.replace(tzinfo=tz.gettz('UTC')) # if the time is in UTC, set the timezone
    return '{0:08x}'.format(int(t.timestamp()))

def little_endian(hexa: str):
    '''Returns an integer corresponding to little endian representation '''
    return int.from_bytes(bytearray.fromhex(hexa.replace('0x', '')), byteorder='little')

def block_header_generator(version, prev_block_hash, merkle_root, time, bits, utc):
    '''Generates the block header'''
    version_hex = '{0:08x}'.format(little_endian(version))
    prev_hash_hex = '{0:064x}'.format(little_endian(prev_block_hash))
    merkle_hex = '{0:064x}'.format(little_endian(merkle_root))
    time_hex = '{0:08x}'.format(little_endian(unix_time(time, utc)))
    bits_hex = '{0:08x}'.format(little_endian('{0:08x}'.format(bits)))
    header = [version_hex, prev_hash_hex, merkle_hex, time_hex, bits_hex]

    return ''.join(header)

 
def target_cal(bits: int):
    '''
    In Bitcoin, the "bits" field is a representation of the target threshold for proof-of-work mining in a block header. It is a compact way of encoding the difficulty target for miners to meet in order to successfully mine a block.

Here's how it works:

Target Difficulty: In Bitcoin mining, miners are required to find a hash value that is lower than a certain target value. This target value determines the difficulty of mining and is adjusted periodically by the network to maintain an average block generation time of approximately 10 minutes.

Compact Representation: The "bits" field in the block header provides a compact representation of this target difficulty. It is a 4-byte (32-bit) integer value that encodes both the target and the number of leading zero bits required in the resulting hash.

Conversion: The 32-bit value is divided into two parts:

The first byte (8 bits) represents the exponent of a base-256 number.
The remaining three bytes (24 bits) represent the coefficient of the same base-256 number.
The actual target is calculated as follows:

target = coefficient * 256^(exponent - 3).
Difficulty Adjustment: Miners use the target value encoded in the "bits" field to determine the level of difficulty required for their hash value to be considered valid. If the hash of the block header is lower than the target value, the block is considered mined.
    '''

    h = '{0:08x}'.format(bits)
    return int(h[2:], 16) * (256 ** (int(h[:2], 16) - 3))


def mine(b_version, b_prev_hash, b_merkle, b_time, b_bits, near_value, utc=True):
    ''''Performs the process of mining.'''

    nonce = near_value # for speeding up the process
    target = target_cal(b_bits)
    b = block_header_generator(b_version, b_prev_hash, b_merkle, b_time, b_bits, utc)
    while True:
        nonce_little = '{0:08x}'.format(little_endian('{0:08x}'.format(nonce)))
        header = b + nonce_little
        first_hash = sha256(bytes.fromhex(header)) # needs byte 
        second_hash = sha256(first_hash.digest()).hexdigest()
        result = int.from_bytes(bytearray.fromhex(second_hash), 'little')
        if result < target:
            print('Block Mined!', 'Nonce : ', nonce, sep='\n')
            print('hash : ', '{0:064x}'.format(result), sep='\n')
            break
        nonce += 1

def mine_block_num(number):
    '''Given a block number it will mine that block'''
    b_version = '{0:08x}'.format(df.loc[number, 'version']) # get bitcoin version
    if number == 0:
        b_prev_hash = '00'
    else:
        b_prev_hash = df.loc[number -1, 'hash'] # get previous hash
    b_merkle = df.loc[number, 'merkle_root'] # get merkle root
    b_time = df.loc[number, 'time'] # get time
    b_bits = df.loc[number, 'bits'] # get bits
    nonce = df.loc[number, 'nonce'] # get nonce to cacluate near value

    # caculate near value
    if nonce > 2e6 :
        near_value = np.random.randint(nonce - 2e6, nonce - 1e6, dtype='int64')
    else:
        near_value = np.random.randint(1, nonce, dtype='int64')
    return mine(b_version, b_prev_hash, b_merkle, b_time, b_bits, near_value)

if __name__ == "__main__":
    df = pd.read_csv('blockdata.txt', usecols=['id', 'hash', 'time', 'version', 'merkle_root', 'nonce', 'bits', 'difficulty'])
    pd.options.display.max_colwidth = 100
    mine_block_num(245001)