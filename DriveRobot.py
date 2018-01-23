import pygame
import RobotControlling
import RobotKinematics
# import RobotCommunications
import JoystickController
import time
import math
import threading

# position
command = {'dir_M_FB':0, 'dir_M_LR':0, 'dir_T_LR':0, 'head_M_UD':0, 'head_T_LR':0}


def kinematicsRepeat(command, position):
# position = {'FR':{'x':0, 'y':0, 'z':0}, 'FL':{'x':0, 'y':0, 'z':0},'BR':{'x':0, 'y':0, 'z':0},'BL':{'x':0, 'y':0, 'z':0}, 'TU':{'LR':0, 'UD':0}}
    timer = 0
    realstep = 0
    done = False
    startTime = time.time()
    while command['done'] == False:
        # print realstep, command
        timer += 1

        # print position
        dir_M_FB  = command['dir_M_FB']
        dir_M_LR  = command['dir_M_LR']
        dir_T_LR  = command['dir_T_LR']
        head_M_UD = command['head_M_UD']
        head_T_LR = command['head_T_LR']

        try:
            if robotCalculating.isAlive():
                pass
            else:
                robotCalculating = threading.Thread(name="calculating", target=RobotKinematics.kinematics,args=(position,realstep,dir_M_FB, dir_M_LR, dir_T_LR, head_M_UD, head_T_LR,))
                robotCalculating.start()
                realstep += 1

        except:
            robotCalculating = threading.Thread(name="calculating", target=RobotKinematics.kinematics,args=(position,realstep,dir_M_FB, dir_M_LR, dir_T_LR, head_M_UD, head_T_LR,))
            robotCalculating.start()
            realstep += 1


        # print realstep
        # RobotKinematics.kinematics(position,realstep,dir_M_FB, dir_M_LR, dir_T_LR, head_M_UD, head_T_LR)
        # if timer > 1000000:
        #     done=True
    print "The loop ran for {} seconds: ".format(time.time()-startTime)
    print timer

def motorsRepeat(command, position):
# position = {'FR':{'x':0, 'y':0, 'z':0}, 'FL':{'x':0, 'y':0, 'z':0},'BR':{'x':0, 'y':0, 'z':0},'BL':{'x':0, 'y':0, 'z':0}, 'TU':{'LR':0, 'UD':0}}
    # timer = 0
    # realstep = 0
    # done = False
    startTime = time.time()
    while command['done'] == False:
        # print realstep, command
        # timer += 1

        # print position

        try:
            if robotMoving.isAlive():
                pass
            else:
                robotMoving = threading.Thread(name="moving", target=RobotControlling.goToPosition,args=(position,))
                robotMoving.start()
                # realstep += 1

        except:
            robotMoving = threading.Thread(name="moving", target=RobotControlling.goToPosition,args=(position,))
            robotMoving.start()
            # realstep += 1


        # print realstep
        # RobotKinematics.kinematics(position,realstep,dir_M_FB, dir_M_LR, dir_T_LR, head_M_UD, head_T_LR)
        # if timer > 1000000:
        #     done=True
    # print "The loop ran for {} seconds: ".format(time.time()-startTime)
    # print timer

if __name__== "__main__":
    # Define some colors
    # COLOR = RGB VALUES
    position = {'FR':{'x':0, 'y':0, 'z':0}, 'FL':{'x':0, 'y':0, 'z':0},'BR':{'x':0, 'y':0, 'z':0},'BL':{'x':0, 'y':0, 'z':0}, 'TU':{'LR':0.0, 'UD':0.0}}

    pygame.init()

    # Set the width and height of the screen [width,height]
    size = [1000, 700]
    screen = pygame.display.set_mode(size)

    pygame.display.set_caption("Robot Controller")
    print ("This program is designed to use the Xbox 360 Wireless Receiver.")

    #Loop until the user clicks the close button.

    # Used to manage how fast the screen updates
    clock = pygame.time.Clock()

    # Initialize the joysticks
    pygame.joystick.init()

    # Get ready to print
    textPrint = JoystickController.TextPrint(screen)

    realstep = 0
    dir_M_FB = 0
    dir_M_LR = 0
    dir_T_LR = 0
    head_M_UD = 0
    head_T_LR = 0

    command['done'] = False

    command['dir_M_FB'] = dir_M_FB
    command['dir_M_LR'] = dir_M_FB
    command['dir_T_LR'] = dir_T_LR
    command['head_M_UD'] =head_M_UD
    command['head_T_LR'] = head_T_LR

    # controller = threading.Thread(name='controller',target=JoystickController.useJoystick, args=(command,screen,textPrint,clock,))

    kinematicsDriver = threading.Thread(name='kinematicsDriver',target=kinematicsRepeat, args=(command,position,))
    # kinematicsRepeat(command) #position,realstep,command_legs,command_turret)
    motorDriver = threading.Thread(name='motorDriver',target=motorsRepeat, args=(command,position,))

    # controller.start()
    kinematicsDriver.start()
    motorDriver.start()
    # controller.join()

    JoystickController.useJoystick(command,position,screen,textPrint,clock)
    command['done'] = True
    motorDriver.join()
    kinematicsDriver.join()


    # thread 1
        # get input
        # update dictionary
    # thread 2
        # process kinematics
    # thread 3
        # send kinematics to robot motors
