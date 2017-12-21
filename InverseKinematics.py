import numpy as np
import math as math

# leg = np.array([6,7,8])
# print(leg)

x = 1
y = 10

result = math.atan2(y,x)

print result

FootPosition = {}
FootPosition["FrontLeft",0] = {"x":1,"y":0,"z":2}
FootPosition["FrontLeft",1] = {"x":1,"y":3,"z":0}
FootPosition["FrontLeft",2] = {"x":1,"y":2,"z":0}
FootPosition["FrontLeft",3] = {"x":1,"y":1,"z":0}
FootPosition["FrontLeft",4] = {"x":1,"y":0,"z":0}
FootPosition["FrontLeft",5] = {"x":1,"y":-1,"z":0}
FootPosition["FrontLeft",6] = {"x":1,"y":-2,"z":0}
FootPosition["FrontLeft",7] = {"x":1,"y":-3,"z":0}

FootPosition["RearLeft",0] = {"x":1,"y":0,"z":1}
FootPosition["RearLeft",1] = {"x":1,"y":3,"z":0}
FootPosition["RearLeft",2] = {"x":1,"y":2,"z":0}
FootPosition["RearLeft",3] = {"x":1,"y":1,"z":0}
FootPosition["RearLeft",4] = {"x":1,"y":0,"z":0}
FootPosition["RearLeft",5] = {"x":1,"y":-1,"z":0}
FootPosition["RearLeft",6] = {"x":1,"y":-2,"z":0}
FootPosition["RearLeft",7] = {"x":1,"y":-3,"z":0}


FootPosition["FrontRight",0] = {"x":5,"y":0,"z":1}
FootPosition["FrontRight",1] = {"x":5,"y":3,"z":0}
FootPosition["FrontRight",2] = {"x":5,"y":2,"z":0}
FootPosition["FrontRight",3] = {"x":5,"y":1,"z":0}
FootPosition["FrontRight",4] = {"x":5,"y":0,"z":0}
FootPosition["FrontRight",5] = {"x":5,"y":-1,"z":0}
FootPosition["FrontRight",6] = {"x":5,"y":-2,"z":0}
FootPosition["FrontRight",7] = {"x":5,"y":-3,"z":0}

FootPosition["RearRight",0] = {"x":5,"y":0,"z":1}
FootPosition["RearRight",1] = {"x":5,"y":3,"z":0}
FootPosition["RearRight",2] = {"x":5,"y":2,"z":0}
FootPosition["RearRight",3] = {"x":5,"y":1,"z":0}
FootPosition["RearRight",4] = {"x":5,"y":0,"z":0}
FootPosition["RearRight",5] = {"x":5,"y":-1,"z":0}
FootPosition["RearRight",6] = {"x":5,"y":-2,"z":0}
FootPosition["RearRight",7] = {"x":5,"y":-3,"z":0}
Ox = 0
Oy = 0
Oz = 5
d1 = 0
a2 = 2
a3 = 3


for position in range (0,8):
    print "position",
    print position,
    print (position+1)%8,
    print (position+5)%8,
    print (position+3)%8,
    print (position+7)%8,
    print "FrontLeft Position",
    FPx = FootPosition["FrontLeft",(position+1)%8]["x"]
    FPy = FootPosition["FrontLeft",(position+1)%8]["y"]
    FPz = FootPosition["FrontLeft",(position+1)%8]["z"]
    print "FPx",FPx,"FPy",FPy,"FPz",FPz,
    print "FL Angle1",
    Angle1 = math.atan2(FPy, FPx)
    r = math.sqrt ( (Ox-FPx)*(Ox-FPx) + (Oy-FPy)*(Oy-FPy) + (Oz - FPz)*(Oz - FPz) )
    D = float(FPx^2 + FPy^2 + (FPz -d1)^2-a2^2-a3^2) / (2 * a2 * a3)
    # print "r",r,
    # print "D",D,
    Angle3 = math.atan2( math.sqrt(r*r - D*D),D)
    Angle2 = math.atan2( FPz - d1, math.sqrt( (FPx)*(FPx) + (FPy)*(FPy) )) - math.atan2(a3 * math.sin(Angle3), a2 + a3 * math.cos(Angle3))
    print '{0:.0f}'.format(Angle1 *180/math.pi),
    print "FL Angle2",
    print '{0:.0f}'.format(Angle2 *180/math.pi),
    print "FL Angle3",
    print '{0:.0f}'.format(Angle3 *180/math.pi),
    print ""
