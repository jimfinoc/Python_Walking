import time
print "initializing program",
print time.time()
from pydynamixel import dynamixel, registers
# You'll need to change this to the serial port of your USB2Dynamixel
try:
    serial_port = '/dev/tty.usbserial-AI0283E0'
    print 'device found at', serial_port
except:
    print "I cannot see ", serial_port

# You'll need to modify these for your setup
servo_id1 = 1
servo_id2 = 2
# target_position = 512 # (range: 0 to 1023)

# If this is the first time the robot was powered on,
# you'll need to read and set the current position.
# (See the documentation above.)
first_move = True
# first_move = False

# try:
#     ser = dynamixel.get_serial_for_url(serial_port)
#     if first_move == True:
#         dynamixel.init(ser, servo_id)
#     dynamixel.set_position(ser, servo_id, target_position)
#     dynamixel.send_action_packet(ser)
#     print('Success!')
# except Exception as e:
# 	print('Unable to move to desired position.')
# 	print(e)


sleep_time = 5
velocity = 10# very slow, 25.611 seconds
velocity = 100# slow, 4.266 seconds
velocity = 0x20#  speed, 8.31 seconds

target_position0 = 512 # (range: 0 to 1023)
target_position1 = 1023-200 # (range: 0 to 1023)
target_position2 = 0+300 # (range: 0 to 1023)

def goToPosition(position):
    servo_id1 = 1
    servo_id2 = 2
    try:
        ser = dynamixel.get_serial_for_url(serial_port)
    except:
        print "failed to get motor driver"
        print
    velocity = 1# slow, 4.266 seconds

    dynamixel.set_position(ser, servo_id2, int(position['TU']['LR']*1.0*1023/360+512))
    dynamixel.set_position(ser, servo_id1, int(position['TU']['UD']*1.0*1023/360+512))
    dynamixel.send_action_packet(ser)
    while dynamixel.get_is_moving(ser, servo_id1) == True:
        velocity += velocity
        dynamixel.set_velocity(ser, servo_id2, velocity)
        dynamixel.set_velocity(ser, servo_id1, velocity)
        dynamixel.send_action_packet(ser)



# led_value = dynamixel.registers.LED_STATE.ON
# try:
#     print(registers)
# except:
#     print ("I can't print registers")
#
# try:
#     print "initializing motor",
#     # print registers.PRESENT_SPEED
#
#     start_time = time.time()
#     print start_time
#     ser = dynamixel.get_serial_for_url(serial_port)
#     if first_move == True:
#         dynamixel.init(ser, servo_id1)
#     dynamixel.set_led(ser, servo_id2, registers.LED_STATE.ON)
#     # print "time before pause",
#     print time.time()
#     # user = raw_input("press enter to continue")
#     # print "time after return",
#     print time.time()
#
#     # Position 0
#     print "time before position 0",
#     print time.time()
#     dynamixel.set_position(ser, servo_id1, target_position0)
#     dynamixel.set_velocity(ser, servo_id1, velocity)
#     dynamixel.send_action_packet(ser)
#     # time.sleep(sleep_time)
#     while True:
#         if dynamixel.get_is_moving(ser, servo_id1) == False:
#             break
#
#     # Position 1
#     print "time before position 1",
#     print time.time()
#     dynamixel.set_position(ser, servo_id1, target_position1)
#     dynamixel.send_action_packet(ser)
#     # time.sleep(sleep_time)
#     while True:
#         if dynamixel.get_is_moving(ser, servo_id1) == False:
#             break
#     # Position 2
#     print "time before position 2",
#     print time.time()
#     dynamixel.set_position(ser, servo_id1, target_position2)
#     dynamixel.send_action_packet(ser)
#     # time.sleep(sleep_time)
#     while True:
#         print dynamixel.get_position(ser,servo_id1),
#         print dynamixel.get_torque(ser,servo_id1),
#         print dynamixel.get_position(ser,servo_id2),
#         print dynamixel.get_torque(ser,servo_id2),
#         print " "
#         if dynamixel.get_is_moving(ser, servo_id1) == False:
#             break
#     # Position 0
#     print "time before position 0, the second time",
#     print time.time()
#     dynamixel.set_position(ser, servo_id1, target_position0)
#     dynamixel.send_action_packet(ser)
#
#     while True:
#         if dynamixel.get_is_moving(ser, servo_id1) == False:
#             break
#     print "time of led off",
#
#     dynamixel.set_led(ser, servo_id2, registers.LED_STATE.OFF)
#
#     finish_time = time.time()
#     print finish_time
#     print('Success!')
#     print ("total time"),
#     print finish_time - start_time
#
# except Exception as e:
# 	print('Unable to move to desired position.')
# 	print(e)
