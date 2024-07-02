from gpiozero import LED
from gpiozero import Button
import spidev
from time import sleep
from signal import pause
import sys 


print("sending reset")
reset = LED(27)
reset.on()
sleep(1)
reset.off()
sleep(1)

def hex_string_to_byte_array(hex_string):
    byte_array_string = []
    byte_array_hex = []
    
    i = 0
    while (i<190):
        byte_string = hex_string[i:i+2]
        byte_array_string.append(byte_string)
        i += 2

    
    for element in byte_array_string:
        hex_element = "0x" + element.upper()
        hex_element = int(hex_element,16)
        byte_array_hex.append(hex_element)
        
    return byte_array_hex
 
def hex_string_to_byte_array(hex_string):
    # Ensure the hex string length is even
    if len(hex_string) % 2 != 0:
        hex_string = '0' + hex_string
    
    # Convert the hex string to an array of bytes
    byte_array = [int(hex_string[i:i+2], 16) for i in range(0, len(hex_string), 2)]
    
    return byte_array

def stitch_hex_values(decimal_array):
    hex_string = ''.join([f'{value:02X}' for value in decimal_array])
    return hex_string

signal = Button(17, pull_up=False)
print("")
print("waiting for request")
while True:
    if signal.is_pressed:
        print("received request for block header")
        break
    else:
        print("signal not detedcted")
        sleep(1)
        
sleep(1)

print("")
print("sending block header")
spi = spidev.SpiDev()
spi.open(0, 0)
spi.max_speed_hz = 5000

#note: ila core will capture last elements in this array, not first.
to_send = hex_string_to_byte_array("7f10b95bfdbe17e5f6f0f4bfd0dd5f5cc2cc975f0987e4b21938372049cc9588" + "000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001e0")
print("sending: %s" %to_send)
#print("correct answer is 05b340abfc446570661f012f285b51910c3ac67ccb665842577be52c9eefb143")

#to_send = [0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17,0x17]

spi.xfer2(to_send)
print("finished sending block header")

print("")
print("waiting for double sha256")
while True:
    if signal.is_pressed:
        print("double sha256 complete! recieving result from fpga")
        break
    else:
        print("sha256 not complete...")
        sleep(1)
        
sleep(1)

to_send_hex = "0"*64
to_send = hex_string_to_byte_array(to_send_hex)
double_sha_256 = spi.xfer2(to_send)

print("recieved double sha256: ")
print(double_sha_256)

print("correct value is: ")
print("053a3987fb0c53a1c3121585052c8e05e1d5d77d40fe53235f78cd3b643b763b")

print("I got: ")
result = stitch_hex_values(double_sha_256)
print(result)
