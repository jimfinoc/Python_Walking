import Tkinter as tk
import os
import math
import pygame

# import pygame
# import pygame.mixer
#
# import pygame
# from pygame.locals import *
#
# pygame.init()

#
# try:
# 	j = pygame.joystick.Joystick(0) # create a joystick instance
# 	j.init() # init instance
# 	print('Enabled joystick: ' + j.get_name())
# except pygame.error:
# 	print('No joystick found.')

# import sys
# import select
#
# def heardEnter():
#     i,o,e = select.select([sys.stdin],[],[],0.0001)
#     for s in i:
#         if s == sys.stdin:
#             input = sys.stdin.read(1)
#             if input == "1":
#                 print ("one")
#                 sys.stdin.flush()
#             return True
#     return False




# pygame.joystick.init()
# if pygame.joystick.get_init():
#     print(True)
# else:
#     print(False)
# print (pygame.joystick.get_count())
# pygame.joystick.Joystick.init()

root=tk.Tk()
# root.lift()
root.attributes('-topmost',True)
root.after_idle(root.attributes,'-topmost',False)
# app=FullScreenApp(root)

# print "root.winfo_screenwidth()",
# print root.winfo_screenwidth()
#
# print "root.winfo_screenheight()",
# print root.winfo_screenheight()
#
# print "root.winfo_width()",
# print root.winfo_width()
#
# print "root.winfo_height()",
# print root.winfo_height()
#
# print root.geometry()
x = 200
y = 200
canvas = tk.Canvas(root, width=400, height=400)
canvas.pack()

position = []
LB = 0
LF = 1
RF = 2
RB = 3
xVar = 0
yVar = 1
zVar = 2
lineCounter = 0
step = {}
legUp = 0
legWalk1 = 1
legWalk2 = 2
legWalk3 = 3
legWalk4 = 4
legWalk5 = 5
legWalk6 = 6
legWalk7 = 7

legLeft = 11
legRight = 17

# step[LB] = [ (stepX+2)%8 ,(stepY+2)%8]
# step[LF] = [ (stepX+0)%8 ,(stepY+0)%8]
# step[RF] = [ (stepX+4)%8 ,(stepY+4)%8]
# step[RB] = [ (stepX+6)%8 ,(stepY+6)%8]

stepX = 0
stepY = 0

step[LB] = [ (stepX+2)%8 ,0]
step[LF] = [ (stepX+0)%8 ,0]
step[RF] = [ (stepX+4)%8 ,0]
step[RB] = [ (stepX+6)%8 ,0]


centerOfRobot = ([-1,-1],[-1,1],[1,1],[1,-1])
box = ([-50,-50],[-50,50],[50,50],[50,-50])
base = ([-45,-45],[-45,45],[45,45],[45,-45])

# footRF = ([ 20, 0,1],[ 20, 15,0],[ 20, 10,0],[ 20, 5,0],[ 20, 0,0],[ 20, -5,0],[ 20, -10,0],[ 20, -15,0],[],[])
footTable = dict()
footTable[legUp] = dict()
footTable[legUp][RF]  = ([ 20, 0, 1])
# footTable[legUp][LF]  = [-20, 0, 1]
# footTable[legUp][RB]  = [ 20, 0, 1]
# footTable[legUp][LB]  = [-20, 0, 1]
footTable[legWalk1] = dict()
footTable[legWalk1][RF]  = ([ 23, 15, 0])
footTable[legWalk2] = dict()
footTable[legWalk2][RF]  = ([ 22, 10, 0])
footTable[legWalk3] = dict()
footTable[legWalk3][RF]  = ([ 21, 5, 0])
footTable[legWalk4] = dict()
footTable[legWalk4][RF]  = ([ 20, 0, 0])
footTable[legWalk5] = dict()
footTable[legWalk5][RF]  = ([ 19, -5, 0])
footTable[legWalk6] = dict()
footTable[legWalk6][RF]  = ([ 18, -10, 0])
footTable[legWalk7] = dict()
footTable[legWalk7][RF]  = ([ 17, -15, 0])

footTable[legUp][LF]  = ([ -20, 0, 1])
footTable[legWalk1][LF]  = ([ -17, 15, 0])
footTable[legWalk2][LF]  = ([ -18, 10, 0])
footTable[legWalk3][LF]  = ([ -19, 5, 0])
footTable[legWalk4][LF]  = ([ -20, 0, 0])
footTable[legWalk5][LF]  = ([ -21, -5, 0])
footTable[legWalk6][LF]  = ([ -22, -10, 0])
footTable[legWalk7][LF]  = ([ -23, -15, 0])

footTable[legUp][LB]  = ([ -20, 0, 1])
footTable[legWalk1][LB]  = ([ -17, 15, 0])
footTable[legWalk2][LB]  = ([ -18, 10, 0])
footTable[legWalk3][LB]  = ([ -19, 5, 0])
footTable[legWalk4][LB]  = ([ -20, 0, 0])
footTable[legWalk5][LB]  = ([ -21, -5, 0])
footTable[legWalk6][LB]  = ([ -22, -10, 0])
footTable[legWalk7][LB]  = ([ -23, -15, 0])

footTable[legUp][RB]  = ([ -20, 0, 1])
footTable[legWalk1][RB]  = ([ -17, 15, 0])
footTable[legWalk2][RB]  = ([ -18, 10, 0])
footTable[legWalk3][RB]  = ([ -19, 5, 0])
footTable[legWalk4][RB]  = ([ -20, 0, 0])
footTable[legWalk5][RB]  = ([ -21, -5, 0])
footTable[legWalk6][RB]  = ([ -22, -10, 0])
footTable[legWalk7][RB]  = ([ -23, -15, 0])

footTable[legWalk1][RB]  = ([ 23, 15, 0])
footTable[legWalk2][RB]  = ([ 22, 10, 0])
footTable[legWalk3][RB]  = ([ 21, 5, 0])
footTable[legWalk4][RB]  = ([ 20, 0, 0])
footTable[legWalk5][RB]  = ([ 19, -5, 0])
footTable[legWalk6][RB]  = ([ 18, -10, 0])
footTable[legWalk7][RB]  = ([ 17, -15, 0])

# (
#     # first,0 is the step offset, then,1 is the first limit, then,7 is the other bound
#     [#run motion step of 5
#         # [ 0,5,0],[ 0, 15,0],[],[],[],[],[],[ 20, -15,0],[],[],
#     ],
#     [#walk motion
#         [0,0,1],[ 0, 3,0],[],[],[],[],[],[ 20, -3,0],[],[],
#     ],
#     [#lateral motion
#         [ 0,0,1],[ 3,  0,0],[],[],[],[],[],[ -3,   0,0],[],[]
#     ],[#turning motion
#         [0,0,1],[0,0,0]
#     ]
#     )
#initial positions of the feed
# foot = ([-20,0,0],[-20,0,0],[20,0,0],[20,0,0])
foot = {}
foot[LB] = [-20,0,0]
foot[LF] = [-20,0,0]
foot[RF] = ([20,0,0])
foot[RB] = [20,0,0]

# foot[LB] = [1,-1,1]
# foot[LF] = [1,1,1]
# foot[RF] = [-1,1,1]
# foot[RB] = [-1,-1,1]


initialFoot = foot

# footRF = [20,0,0]
# footLF = [-20,0,0]
# footLB = [-20,0,0]
# footRB = [20,0,0]

# footTableLF = ([-20, 0,1],[-20, 15,0],[-20, 10,0],[-20, 5,0],[-20, 0,0],[-20, -5,0],[-20, -10,0],[-20, -15,0],[],[])
# footTableLB = ([-20, 0,1],[-20, 15,0],[-20, 10,0],[-20, 5,0],[-20, 0,0],[-20, -5,0],[-20, -10,0],[-20, -15,0],[],[])
# footTableRB = ([ 20, 0,1],[ 20, 15,0],[ 20, 10,0],[ 20, 5,0],[ 20, 0,0],[ 20, -5,0],[ 20, -10,0],[ 20, -15,0],[],[])
# canvas.create_polygon(x+10,y-10, x+20,y-20, x+10,y-30,outline="red")
# canvas.create_polygon(x+10,y-10, x+20,y-20, x+10,y-30,outline="red")
# canvas.create_polygon(x+10,y-10, x+20,y-20, x+10,y-30)
timer = 0
# label1 = Label(root, text=prompt, width=len(prompt), bg='yellow')
# label1.pack()

def key(event):
    global stepX
    global stepY
    global lineCounter
    # global foot
    if event.char == event.keysym:
        msg = 'Normal Key %r' % event.char
        if event.keysym=="w":
            stepY += 1
        if event.keysym=="s":
            stepY -= 1
        if event.keysym=="a":
            stepX -= 1
        if event.keysym=="d":
            stepX += 1
        if event.keysym=="q":
            pass
        if event.keysym=="e":
            pass
            w
    elif len(event.char) == 1:
        msg = 'Punctuation Key %r (%r)' % (event.keysym, event.char)
    else:
        msg = 'Special Key %r' % event.keysym
        if event.keysym=="Up":
            stepY += 1
        if event.keysym=="Down":
            stepY -= 1
        if event.keysym=="Left":
            stepX -= 1
        if event.keysym=="Right":
            stepX += 1
    # label1.config(text=msg)
    lineCounter += 3
    # print(msg)
    # print ("stepx stepy"),
    # print (stepX,stepY)

root.bind_all('<Key>', key)
while True:
    # print (heardEnter())
    canvas.delete("all")
    step[LB] = [ (stepX+3)%8 ,(stepY+2)%8]
    step[LF] = [ (stepX+1)%8 ,(stepY+0)%8]
    step[RF] = [ (stepX+5)%8 ,(stepY+4)%8]
    step[RB] = [ (stepX+7)%8 ,(stepY+6)%8]

    # if foot[LF][zVar]==0 and foot[RF][zVar]==0 and foot[LB][zVar]==0 and foot[RB][zVar]==0:
    #     legsDown = True
    # else:
    #     legsDown = False
    legsDown = True
    print ("step[RF][yVar]",step[RF][yVar])
    # if legsDown:
    # if step[RF][xVar] == 0:
    #     foot[RF] = footTable[legUp][RF]
    #         # legsDown = False
    #     print ("step[RF][xVar] == 0:")
        # elif step[LF][xVar] == 0:
        #     foot[LF]= footTable[legUp][LF]
        #     legsDown = False
        # elif step[RB][xVar] == 0:
        #     foot[RB] = footTable[legUp][RB]
        #     legsDown = False
        # elif step[LB][xVar] == 0:
        #     foot[LB]= footTable[legUp][LB]
        #     legsDown = False
    if step[RF][yVar] > 0:
        foot[RF][zVar] = footTable[step[RF][yVar]][RF][zVar]
        foot[RF][yVar] = footTable[step[RF][yVar]][RF][yVar]
    if step[RF][xVar] > 0 and not step[RF][yVar] == 0:
        foot[RF][zVar] = footTable[step[RF][xVar]][RF][zVar]
        foot[RF][xVar] = footTable[step[RF][xVar]][RF][xVar]

    if step[LF][yVar] > 0:
        foot[LF][zVar] = footTable[step[LF][yVar]][LF][zVar]
        foot[LF][yVar] = footTable[step[LF][yVar]][LF][yVar]
    if step[LF][xVar] > 0 and not step[LF][yVar] == 0:
        foot[LF][zVar] = footTable[step[LF][xVar]][LF][zVar]
        foot[LF][xVar] = footTable[step[LF][xVar]][LF][xVar]

    if step[LB][yVar] > 0:
        foot[LB][zVar] = footTable[step[LB][yVar]][LB][zVar]
        foot[LB][yVar] = footTable[step[LB][yVar]][LB][yVar]
    if step[LB][xVar] > 0 and not step[LB][yVar] == 0:
        foot[LB][zVar] = footTable[step[LB][xVar]][LB][zVar]
        foot[LB][xVar] = footTable[step[LB][xVar]][LB][xVar]

    if step[RB][yVar] > 0:
        foot[RB][zVar] = footTable[step[RB][yVar]][RB][zVar]
        foot[RB][yVar] = footTable[step[RB][yVar]][RB][yVar]
    if step[RB][xVar] > 0 and not step[RB][yVar] == 0:
        foot[RB][zVar] = footTable[step[RB][xVar]][RB][zVar]
        foot[RB][xVar] = footTable[step[RB][xVar]][RB][xVar]

    if step[RF][yVar] == 0:
        foot[RF][xVar] = footTable[legUp][RF][xVar]
        foot[RF][yVar] = footTable[legUp][RF][yVar]
        foot[RF][zVar] = footTable[legUp][RF][zVar]
    if step[RF][xVar] == 0:
        foot[RF][xVar] = footTable[legUp][RF][xVar]
        foot[RF][yVar] = footTable[legUp][RF][yVar]
        foot[RF][zVar] = footTable[legUp][RF][zVar]

    if step[LF][yVar] == 0:
        foot[LF][xVar] = footTable[legUp][LF][xVar]
        foot[LF][yVar] = footTable[legUp][LF][yVar]
        foot[LF][zVar] = footTable[legUp][LF][zVar]
    if step[LF][xVar] == 0:
        foot[LF][xVar] = footTable[legUp][LF][xVar]
        foot[LF][yVar] = footTable[legUp][LF][yVar]
        foot[LF][zVar] = footTable[legUp][LF][zVar]

    if step[LB][yVar] == 0:
        foot[LB][xVar] = footTable[legUp][LB][xVar]
        foot[LB][yVar] = footTable[legUp][LB][yVar]
        foot[LB][zVar] = footTable[legUp][LB][zVar]
    if step[LB][xVar] == 0:
        foot[LB][xVar] = footTable[legUp][LB][xVar]
        foot[LB][yVar] = footTable[legUp][LB][yVar]
        foot[LB][zVar] = footTable[legUp][LB][zVar]

    if step[RB][yVar] == 0:
        foot[RB][xVar] = footTable[legUp][RB][xVar]
        foot[RB][yVar] = footTable[legUp][RB][yVar]
        foot[RB][zVar] = footTable[legUp][RB][zVar]
    if step[RB][xVar] == 0:
        foot[RB][xVar] = footTable[legUp][RB][xVar]
        foot[RB][yVar] = footTable[legUp][RB][yVar]
        foot[RB][zVar] = footTable[legUp][RB][zVar]

        # print ("footTable[legUp][RF]",footTable[legUp][RF])
        # print ("step[RF][yVar] == 0:")
        # elif step[LF][xVar] == 0:
        #     foot[LF]= footTable[legUp][LF]
        #     legsDown = False
        # elif step[RB][xVar] == 0:
        #     foot[RB] = footTable[legUp][RB]
        #     legsDown = False
        # elif step[LB][xVar] == 0:
        #     foot[LB]= footTable[legUp][LB]
        #     legsDown = False




    # if step[RF][yVar] == 7:
    #     foot[RF][yVar] = footTable[legWalk7][RF][yVar]

    # if step[RF][xVar] == 1:
    #     foot[RF][xVar] = footTable[legLeft][RF][xVar]
    #
    # if step[RF][xVar] == 7:
    #     foot[RF][xVar] = footTable[legRight][RF][xVar]

    # if step[RF][yVar] > 1 and step[RF][yVar] < 7:
    #     foot[RF][yVar]

    # elif step[LF][xVar] == 1:
    #     foot[LF]= footTable[legUp][LF]
    # elif step[RB][xVar] == 1:
    #     foot[RB] = footTable[legUp][RB]
    # elif step[LB][xVar] == 1:
    #     foot[LB]= footTable[legUp][LB]
    #

    ### draw the four foot position on the canvas
    if foot[LF][zVar]==0 and foot[RF][zVar]==0 and foot[LB][zVar]==0 and foot[RB][zVar]==0:
        # footRF = [footRF[0]+
        canvas.create_polygon(
            x+base[LF][xVar]+foot[LF][xVar],y-base[LF][yVar]-foot[LF][yVar],
            x+base[RF][xVar]+foot[RF][xVar],y-base[RF][yVar]-foot[RF][yVar],
            x+base[RB][xVar]+foot[RB][xVar],y-base[RB][yVar]-foot[RB][yVar],
            x+base[LB][xVar]+foot[LB][xVar],y-base[LB][yVar]-foot[LB][yVar],
            outline="yellow",fill="yellow")
    else: # this just draws one of four triangles for the 3 down feet
        if foot[LF][zVar]==0 and foot[RF][zVar]==0 and foot[LB][zVar]==0:
            canvas.create_polygon(
                x+base[LF][0]+foot[LF][0],y-base[LF][1]-foot[LF][1],
                x+base[RF][0]+foot[RF][0],y-base[RF][1]-foot[RF][1],
                x+base[LB][0]+foot[LB][0],y-base[LB][1]-foot[LB][1],
                outline="yellow",fill="yellow")
        if foot[LF][zVar]==0 and foot[RF][zVar]==0 and foot[RB][zVar]==0:
            canvas.create_polygon(
                x+base[LF][0]+foot[LF][0],y-base[LF][1]-foot[LF][1],
                x+base[RB][0]+foot[RB][0],y-base[RB][1]-foot[RB][1],
                x+base[LB][0]+foot[LB][0],y-base[LB][1]-foot[LB][1],
                outline="yellow",fill="yellow")
        if foot[LF][zVar]==0 and foot[LB][zVar]==0 and foot[RB][zVar]==0:
            canvas.create_polygon(
                x+base[LF][0]+foot[LF][0],y-base[LF][1]-foot[LF][1],
                x+base[RB][0]+foot[RB][0],y-base[RB][1]-foot[RB][1],
                x+base[LB][0]+foot[LB][0],y-base[LB][1]-foot[LB][1],
                outline="yellow",fill="yellow")
        if foot[RF][zVar]==0 and foot[LB][zVar]==0 and foot[RB][zVar]==0:
            canvas.create_polygon(
                x+base[RF][0]+foot[RF][0],y-base[RF][1]-foot[RF][1],
                x+base[RB][0]+foot[RB][0],y-base[RB][1]-foot[RB][1],
                x+base[LB][0]+foot[LB][0],y-base[LB][1]-foot[LB][1],
                outline="yellow",fill="yellow")


        # canvas.create_polygon(x+base[RF][0]+footRF[stepLF][0],y-base[RF][1]-footRF[stepRF][1],x+base[RF][0]+footRF[stepRF][0],y-base[RF][1]-footRF[stepRF][1],outline="yellow",fill="yellow")

    ### draw the legs of the robot
    canvas.create_polygon(x+base[LF][0],y-base[LF][1], x+base[LF][0]+foot[LF][0],y-base[LF][1]-foot[LF][1],outline="black")
    canvas.create_polygon(x+base[RF][0],y-base[RF][1], x+base[RF][0]+foot[RF][0],y-base[RF][1]-foot[RF][1],outline="black")
    canvas.create_polygon(x+base[LB][0],y-base[LB][1], x+base[LB][0]+foot[LB][0],y-base[LB][1]-foot[LB][1],outline="black")
    canvas.create_polygon(x+base[RB][0],y-base[RB][1], x+base[RB][0]+foot[RB][0],y-base[RB][1]-foot[RB][1],outline="black")

    ### draw the body of the robot
    canvas.create_polygon(x+box[LB][0],y-box[LB][1], x+box[LF][0],y-box[LF][1],outline="red")
    canvas.create_polygon(x+box[LF][0],y-box[LF][1], x+box[RF][0],y-box[RF][1],outline="red")
    canvas.create_polygon(x+box[RF][0],y-box[RF][1], x+box[RB][0],y-box[RB][1],outline="red")
    canvas.create_polygon(x+box[RB][0],y-box[RB][1], x+box[LB][0],y-box[LB][1],outline="red")

    ### draw the center of mass of the robot
    canvas.create_polygon(x+centerOfRobot[0][0],y-centerOfRobot[0][1], x+centerOfRobot[1][0],y-centerOfRobot[1][1],outline="red")
    canvas.create_polygon(x+centerOfRobot[1][0],y-centerOfRobot[1][1],x+centerOfRobot[2][0],y-centerOfRobot[2][1],outline="red")
    canvas.create_polygon(x+centerOfRobot[2][0],y-centerOfRobot[2][1], x+centerOfRobot[3][0],y-centerOfRobot[3][1],outline="red")
    canvas.create_polygon(x+centerOfRobot[3][0],y-centerOfRobot[3][1], x+centerOfRobot[0][0],y-centerOfRobot[0][1],outline="red")
    # timer += 1

    #this is the output text for tracking input and debugging
    if lineCounter<10000:
        lineCounter = 0
        # os.system("clear")
        # print ('Step LF RF LB RB')
    # lineCounter += 2
    print ("step",step)
    print ("foot",foot)
    print ('legsDown',legsDown)
    # print ('{0:4d} {1:4d} {2:4d} {3:4d} '.format(
    #
    #     box[RF][0],
    #     box[RF][1],
    #     base[RF][0]+foot[RF][0],
    #     base[RF][1]+foot[RF][1]
    #     ))


    # for event in pygame.event.get():
    #     print ("event")
    #     if event.type == pygame.KEYDOWN:
    #         print ("keydown")
    #         if event.key == K_UP:
    #             timer += 1
    #             print timer
    #         elif event.key == K_DOWN:
    #             timer -= 1
    #             print timer
    #         elif event.key == K_w:
    #             timer += 1
    #             print timer
    #         elif event.key == K_s:
    #             timer -= 1
    #             print timer
    # pygame.event.pump()
    canvas.update()
    canvas.after(100)
    # print ("next")


root.mainloop()
