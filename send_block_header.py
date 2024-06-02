from gpiozero import LED
from gpiozero import Button
import spidev
from time import sleep
from signal import pause

print("sending reset")
reset = LED(27)
reset.on()
sleep(1)
reset.off()
sleep(1)

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
to_send = [0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77]  
spi.xfer2(to_send)

print("finished sending block header")
