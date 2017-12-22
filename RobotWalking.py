import tkinter as tk

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

LB = 0
LF = 1
RF = 2
RB = 3
step = 0
center = ([-1,-1],[-1,1],[1,1],[1,-1])
box = ([-50,-50],[-50,50],[50,50],[50,-50])
base = ([-45,-45],[-45,45],[45,45],[45,-45])

# footRF = ([ 20, 0,1],[ 20, 15,0],[ 20, 10,0],[ 20, 5,0],[ 20, 0,0],[ 20, -5,0],[ 20, -10,0],[ 20, -15,0],[],[])
footTableRF = (
    [ 0, 0,1],[ 0, 15,0],[],[],[],[],[],[ 0, -15,0],[],[],
    [ 0, 0,1],[ 3,  0,0],[],[],[],[],[],[ -3,   0,0],[],[]
    )

footRF = [20,0,1]
footLF = [0,0,1]
footLB = [0,0,1]
footRB = [0,0,1]

footTableLF = ([-20, 0,1],[-20, 15,0],[-20, 10,0],[-20, 5,0],[-20, 0,0],[-20, -5,0],[-20, -10,0],[-20, -15,0],[],[])
footTableLB = ([-20, 0,1],[-20, 15,0],[-20, 10,0],[-20, 5,0],[-20, 0,0],[-20, -5,0],[-20, -10,0],[-20, -15,0],[],[])
footTableRB = ([ 20, 0,1],[ 20, 15,0],[ 20, 10,0],[ 20, 5,0],[ 20, 0,0],[ 20, -5,0],[ 20, -10,0],[ 20, -15,0],[],[])
# canvas.create_polygon(x+10,y-10, x+20,y-20, x+10,y-30,outline="red")
# canvas.create_polygon(x+10,y-10, x+20,y-20, x+10,y-30,outline="red")
# canvas.create_polygon(x+10,y-10, x+20,y-20, x+10,y-30)
timer = 0
# label1 = Label(root, text=prompt, width=len(prompt), bg='yellow')
# label1.pack()

def key(event):
    global timer
    if event.char == event.keysym:
        msg = 'Normal Key %r' % event.char
    elif len(event.char) == 1:
        msg = 'Punctuation Key %r (%r)' % (event.keysym, event.char)
    else:
        msg = 'Special Key %r' % event.keysym
        if event.keysym=="Up":
            timer += 1
        if event.keysym=="Down":
            timer -= 1
    # label1.config(text=msg)
    print(msg)
    print ("timer"),
    print (timer)

root.bind_all('<Key>', key)
while True:
    # print (heardEnter())
    canvas.delete("all")
    # step = timer%8
    stepLF = (timer)%8
    stepLB = (timer+2)%8
    stepRF = (timer+4)%8
    stepRB = (timer+6)%8

    ### draw the foot position on the canvas
    if footLF[2]==0 and footRF[2]==0 and footLB[2]==0 and footRB[2]==0:
        # footRF = [footRF[0]+
        canvas.create_polygon(
            x+base[LF][0]+footLF[stepLF][0],y-base[LF][1]-footLF[stepLF][1],
            x+base[RF][0]+footRF[stepRF][0],y-base[RF][1]-footRF[1],
            x+base[RB][0]+footRB[stepRB][0],y-base[RB][1]-footRB[stepRB][1],
            x+base[LB][0]+footLB[stepLB][0],y-base[LB][1]-footLB[stepLB][1],
            outline="gray",fill="yellow")
    # else:
    #     if footLF[stepLF][2]==0 and footRF[stepRF][2]==0 and footLB[stepLB][2]==0:
    #         canvas.create_polygon(
    #             x+base[LF][0]+footLF[stepLF][0],y-base[LF][1]-footLF[stepLF][1],
    #             x+base[RF][0]+footRF[stepRF][0],y-base[RF][1]-footRF[stepRF][1],
    #             x+base[LB][0]+footLB[stepLB][0],y-base[LB][1]-footLB[stepLB][1],
    #             outline="gray",fill="yellow")
    #     if footLF[stepLF][2]==0 and footRF[stepRF][2]==0  and footRB[stepRB][2]==0:
    #         canvas.create_polygon(
    #             x+base[LF][0]+footLF[stepLF][0],y-base[LF][1]-footLF[stepLF][1],
    #             x+base[RF][0]+footRF[stepRF][0],y-base[RF][1]-footRF[stepRF][1],
    #             x+base[RB][0]+footRB[stepRB][0],y-base[RB][1]-footRB[stepRB][1],
    #             outline="gray",fill="yellow")
    #     if footLF[stepLF][2]==0 and footLB[stepLB][2]==0 and footRB[stepRB][2]==0:
    #         canvas.create_polygon(
    #             x+base[LF][0]+footLF[stepLF][0],y-base[LF][1]-footLF[stepLF][1],
    #             x+base[RB][0]+footRB[stepRB][0],y-base[RB][1]-footRB[stepRB][1],
    #             x+base[LB][0]+footLB[stepLB][0],y-base[LB][1]-footLB[stepLB][1],
    #             outline="gray",fill="yellow")
    #     if footRF[stepRF][2]==0 and footLB[stepLB][2]==0 and footRB[stepRB][2]==0:
    #         canvas.create_polygon(
    #             x+base[RF][0]+footRF[stepRF][0],y-base[RF][1]-footRF[stepRF][1],
    #             x+base[RB][0]+footRB[stepRB][0],y-base[RB][1]-footRB[stepRB][1],
    #             x+base[LB][0]+footLB[stepLB][0],y-base[LB][1]-footLB[stepLB][1],
    #             outline="gray",fill="yellow")


        # canvas.create_polygon(x+base[RF][0]+footRF[stepLF][0],y-base[RF][1]-footRF[stepRF][1],x+base[RF][0]+footRF[stepRF][0],y-base[RF][1]-footRF[stepRF][1],outline="yellow",fill="yellow")

    ### draw the body and center of mass of the robot
    # canvas.create_polygon(x+base[LF][0],y-base[LF][1], x+base[LF][0]+footLF[stepLF][0],y-base[LF][1]-footLF[stepLF][1],outline="black")
    canvas.create_polygon(x+base[RF][0],y-base[RF][1], x+base[RF][0]+footRF[0],y-base[RF][1]-footRF[1],outline="black")
    # canvas.create_polygon(x+base[LB][0],y-base[LB][1], x+base[LB][0]+footLB[stepLB][0],y-base[LB][1]-footLB[stepLB][1],outline="black")
    # canvas.create_polygon(x+base[RB][0],y-base[RB][1], x+base[RB][0]+footRB[stepRB][0],y-base[RB][1]-footRB[stepRB][1],outline="black")


    canvas.create_polygon(x+box[LB][0],y-box[LB][1], x+box[LF][0],y-box[LF][1],outline="red")
    canvas.create_polygon(x+box[LF][0],y-box[LF][1], x+box[RF][0],y-box[RF][1],outline="red")
    canvas.create_polygon(x+box[RF][0],y-box[RF][1], x+box[RB][0],y-box[RB][1],outline="red")
    canvas.create_polygon(x+box[RB][0],y-box[RB][1], x+box[LB][0],y-box[LB][1],outline="red")

    canvas.create_polygon(x+center[0][0],y-center[0][1], x+center[1][0],y-center[1][1],outline="red")
    canvas.create_polygon(x+center[1][0],y-center[1][1],x+center[2][0],y-center[2][1],outline="red")
    canvas.create_polygon(x+center[2][0],y-center[2][1], x+center[3][0],y-center[3][1],outline="red")
    canvas.create_polygon(x+center[3][0],y-center[3][1], x+center[0][0],y-center[0][1],outline="red")

    canvas.create_polygon(x+center[RF][0],y-center[3][1], x+center[0][0],y-center[0][1],outline="red")
    # timer += 1


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
