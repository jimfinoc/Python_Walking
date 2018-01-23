import math
import time

def kinematics(pos,realstep,dir_M_FB, dir_M_LR, dir_T_LR, head_M_UD, head_T_LR):
    # only care about the steps as they are a factor of 8 positions.
    step = realstep%8
    new_pos = {}
    for k, v in pos.iteritems():
        new_pos[k] = v
    # These are the speed limits
    direction_M_FB_max = 3
    direction_M_LR_max = 1
    direction_T_LR_max = 1
    head_M_UD_max = 5
    head_T_LR_max = 3
    # These are the leg joints for calculating the angles
    leg_section_a1 = 83.0
    leg_section_a2 = 93.5
    leg_section_a3 = 52.0
    joint = {}
    turn = {'FR':{}, 'FL':{},'BR':{},'BL':{} }
    zRobotBodySurface = 100.0-19.0
    zRobotBodyThickness = zRobotBodySurface + 38.0

    joint_absolute_pos = {}
    joint_absolute_pos['x'] = 237.0/2
    joint_absolute_pos['y'] = 237.0/2
    joint_absolute_pos['z'] = .5*(zRobotBodySurface+zRobotBodyThickness)


    # Joint1FR_AbsolutePosition
    # joint_absolute_pos is the exact center of each of the first joints.
    joint_absolute_pos['FR'] = {'x':joint_absolute_pos['x'], 'y':joint_absolute_pos['y'], 'z':joint_absolute_pos['z']}
    joint_absolute_pos['FL'] = {'x':-joint_absolute_pos['x'], 'y':joint_absolute_pos['y'], 'z':joint_absolute_pos['z']}
    joint_absolute_pos['BR'] = {'x':joint_absolute_pos['x'], 'y':-joint_absolute_pos['y'], 'z':joint_absolute_pos['z']}
    joint_absolute_pos['BL'] = {'x':-joint_absolute_pos['x'], 'y':-joint_absolute_pos['y'], 'z':joint_absolute_pos['z']}

    # Speed checking for body
    if dir_M_FB > direction_M_FB_max:
        dir_M_FB = direction_M_FB_max
    elif dir_M_FB < -direction_M_FB_max:
        dir_M_FB = -direction_M_FB_max
    if dir_M_LR > direction_M_LR_max:
       dir_M_LR = direction_M_LR_max
    elif dir_M_LR < -direction_M_LR_max:
       dir_M_LR = -direction_M_LR_max
    if dir_T_LR > direction_T_LR_max:
       dir_T_LR = direction_T_LR_max
    elif dir_T_LR < -direction_T_LR_max:
       dir_T_LR = -direction_T_LR_max
    # Speed checking for the turret
    if head_M_UD > head_M_UD_max:
        head_M_UD = head_M_UD_max
    elif head_M_UD < -head_M_UD_max:
        head_M_UD = -head_M_UD_max
    if head_T_LR > head_T_LR_max:
        head_T_LR = head_T_LR_max
    elif head_T_LR < -head_T_LR_max:
        head_T_LR = -head_T_LR_max

    # move turret accordingly
    new_pos['TU']['UD'] += head_M_UD
    new_pos['TU']['LR'] += head_T_LR
    # range check
    # Left and right
    if new_pos['TU']['LR'] > 135:#math.pi/4*180:
        new_pos['TU']['LR'] = 135#math.pi/4
    elif new_pos['TU']['LR'] < -135:#math.pi/4:
        new_pos['TU']['LR'] = -135#math.pi/4
    # up and down
    if new_pos['TU']['UD'] > 45:#math.pi/2*180:
        new_pos['TU']['UD'] = 45#math.pi/2*180
    elif new_pos['TU']['UD'] < -30:#math.pi/2*180:
        new_pos['TU']['UD'] = -30#math.pi/2*180

    for leg in ['FR','BR','FL','BL']:
        # straight movement
        new_pos[leg]['x'] = new_pos[leg]['x'] - dir_M_LR
        new_pos[leg]['y'] = new_pos[leg]['y'] - dir_M_FB
        if dir_T_LR == 0:
            # turning movement
            turn[leg]['radians'] = (math.atan2(new_pos[leg]['y']+joint_absolute_pos[leg]['y'],new_pos[leg]['x']+joint_absolute_pos[leg]['x'])+dir_T_LR*3/2/180*math.pi)
            turn[leg]['x'] = math.hypot(new_pos[leg]['y']+joint_absolute_pos[leg]['y'],new_pos[leg]['x']+joint_absolute_pos[leg]['x'])*math.cos(turn[leg]['radians'])
            turn[leg]['y'] = math.hypot(new_pos[leg]['y']+joint_absolute_pos[leg]['y'],new_pos[leg]['x']+joint_absolute_pos[leg]['x'])*math.sin(turn[leg]['radians'])
            new_pos[leg]['x'] = turn[leg]['x'] - joint_absolute_pos[leg]['x']
            new_pos[leg]['y'] = turn[leg]['y'] - joint_absolute_pos[leg]['y']
        # boundry checking
        if step == 1:
            pass
        if step == 3:
            pass
        if step == 5:
            pass
        if step == 7:
            pass
        # joint calculation
        new_pos[leg]['th1'] = math.atan2(new_pos[leg]['y'],new_pos[leg]['x'])
        S_value = new_pos[leg]['z']
        R_value = math.hypot(new_pos[leg]['x']-leg_section_a1*math.cos(new_pos[leg]['th1']),new_pos[leg]['y']-leg_section_a1*math.sin(new_pos[leg]['th1']));
        D_value = (S_value*S_value+R_value*R_value-leg_section_a2*leg_section_a2-leg_section_a3*leg_section_a3)/(2*leg_section_a2*leg_section_a3);
        new_pos[leg]['th3'] = math.atan2(-math.sqrt(1-D_value*D_value),D_value);
        new_pos[leg]['th2'] = math.atan2(S_value,R_value)-math.atan2(leg_section_a3*math.sin(pos[leg]['th3']),leg_section_a2+leg_section_a3*math.cos(pos[leg]['th3']));

    for key, value in new_pos.iteritems():
        pos[key] = value
    # print step, realstep
    time.sleep(.05)

    return pos


if __name__== "__main__":
    # Initialize the dictionary
    pos = {}
    pos['FR']={}
    pos['BR']={}
    pos['BL']={}
    pos['FL']={}
    # coordinates
    pos['FR']['x'] = 155
    pos['FR']['y'] = 0
    pos['FR']['z'] = -100

    pos['BR']['x'] = 155
    pos['BR']['y'] = 0
    pos['BR']['z'] = -100

    pos['FL']['x'] = -155
    pos['FL']['y'] = 0
    pos['FL']['z'] = -100

    pos['BL']['x'] = -155
    pos['BL']['y'] = 0
    pos['BL']['z'] = -100

    # angles
    pos['FR']['th1'] = 1
    pos['FR']['th2'] = 2
    pos['FR']['th3'] = 3

    pos['BR']['th1'] = 1
    pos['BR']['th2'] = 2
    pos['BR']['th3'] = 3

    pos['FL']['th1'] = 1
    pos['FL']['th2'] = 2
    pos['FL']['th3'] = 3

    pos['BL']['th1'] = 1
    pos['BL']['th2'] = 2
    pos['BL']['th3'] = 3

    pos['TU'] = {}
    pos['TU']['LR'] = 0
    pos['TU']['UD'] = 0


    # def keytest(pos):
    #     old_pos = pos
    #     new_pos = pos
    #     print pos
    #     pos['FL'] = 1
    #     print pos
    #     new_pos = pos
    #     print new_pos
    print "pos1", pos
    step = 1
    dir_M_FB = 1
    dir_M_LR = 1
    dir_T_LR = 0
    head_M_UD = 1
    head_T_LR = 1
    T = time.time()
    kinematics(pos,step,dir_M_FB, dir_M_LR, dir_T_LR, head_M_UD, head_T_LR)
    print "Time taken",time.time()-T
    print "pos2", pos
    kinematics(pos,step,dir_M_FB, dir_M_LR, dir_T_LR, head_M_UD, head_T_LR)
    print "pos3", pos
