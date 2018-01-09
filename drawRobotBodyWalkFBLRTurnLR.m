function [ output_feet ] = drawRobotBody(step, direction_M_FB, direction_M_LR, direction_T_LR, head_M_UD, head_T_LR, input_feet, last_LR, last_UD)
%author jimfinoc
%RobotController 
%step = 0,1,2,3,4,5,6,7 on odd steps, recenter RF,RB,LF,LB legs if needed.
%direction_M_FB = -3,-2,-1,0,1,2,3
%direction_M_LR = -2,-1,0,1,2
%direction_T_LR = -1,0,1
%head_M_UD = -1,0,1
%head_T_LR = -3,-2,-1,0,1,2,3
%input_feet = [xFR yFR zFR; xBR yBR zBR; xFL yFL zFL; xBR yBR zBR]
%last_LR = -30 to 45 degrees
%last_UD = -135 to 130 degrees
%output_feet = format of [0 2 3 ; 2 3 4; 5 6 7;0 9 8] as FR;BR;FL;BR in x y z
% an example is 
% step = 0
% direction_M_FB = 1
% direction_M_LR = 0
% direction_T_LR = 0
% head_M_UD = 0
% head_T_LR = 0
% input_feet = [155 0 -100;155 0 -100;-155 0 -100;-155 0 -100]
% last_LR = 0
% last_UD = 0
% %drawRobotBody(step, direction_M_FB, direction_M_LR, direction_T_LR, head_M_UD, head_T_LR, input_feet, last_LR, last_UD)

%   This is the code to assist with keeping the robot from going too fast.
    direction_M_FB_max = 3;
    direction_M_LR_max = 1;
    direction_T_LR_max = 1;
    
%   we only have 8 positions, 0 - 7
    step = mod(step,8);

%   This is the code to assist with addressing variables.
    x = 1;
    y = 2;
    z = 3;
    FR = 1;
    BR = 2;
    FL = 3;
    BL = 4;

%   This is the code for viewing in matlab.
    
    close all;
    figure;
    hold on;
    grid on;
    az = 0; 
    el = 90;
    view(az, el);
    axis equal;
    xlabel('x');
    ylabel('y');
    zlabel('z');
    xlim([-300 300]);
    ylim([-300 300]);
    zlim([0 150]);


%   This is the code required to move the robot.
%     disp("***************************************");
    xMinRobotBody = -150;
    xMaxRobotBody =150;
    yMinRobotBody =-150;
    yMaxRobotBody =150;
    zRobotBodySurface = 100-19; 
     
    zRobotBodyThickness = zRobotBodySurface + 38;

    
    p1 = [xMaxRobotBody/3  yMaxRobotBody    zRobotBodySurface ];
    p2 = [xMaxRobotBody    yMaxRobotBody/3  zRobotBodySurface ];
    p3 = [xMaxRobotBody    yMinRobotBody/3  zRobotBodySurface ];
    p4 = [xMaxRobotBody/3  yMinRobotBody    zRobotBodySurface ];
    p5 = [xMinRobotBody/3  yMinRobotBody    zRobotBodySurface ];
    p6 = [xMinRobotBody    yMinRobotBody/3  zRobotBodySurface ];
    p7 = [xMinRobotBody    yMaxRobotBody/3  zRobotBodySurface ];
    p8 = [xMinRobotBody/3  yMaxRobotBody    zRobotBodySurface ];

    poly_poly(p1, p2, p3, p4, p5, p6, p7, p8) %bottom surface
    

    a1 = 83;
    a2 = 93.5;
    a3 = 52;
%     disp ("Joints a1, a2, a3")
%     disp ([a1 a2 a3])
    
%     legMaxDistance = a1 + a2 +a3; 
%     legMaxDistanceDown =  a2+a3;
    
    FR_Theta = [ 0 -pi/4 -pi/4];
    
    JointHeight = .5*(zRobotBodySurface+zRobotBodyThickness);
    
    Joint1FR_AbsolutePosition = [237/2 237/2 JointHeight];
    Joint1FL_AbsolutePosition = [-237/2 237/2 JointHeight];
    Joint1BR_AbsolutePosition = [237/2 -237/2 JointHeight];
    Joint1BL_AbsolutePosition = [-237/2 -237/2 JointHeight];

    
    ground_pt1 = [170 0 0] + Joint1FR_AbsolutePosition + [0 0 -100];
    ground_pt2 = [140 0 0] + Joint1FR_AbsolutePosition + [0 0 -100];
    ground_pt3 = [155 75 0] + Joint1FR_AbsolutePosition + [0 0 -100];
    ground_pt4 = [155 -75 0] + Joint1FR_AbsolutePosition + [0 0 -100];
    
    max_ground_pt = max(max(ground_pt1,ground_pt2),max(ground_pt3,ground_pt4));
    min_ground_pt = min(min(ground_pt1,ground_pt2),min(ground_pt3,ground_pt4));
    minmax_ground_pt = [min_ground_pt(x) max_ground_pt(y) 0];
    maxmin_ground_pt = [max_ground_pt(x) min_ground_pt(y) 0];
    center_ground_pt = [(max_ground_pt(x)+min_ground_pt(x))/2 (max_ground_pt(y)+min_ground_pt(y))/2  0];
    
    
    poly_rectangle(ground_pt1,ground_pt3,ground_pt2,ground_pt4);
    poly_rectangle(max_ground_pt,minmax_ground_pt,min_ground_pt,maxmin_ground_pt);

    %draws the four first joints
    cylinder(Joint1FL_AbsolutePosition(1),Joint1FL_AbsolutePosition(2),10,zRobotBodySurface,zRobotBodyThickness);
    cylinder(Joint1FR_AbsolutePosition(1),Joint1FR_AbsolutePosition(2),10,zRobotBodySurface,zRobotBodyThickness);
    cylinder(Joint1BL_AbsolutePosition(1),Joint1BL_AbsolutePosition(2),10,zRobotBodySurface,zRobotBodyThickness);
    cylinder(Joint1BR_AbsolutePosition(1),Joint1BR_AbsolutePosition(2),10,zRobotBodySurface,zRobotBodyThickness);
    
    % Check moving foward or back 
    if direction_M_FB > 0
       if direction_M_FB > direction_M_FB_max
           direction_M_FB = direction_M_FB_max;
       end
    elseif direction_M_FB < 0        
        if direction_M_FB < -direction_M_FB_max
           direction_M_FB = -direction_M_FB_max;
       end
    end
    
    % Check moving left or right 
    if direction_M_LR > 0
       if direction_M_LR > direction_M_LR_max
           direction_M_LR = direction_M_LR_max;
       end   
    elseif direction_M_LR < 0
        if direction_M_LR < -direction_M_LR_max
           direction_M_LR = -direction_M_LR_max;
       end
    end
    
    % Check turning left or right
    if direction_T_LR > 0 %turn left
       if direction_T_LR > direction_T_LR_max
           direction_T_LR = direction_T_LR_max;
       end
    elseif direction_T_LR < 0 %turn right
        if direction_T_LR < -direction_T_LR_max
           direction_T_LR = -direction_T_LR_max;
        end    
    end
    
    if direction_T_LR == 0
        input_feet(FR,x) = input_feet(FR,x) - direction_M_LR;
        input_feet(FR,y) = input_feet(FR,y) - direction_M_FB;
    else
        input_feet(FR,x) = input_feet(FR,x) - direction_M_LR;
        input_feet(FR,y) = input_feet(FR,y) - direction_M_FB;
        turn = (atan2(input_feet(FR,y)+Joint1FR_AbsolutePosition(y),input_feet(FR,x)+Joint1FR_AbsolutePosition(x))+direction_T_LR_max*3/2/180*pi);
        turnX = hypot(input_feet(FR,y)+Joint1FR_AbsolutePosition(y),input_feet(FR,x)+Joint1FR_AbsolutePosition(x))*cos(turn);
        turnY = hypot(input_feet(FR,y)+Joint1FR_AbsolutePosition(y),input_feet(FR,x)+Joint1FR_AbsolutePosition(x))*sin(turn);
%         disp("hypot of turnX and turnY");
%         disp(hypot(turnX,turnY));
        input_feet(FR,x) = turnX - Joint1FR_AbsolutePosition(x);
        input_feet(FR,y) = turnY - Joint1FR_AbsolutePosition(y);
    end    

    
    %******************************
    if input_feet(FR,z) > -100
        input_feet(FR,z) = -100;
        if direction_M_FB > 0
            input_feet(FR,y) = input_feet(FR,y) + 5*direction_M_FB;
        elseif direction_M_FB < 0
            input_feet(FR,y) = input_feet(FR,y) + 5*direction_M_FB;
        end
        if direction_M_LR > 0
            input_feet(FR,x) = input_feet(FR,x) + 5*direction_M_LR;
        elseif direction_M_LR < 0
            input_feet(FR,x) = input_feet(FR,x) + 5*direction_M_LR;
        end
        
    end
        
    
    if step == 1 
        if input_feet(FR,x) > max_ground_pt(x) - Joint1FR_AbsolutePosition(x)
            input_feet(FR,x) = center_ground_pt(x) - Joint1FR_AbsolutePosition(x);
            input_feet(FR,y) = center_ground_pt(y) - Joint1FR_AbsolutePosition(y);
            input_feet(FR,z) = center_ground_pt(z)+10 -Joint1FR_AbsolutePosition(z);
            disp("overstep x");
            
        elseif input_feet(FR,y) > max_ground_pt(y) -Joint1FR_AbsolutePosition(y)
            input_feet(FR,x) = center_ground_pt(x) -Joint1FR_AbsolutePosition(x);
            input_feet(FR,y) = center_ground_pt(y) -Joint1FR_AbsolutePosition(y);
            input_feet(FR,z) = center_ground_pt(z)+10 -Joint1FR_AbsolutePosition(z);
            disp("overstep y");
        elseif input_feet(FR,x) < min_ground_pt(x) -Joint1FR_AbsolutePosition(x)
            input_feet(FR,x) = center_ground_pt(x) -Joint1FR_AbsolutePosition(x);
            input_feet(FR,y) = center_ground_pt(y) -Joint1FR_AbsolutePosition(y);
            input_feet(FR,z) = center_ground_pt(z)+10 -Joint1FR_AbsolutePosition(z);
            disp("understep x");
        elseif input_feet(FR,y) < min_ground_pt(y) -Joint1FR_AbsolutePosition(y)
            input_feet(FR,x) = center_ground_pt(x) -Joint1FR_AbsolutePosition(x);
            input_feet(FR,y) = center_ground_pt(y) -Joint1FR_AbsolutePosition(y);
            input_feet(FR,z) = center_ground_pt(z)+10 -Joint1FR_AbsolutePosition(z);
            disp("understep y");
        end
    elseif step == 3
    elseif step == 5
    elseif step == 7
    end
    
    desiredFR_RelativePosition = [input_feet(FR,x) input_feet(FR,y) input_feet(FR,z)];
    
    S_FR = desiredFR_RelativePosition(z);
    
    FR_Theta(1) = atan2(desiredFR_RelativePosition(y),desiredFR_RelativePosition(x));
    R_FR = hypot(desiredFR_RelativePosition(x)-a1*cos(FR_Theta(1)),desiredFR_RelativePosition(y)-a1*sin(FR_Theta(1)));
  
    D_FR = (S_FR^2+R_FR^2-a2^2-a3^2)/(2*a2*a3);

    FR_Theta(3) = atan2(-sqrt(1-D_FR^2),D_FR);
    FR_Theta(2) = atan2(S_FR,R_FR)-atan2(a3*sin(FR_Theta(3)),a2+a3*cos(FR_Theta(3)));
    
    BR_Theta = [ 0 0 0];
    BL_Theta = [ pi 0 0];
    FL_Theta = [ pi 0 0];
    
    
    FR_DH = [a1 pi/2 0 FR_Theta(1); a2 0 0 FR_Theta(2); a3 0 0 FR_Theta(3)];
    BR_DH = [a1 pi/2 0 BR_Theta(1); a2 0 0 BR_Theta(2); a3 0 0 BR_Theta(3)];
    FL_DH = [a1 pi/2 0 FL_Theta(1); a2 0 0 FL_Theta(2); a3 0 0 FL_Theta(3)];
    BL_DH = [a1 pi/2 0 BL_Theta(1); a2 0 0 BL_Theta(2); a3 0 0 BL_Theta(3)];
    

    Joint2A_FR = calcAi(FR_DH, 1);
    Joint2FR = [Joint2A_FR(1,4)+Joint1FR_AbsolutePosition(1) Joint2A_FR(2,4)+Joint1FR_AbsolutePosition(2) Joint2A_FR(3,4)+Joint1FR_AbsolutePosition(3)];
    Joint3A_FR = calcAi(FR_DH, 1)*calcAi(FR_DH, 2);
    Joint3FR = [Joint3A_FR(1,4)+Joint1FR_AbsolutePosition(1) Joint3A_FR(2,4)+Joint1FR_AbsolutePosition(2) Joint3A_FR(3,4)+Joint1FR_AbsolutePosition(3)];
    FootAMatrix_FR = calcAi(FR_DH, 1) * calcAi(FR_DH, 2) * calcAi(FR_DH, 3);
    FootPositionFR = [FootAMatrix_FR(1,4)+Joint1FR_AbsolutePosition(1) FootAMatrix_FR(2,4)+Joint1FR_AbsolutePosition(2) FootAMatrix_FR(3,4)+Joint1FR_AbsolutePosition(3)];
    
%     output_feet(FR,x) = FootPositionFR(x);
%     output_feet(FR,y) = FootPositionFR(y);
%     output_feet(FR,z) = FootPositionFR(z);

    output_feet = zeros(4,3);
    output_feet(FR,:) = [FootAMatrix_FR(1,4) FootAMatrix_FR(2,4) FootAMatrix_FR(3,4)]

    Joint2A_BR = calcAi(BR_DH, 1);
    Joint2BR = [Joint2A_BR(1,4)+Joint1BR_AbsolutePosition(1) Joint2A_BR(2,4)+Joint1BR_AbsolutePosition(2) Joint2A_BR(3,4)+Joint1BR_AbsolutePosition(3)];
    Joint3A_BR = calcAi(BR_DH, 1)*calcAi(BR_DH, 2);
    Joint3BR = [Joint3A_BR(1,4)+Joint1BR_AbsolutePosition(1) Joint3A_BR(2,4)+Joint1BR_AbsolutePosition(2) Joint3A_BR(3,4)+Joint1BR_AbsolutePosition(3)];
    FootAMatrix_BR = calcAi(BR_DH, 1) * calcAi(BR_DH, 2) * calcAi(BR_DH, 3);
    FootPositionBR = [FootAMatrix_BR(1,4)+Joint1BR_AbsolutePosition(1) FootAMatrix_BR(2,4)+Joint1BR_AbsolutePosition(2) FootAMatrix_BR(3,4)+Joint1BR_AbsolutePosition(3)];
    
    
    Joint2A_FL = calcAi(FL_DH, 1);
    Joint2FL = [Joint2A_FL(1,4)+Joint1FL_AbsolutePosition(1) Joint2A_FL(2,4)+Joint1FL_AbsolutePosition(2) Joint2A_FL(3,4)+Joint1FL_AbsolutePosition(3)];
    Joint3A_FL = calcAi(FL_DH, 1)*calcAi(FL_DH, 2);
    Joint3FL = [Joint3A_FL(1,4)+Joint1FL_AbsolutePosition(1) Joint3A_FL(2,4)+Joint1FL_AbsolutePosition(2) Joint3A_FL(3,4)+Joint1FL_AbsolutePosition(3)];
    FootAMatrix_FL = calcAi(FL_DH, 1) * calcAi(FL_DH, 2) * calcAi(FL_DH, 3);
    FootPositionFL = [FootAMatrix_FL(1,4)+Joint1FL_AbsolutePosition(1) FootAMatrix_FL(2,4)+Joint1FL_AbsolutePosition(2) FootAMatrix_FL(3,4)+Joint1FL_AbsolutePosition(3)];

    
    Joint2A_BL = calcAi(BL_DH, 1);
    Joint2BL = [Joint2A_BL(1,4)+Joint1BL_AbsolutePosition(1) Joint2A_BL(2,4)+Joint1BL_AbsolutePosition(2) Joint2A_BL(3,4)+Joint1BL_AbsolutePosition(3)];
    Joint3A_BL = calcAi(BL_DH, 1)*calcAi(BL_DH, 2);
    Joint3BL = [Joint3A_BL(1,4)+Joint1BL_AbsolutePosition(1) Joint3A_BL(2,4)+Joint1BL_AbsolutePosition(2) Joint3A_BL(3,4)+Joint1BL_AbsolutePosition(3)];
    FootAMatrix_BL = calcAi(BL_DH, 1) * calcAi(BL_DH, 2) * calcAi(BL_DH, 3);
    FootPositionBL = [FootAMatrix_BL(1,4)+Joint1BL_AbsolutePosition(1) FootAMatrix_BL(2,4)+Joint1BL_AbsolutePosition(2) FootAMatrix_BL(3,4)+Joint1BL_AbsolutePosition(3)];


    poly_line(Joint1FR_AbsolutePosition,Joint2FR);
    poly_line(Joint2FR,Joint3FR);
    poly_line(Joint3FR,FootPositionFR);
    
    poly_line(Joint1BR_AbsolutePosition,Joint2BR);
    poly_line(Joint2BR,Joint3BR);
    poly_line(Joint3BR,FootPositionBR);
    
    poly_line(Joint1FL_AbsolutePosition,Joint2FL);
    poly_line(Joint2FL,Joint3FL);
    poly_line(Joint3FL,FootPositionFL);
    
    poly_line(Joint1BL_AbsolutePosition,Joint2BL);
    poly_line(Joint2BL,Joint3BL);
    poly_line(Joint3BL,FootPositionBL);
    

    
%     disp("***************************************");

   

    
    function poly_line(p1,p2)
        xPosition = [p1(1) p2(1)];
        yPosition = [p1(2) p2(2)];
        zPosition = [p1(3) p2(3)];
        
        fill3(xPosition,yPosition,zPosition,[0 0 0]);
    end
    
    function cylinder(x,y,r,z1,z2)
        % example --    cylinder(Joint1FL_AbsolutePosition(1),Joint1FL_AbsolutePosition(2),10,zRobotBodySurface,zRobotBodyThickness)
        % Joint1FL_AbsolutePosition(1),
        % Joint1FL_AbsolutePosition(2),
        % 10
        % zRobotBodySurface
        % zRobotBodyThickness
        
        circleEdges = 16;
        %top
        angle = linspace(0,2*pi,circleEdges+1);
        pointX1 = x + r * cos(angle);
        pointY1 = y + r * sin(angle);
        pointZ1 = z1 + 0 * angle;
         
        fill3(pointX1, pointY1, pointZ1, [1    0.3300    0.1000]);

        %bottom
        angle = linspace(0,2*pi,circleEdges+1);
        pointX2 = x + r * cos(angle);
        pointY2 = y + r * sin(angle);
        pointZ2 = z2 + 0 * angle;
              
        fill3(pointX2, pointY2, pointZ2, [.7    0.3300    0.1000]);

        for side = 1:circleEdges
            p1 = [pointX1(side) pointY1(side) pointZ1];
            p2 = [pointX1(side+1) pointY1(side+1) pointZ1];
            p4 = [pointX2(side) pointY2(side) pointZ2];
            p3 = [pointX2(side+1) pointY2(side+1) pointZ2];
            poly_rectangle(p1, p2, p3, p4)
        end
    end
         
    function poly_rectangle(p1, p2, p3, p4)
        % The points must be in the correct sequence.
        % The coordinates must consider x, y and z-axes.
        xPosition = [p1(1) p2(1) p3(1) p4(1)];
        yPosition = [p1(2) p2(2) p3(2) p4(2)];
        zPosition = [p1(3) p2(3) p3(3) p4(3)];
        fill3(xPosition, yPosition, zPosition, [0.8500    0.3300    0.1000]);
    end

    function poly_poly(p1, p2, p3, p4, p5, p6, p7, p8)
        % The points must be in the correct sequence.
        % The coordinates must consider x, y and z-axes.
        xPosition = [p1(1) p2(1) p3(1) p4(1) p5(1) p6(1) p7(1) p8(1)];
        yPosition = [p1(2) p2(2) p3(2) p4(2) p5(2) p6(2) p7(2) p8(2)];
        zPosition = [p1(3) p2(3) p3(3) p4(3) p5(3) p6(3) p7(3) p8(3)];
        fill3(xPosition, yPosition, zPosition, [0.8500    0.3300    0.1000]);
    end

    function poly_circle(center, d, N,color, theta)
        
        %     % this function plots a ball cetered at point p, with diameter d. The
        %     % color of the ball is defind by color input (string type).
        %     plot3(p(1),p(2),p(3),'o',...
        %         'markersize',d*25,'markerfacecolor',color)
        r = d/2;
        angles=linspace(0,2*pi,N);
        rho=ones(1,N)*r;
        zPosition = ones(1,N)*.1;
        [X,Y, Z] = pol2cart(angles,rho,zPosition);
        X=X+center(1);
        Y=Y+center(2);
        Z = Z+center(3);
        h=fill3(X,Y,Z, color);
        %     rotate(h, [center(1),center(2), center(3)], theta); %rotating disk
    end


end

