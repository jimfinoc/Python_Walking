import pygame

AQUA = (  0, 255, 255)
BLACK = (  0,   0,   0)
BLUE = (  0,  0, 255)
FUCHSIA = (255,   0, 255)
GRAY = (128, 128, 128)
GREEN = (  0, 128,   0)
LIME = (  0, 255,   0)
MAROON = (128,  0,   0)
NAVYBLUE = (  0,  0, 128)
OLIVE = (128, 128,   0)
PURPLE = (128,  0, 128)
RED = (255,   0,   0)
SILVER = (192, 192, 192)
TEAL = (  0, 128, 128)
WHITE = (255, 255, 255)
YELLOW = (255, 255,   0)

# This is a simple class that will help us print to the screen
# It has nothing to do with the joysticks, just outputting the
# information.
class TextPrint():
    # global screen
    def __init__(self,screen):
        x = 10
        y = 10
        self.reset(x,y)
        self.screen = screen
        self.font = pygame.font.Font(None, 20)

    def printing(self, screen, textString):
        textBitmap = self.font.render(textString, True, BLACK)
        screen.blit(textBitmap, [self.x, self.y])
        self.y += self.line_height

    def reset(self,x,y):
        self.x = x
        self.y = y
        self.line_height = 15

    def indent(self):
        self.x += 10

    def unindent(self):
        self.x -= 10


def useJoystick(command,position,screen,textPrint,clock):
    # global testPrint
    # global screen
    # -------- Main Program Loop -----------
    done = False
    counter = 0
    while done==False:
        counter += 1

        # EVENT PROCESSING STEP
        for event in pygame.event.get(): # User did something
            if event.type == pygame.QUIT: # If user clicked close
                done=True # Flag that we are done so we exit this loop

            # Possible joystick actions: JOYAXISMOTION JOYBALLMOTION JOYBUTTONDOWN JOYBUTTONUP JOYHATMOTION
            if event.type == pygame.JOYBUTTONDOWN:
                print("Joystick button pressed.")
                # print
            if event.type == pygame.JOYBUTTONUP:
                print("Joystick button released.")
            if event.type == pygame.KEYDOWN:
                print("Key pressed.")
                # print
            if event.type == pygame.KEYUP:
                print("Key released.")


        # DRAWING STEP
        # First, clear the screen to white. Don't put other drawing commands
        # above this, or they will be erased with this command.
        screen.fill(WHITE)
        textPrint.reset(10,10)

        # Get count of joysticks
        joystick_count = pygame.joystick.get_count()

        textPrint.printing(screen, "Number of joysticks: {}".format(joystick_count) )
        textPrint.indent()

        textPrint.printing(screen, "Counter {}".format(counter) )
        textPrint.indent()

        pressed = pygame.key.get_pressed()
        # body move and turn
        move_key_body_up = 0
        move_key_body_down = 0
        move_key_body_left = 0
        move_key_body_right = 0

        move_joy_body_up_down = 0
        move_joy_body_left_right = 0

        turn_key_body_left = 0
        turn_key_body_right = 0
        turn_joy_body_left = 0
        turn_joy_body_right = 0

        # head move and turn
        move_key_head_up = 0
        move_key_head_down = 0
        move_joy_head_up_down = 0

        turn_key_head_left = 0
        turn_key_head_right = 0
        turn_joy_head_left_right = 0


        #move or turn the robot head
        if pressed[pygame.K_UP]:
            move_key_head_up = 1
        if pressed[pygame.K_DOWN]:
            move_key_head_down = -1
        if pressed[pygame.K_LEFT]:
            turn_key_head_left = -1
        if pressed[pygame.K_RIGHT]:
            turn_key_head_right = 1

        #move the robot body
        if pressed[pygame.K_w]:
            move_key_body_up = 1
        if pressed[pygame.K_s]:
            move_key_body_down = -1
        if pressed[pygame.K_a]:
            move_key_body_left = -1
        if pressed[pygame.K_d]:
            move_key_body_right = 1

        #turn the robot body
        if pressed[pygame.K_q]:
            turn_key_body_left = -1
        if pressed[pygame.K_e]:
            turn_key_body_right = 1

                        # elif i == 8:
                        #     if button == 1:
                        #         print "LB"
                        #         turn_joy_body_left = 1
                        #     else:
                        #         turn_joy_body_left = 0
                        # elif i == 9:
                        #     if button == 1:
                        #         print "RB"
                        #         turn_joy_body_right = -1
                        #     else:
                        #         turn_joy_body_right = 0


        # For each joystick:
        for i in range(joystick_count):
            joystick = pygame.joystick.Joystick(i)
            joystick.init()

            textPrint.printing(screen, "Joystick {}".format(i) )
            textPrint.indent()

            # Get the name from the OS for the controller/joystick
            name = joystick.get_name()
            textPrint.printing(screen, "Joystick name: {}".format(name) )

            # Usually axis run in pairs, up/down for one, and left/right for
            # the other.
            axes = joystick.get_numaxes()
            textPrint.printing(screen, "Number of axes: {}".format(axes) )
            textPrint.indent()

            for i in range( axes ):
                axis = joystick.get_axis( i )
                textPrint.printing(screen, "Axis {} value: {:>6.3f}".format(i, axis) )

                # if i == 5:
                    # print ("counter is ")
                    # print (counter
                    # print (axis)
                if i == 5 and axis > 0.99:
                    print ("Fire the main gun")
                if i == 1: # move robot forward or back
                    if axis < .3 and axis > -.3:
                        move_joy_body_up_down = 0
                    elif axis > .9:
                        move_joy_body_up_down = -3
                    elif axis > .7:
                        move_joy_body_up_down = -2
                    elif axis > .5:
                        move_joy_body_up_down = -1
                    elif axis < -.9:
                        move_joy_body_up_down = 3
                    elif axis < -.7:
                        move_joy_body_up_down = 2
                    elif axis < -.5:
                        move_joy_body_up_down = 1
                if i == 0: # move robot left or right
                    if axis < .3 and axis > -.3:
                        move_joy_body_left_right = 0
                    elif axis > .9:
                        move_joy_body_left_right = 3
                    elif axis > .7:
                         move_joy_body_left_right = 2
                    elif axis > .5:
                        move_joy_body_left_right = 1
                    elif axis < -.9:
                        move_joy_body_left_right = -3
                    elif axis < -.7:
                        move_joy_body_left_right = -2
                    elif axis < -.5:
                        move_joy_body_left_right = -1
                    check1 = .15
                    check2 = .30
                    check3 = .45
                    check4 = .60
                    check5 = .75
                    check6 = .9
                if i == 3: # move robot forward or back
                    if axis < check1 and axis > -check1:
                        move_joy_head_up_down = 0
                    elif axis > .9:
                        move_joy_head_up_down = -5
                    elif axis > .7:
                        move_joy_head_up_down = -3
                    elif axis > .5:
                        move_joy_head_up_down = -1
                    elif axis < -.9:
                        move_joy_head_up_down = 5
                    elif axis < -.7:
                        move_joy_head_up_down = 3
                    elif axis < -.5:
                        move_joy_head_up_down = 1

    if axis < check1 and axis > -check1:
        turn_joy_head_left_right = 0
    elif axis > check6:
        turn_joy_head_left_right = 15
    elif axis > check5:
        turn_joy_head_left_right = 4
    elif axis > check4:
        turn_joy_head_left_right = 1
    elif axis > check3:
        turn_joy_head_left_right = .5
    elif axis > check2:
        turn_joy_head_left_right = 0.1
    elif axis > check1:
        turn_joy_head_left_right = 0.05
    elif axis < -check6:
        turn_joy_head_left_right = -15
    elif axis < -check5:
        turn_joy_head_left_right = -4
    elif axis < -check4:
        turn_joy_head_left_right = -1
    elif axis < -check3:
        turn_joy_head_left_right = -.5
    elif axis < -check2:
        turn_joy_head_left_right = -0.1
    elif axis < -check1:
        turn_joy_head_left_right = -0.05


                if i == 2: # move robot left or right
                    if axis < check1 and axis > -check1:
                        turn_joy_head_left_right = 0
                    elif axis > check6:
                        turn_joy_head_left_right = 15
                    elif axis > check5:
                        turn_joy_head_left_right = 4
                    elif axis > check4:
                        turn_joy_head_left_right = 1
                    elif axis > check3:
                        turn_joy_head_left_right = .5
                    elif axis > check2:
                        turn_joy_head_left_right = 0.1
                    elif axis > check1:
                        turn_joy_head_left_right = 0.05
                    elif axis < -check6:
                        turn_joy_head_left_right = -15
                    elif axis < -check5:
                        turn_joy_head_left_right = -4
                    elif axis < -check4:
                        turn_joy_head_left_right = -1
                    elif axis < -check3:
                        turn_joy_head_left_right = -.5
                    elif axis < -check2:
                        turn_joy_head_left_right = -0.1
                    elif axis < -check1:
                        turn_joy_head_left_right = -0.05

            textPrint.unindent()

            buttons = joystick.get_numbuttons()
            textPrint.printing(screen, "Number of buttons: {}".format(buttons) )
            textPrint.indent()

            for i in range( buttons ):
                button = joystick.get_button( i )
                textPrint.printing(screen, "Button {:>2} value: {}".format(i,button) )
                if i == 0 and button == 1:
                    move_joy_body_up_down = 1
                elif i == 1 and button == 1:
                    move_joy_body_up_down = -1
                elif i == 2 and button == 1:
                    move_joy_body_left_right = -1
                elif i == 3 and button == 1:
                    move_joy_body_left_right = 1

                # elif i == 11 and button == 1:
                #     print "A"
                # elif i  == 12 and button == 1:
                #     print "B"
                # elif i == 13 and button == 1:
                #     print "X"
                # elif i == 14 and button == 1:
                #     print "Y"
                elif i == 8:
                    if button == 1:
                        print "LB"
                        turn_joy_body_left = -1
                elif i == 9:
                    if button == 1:
                        print "RB"
                        turn_joy_body_right = 1

            textPrint.unindent()

            # Hat switch. All or nothing for direction, not like joysticks.
            # Value comes back in an array.
            hats = joystick.get_numhats()
            textPrint.printing(screen, "Number of hats: {}".format(hats) )
            textPrint.indent()

            for i in range( hats ):
                hat = joystick.get_hat( i )
                textPrint.printing(screen, "Hat {} value: {}".format(i, str(hat)) )

            textPrint.unindent()
            textPrint.unindent()

        textPrint.reset(510,10)
        textPrint.printing(screen, "Command to be received.")
        textPrint.indent()

        command['dir_M_LR'] = move_key_body_left + move_key_body_right + move_joy_body_left_right
        command['dir_M_FB'] = move_key_body_up + move_key_body_down + move_joy_body_up_down
        command['dir_T_LR'] = turn_key_body_left + turn_key_body_right + turn_joy_body_left + turn_joy_body_right

        command['head_M_UD'] = move_key_head_up + move_key_head_down + move_joy_head_up_down
        command['head_T_LR'] = turn_key_head_left + turn_key_head_right + turn_joy_head_left_right

        # command['head_T_LR'] = turn_key_head_left + turn_key_head_right

        for k,v in command.iteritems():
            textPrint.printing(screen, "command contains {} value: {}".format(k, str(v)) )
        textPrint.unindent()
        textPrint.printing(screen, "Position of the motors are as follows.")
        textPrint.indent()
        for key in sorted(position.iterkeys()):
            textPrint.printing(screen, "position: {}".format(key))
            textPrint.indent()
            for k,v in position[key].iteritems():
                textPrint.printing(screen, "contains {} value: {}".format(k, str(v)) )
            textPrint.unindent()
        textPrint.unindent()

            # position = {'FR':{'x':0, 'y':0, 'z':0}, 'FL':{'x':0, 'y':0, 'z':0},'BR':{'x':0, 'y':0, 'z':0},'BL':{'x':0, 'y':0, 'z':0}, 'TU':{'LR':0, 'UD':0}}


        # kinematicsRepeat(command)

        # ALL CODE TO DRAW SHOULD GO ABOVE THIS COMMENT

        # Go ahead and update the screen with what we've drawn.
        pygame.display.flip()

        # Limit to 20 frames per second
        clock.tick(20)

# def moveRobot(position):
#
#     kinematics(pos,step,dir_M_FB, dir_M_LR, dir_T_LR, head_M_UD, head_T_LR)


if __name__== "__main__":
    # Define some colors
    # COLOR = RGB VALUES
    AQUA = (  0, 255, 255)
    BLACK = (  0,   0,   0)
    BLUE = (  0,  0, 255)
    FUCHSIA = (255,   0, 255)
    GRAY = (128, 128, 128)
    GREEN = (  0, 128,   0)
    LIME = (  0, 255,   0)
    MAROON = (128,  0,   0)
    NAVYBLUE = (  0,  0, 128)
    OLIVE = (128, 128,   0)
    PURPLE = (128,  0, 128)
    RED = (255,   0,   0)
    SILVER = (192, 192, 192)
    TEAL = (  0, 128, 128)
    WHITE = (255, 255, 255)
    YELLOW = (255, 255,   0)

    pygame.init()

    # Set the width and height of the screen [width,height]
    size = [500, 700]
    screen = pygame.display.set_mode(size)

    pygame.display.set_caption("Robot Controller")
    print ("This program is designed to use the Xbox 360 Wireless Receiver.")

    #Loop until the user clicks the close button.

    # Used to manage how fast the screen updates
    clock = pygame.time.Clock()

    # Initialize the joysticks
    pygame.joystick.init()

    # Get ready to print
    textPrint = TextPrint()

    command = {'dir_M_FB':0, 'dir_M_LR':0, 'dir_T_LR':0, 'head_M_UD':0, 'head_T_LR':0}

    useJoystick(command)


    # Close the window and quit.
    # If you forget this line, the program will 'hang'
    # on exit if running from IDLE.
    pygame.quit ()
