from gpiozero import LED
from gpiozero import Button
import spidev
from time import sleep
#from signal import pause



# def signal_high():
#     print("signal went high")

# button.when_pressed = signal_high
# pause()

button = Button(17)
button.wait_for_press()
print("Received request for block header.")
print("Sending block header")

spi = spidev.SpiDev()
spi.open(0, 0)
spi.max_speed_hz = 5000
to_send = [0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77,0x77]  
spi.xfer2(to_send)




# yellow = LED(27)
# yellow.on()
# sleep(5)
# sleep(1)
# red.off()
# sleep(1)
# red.on()
# sleep(1)
# red.off()
# sleep(1)
# red.on()
# sleep(1)
# red.off()
# sleep(1)
# red.on()
# sleep(1)
# red.off()
# sleep(1)
# red.on()
# sleep(1)
# red.off()
# sleep(1)
# red.on()
# sleep(1)
# red.off()
# sleep(1)
# red.on()
# sleep(1)
# red.off()
