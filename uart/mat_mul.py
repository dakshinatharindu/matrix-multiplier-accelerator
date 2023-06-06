import serial
from time import sleep

# Open serial port
ser = serial.Serial("/dev/ttyUSB1", 115200)


# Read data from serial port
def read_data():
    arr = []

    for i in range(4):
        received_byte = ser.read(4)
        int_val = int.from_bytes(received_byte, "little")
        arr.append(int_val)

    return arr


# Send data to serial port
def send_data(data):
    for i in range(4):
        ser.write(data[i].to_bytes(4, "little"))

def mat_mul(A, B):
    send_data(A)
    send_data(B)
    arr = read_data()
    return arr


A = [1, 2, 3, 4]
B = [5, 6, 7, 8]
C = mat_mul(A, B)

# Print result
for i in range(2):
    for j in range(2):
        print(C[i*2 + j], end=" ")
    print()



    
