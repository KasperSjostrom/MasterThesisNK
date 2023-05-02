#UART COMMUNICATION BETWEEN TWO RPI 3B+ BASED ON CODEEXAMPLE FROM ELECTRONICWINGS.COM


import keyboard
import serial
import binascii
from time import sleep

ser = serial.Serial("/dev/ttyS0",1843200) #Opens serialport with wanted baud rate
binmessage=b'Z'

while True:
    if keyboard.is_pressed('Q'):
        binmessage=b'A'
    if keyboard.is_pressed('C'):
        binmessage=b'C'
    if keyboard.is_pressed('O'):
        binmessage=b'O'
    if keyboard.is_pressed('U'):
        binmessage=b'U'
    if keyboard.is_pressed('Z'):
        binmessage=b'Z'
   
    sleep(0.00003)
    ser.write(binmessage) # transmit data
    print(binmessage)