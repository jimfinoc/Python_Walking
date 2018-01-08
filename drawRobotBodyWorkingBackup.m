function [ output_args ] = drawRobotBody(direction)

%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    clc
    close all
    figure
    hold on
    grid on
%     view([0,-1,1]);
    az = 0;
    el = 90;
    view(az, el);

    axis equal
    xlabel('x')
    ylabel('y')
    zlabel('z')
    




%     disp("***************************************");
    xMinRobotBody = -150;
    xMaxRobotBody =150;
    yMinRobotBody =-150;
    yMaxRobotBody =150;
    zRobotBodySurface = 100-19; %128.281 ;
     
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
    
    
    x = 1;
    y = 2;
    z = 3;
    a1 = 83;
    a2 = 93.5;
    a3 = 52;
    disp ("Joints a1, a2, a3")
    disp ([a1 a2 a3])
    
    legMaxDistance = a1 + a2 +a3; 
    legMaxDistanceDown =  a2+a3;
    
    FR_Theta = [ 0 -pi/4 -pi/4];
    
    JointHeight = .5*(zRobotBodySurface+zRobotBodyThickness);
    
    Joint1FR_AbsolutePosition = [237/2 237/2 JointHeight];
    Joint1FL_AbsolutePosition = [-237/2 237/2 JointHeight];
    Joint1BR_AbsolutePosition = [237/2 -237/2 JointHeight];
    Joint1BL_AbsolutePosition = [-237/2 -237/2 JointHeight];

    cylinder(Joint1FL_AbsolutePosition(1),Joint1FL_AbsolutePosition(2),10,zRobotBodySurface,zRobotBodyThickness)
    cylinder(Joint1FR_AbsolutePosition(1),Joint1FR_AbsolutePosition(2),10,zRobotBodySurface,zRobotBodyThickness)
    cylinder(Joint1BL_AbsolutePosition(1),Joint1BL_AbsolutePosition(2),10,zRobotBodySurface,zRobotBodyThickness)
    cylinder(Joint1BR_AbsolutePosition(1),Joint1BR_AbsolutePosition(2),10,zRobotBodySurface,zRobotBodyThickness)
    
    desiredFR_AbsolutePosition = [160+237/2 -70+237/2 0]
    desiredFR_RelativePosition = [desiredFR_AbsolutePosition(x)-Joint1FR_AbsolutePosition(x) desiredFR_AbsolutePosition(y)-Joint1FR_AbsolutePosition(y) desiredFR_AbsolutePosition(z)-Joint1FR_AbsolutePosition(z)]
    desiredFR_RelativePosition = [160  0  -100]

%     R_FR = hypot(desiredFR_RelativePosition(y),desiredFR_RelativePosition(x)-a1);
    S_FR = desiredFR_RelativePosition(z);
    
    FR_Theta(1) = atan2(desiredFR_RelativePosition(y),desiredFR_RelativePosition(x));
    xCalc = desiredFR_RelativePosition(x)-a1*cos(FR_Theta(1))
    yCalc = desiredFR_RelativePosition(y)-a1*sin(FR_Theta(1))
    zCalc = desiredFR_RelativePosition(z)
    R_FR = hypot(xCalc,yCalc)
%     S = sqrt( xCalc^2 + yCalc^2 + zCalc^2)
    
%     FR_Theta(1) = atan2(desiredPositionFR(y)-Joint1FR(y),desiredPositionFR(x)-Joint1FR(x));
%     R = hypot(desiredPositionFR(y)-Joint1FR(y),desiredPositionFR(x)-Joint1FR(x))-a1;
%     RZ = hypot(R,desiredPositionFR(z)-Joint1FR(z));
%     S = desiredPositionFR(z)-Joint1FR(z);
%     disp("R^2");
%     disp(R^2);
%     disp("S^2");
%     disp(S^2);
%     disp("a2^2");
%     disp(a2^2);
%     disp("a3^2");
%     disp(a3^2);
  
    D = (S_FR^2+R_FR^2-a2^2-a3^2)/(2*a2*a3)
%     disp("Calc Theta 1");
%     FR_Theta(1) = atan2(desiredFR_RelativePosition(y),desiredFR_RelativePosition(x));
%     disp("Calc Theta 3");
    FR_Theta(3) = atan2(-sqrt(1-D^2),D);
%     disp("Calc Theta 2");
    FR_Theta(2) = atan2(S_FR,R_FR)-atan2(a3*sin(FR_Theta(3)),a2+a3*cos(FR_Theta(3)))
%     disp (atan2(S,R)+atan2(a3*sin(FR_Theta(3)),a2+a3*cos(FR_Theta(3))));
    BR_Theta = [ 0 -pi/4 -pi/4];
    BR_Theta = [ 0 -pi/2 0];
    BL_Theta = [ pi 0 -pi/4];
    FL_Theta = [ pi -pi/4 -pi/4];
%     JointTheta = [ 0 -pi/2 0]
    
    
    FR_DH = [a1 pi/2 0 FR_Theta(1); a2 0 0 FR_Theta(2); a3 0 0 FR_Theta(3)];
    BR_DH = [a1 pi/2 0 BR_Theta(1); a2 0 0 BR_Theta(2); a3 0 0 BR_Theta(3)];
    FL_DH = [a1 pi/2 0 FL_Theta(1); a2 0 0 FL_Theta(2); a3 0 0 FL_Theta(3)];
    BL_DH = [a1 pi/2 0 BL_Theta(1); a2 0 0 BL_Theta(2); a3 0 0 BL_Theta(3)];

    Joint2A_FR = calcAi(FR_DH, 1);
    Joint2FR = [Joint2A_FR(1,4)+Joint1FR_AbsolutePosition(1) Joint2A_FR(2,4)+Joint1FR_AbsolutePosition(2) Joint2A_FR(3,4)+Joint1FR_AbsolutePosition(3)];
    Joint3A_FR = calcAi(FR_DH, 1)*calcAi(FR_DH, 2);
    Joint3FR = [Joint3A_FR(1,4)+Joint1FR_AbsolutePosition(1) Joint3A_FR(2,4)+Joint1FR_AbsolutePosition(2) Joint3A_FR(3,4)+Joint1FR_AbsolutePosition(3)];
    FootAMatrix_FR = calcAi(FR_DH, 1) * calcAi(FR_DH, 2) * calcAi(FR_DH, 3)
    FootPositionFR = [FootAMatrix_FR(1,4)+Joint1FR_AbsolutePosition(1) FootAMatrix_FR(2,4)+Joint1FR_AbsolutePosition(2) FootAMatrix_FR(3,4)+Joint1FR_AbsolutePosition(3)]
    poly_line(Joint1FR_AbsolutePosition,Joint2FR);
    poly_line(Joint2FR,Joint3FR);
    poly_line(Joint3FR,FootPositionFR);
    
    Joint2A_BR = calcAi(BR_DH, 1);
    Joint2BR = [Joint2A_BR(1,4)+Joint1BR_AbsolutePosition(1) Joint2A_BR(2,4)+Joint1BR_AbsolutePosition(2) Joint2A_BR(3,4)+Joint1BR_AbsolutePosition(3)];
    Joint3A_BR = calcAi(BR_DH, 1)*calcAi(BR_DH, 2);
    Joint3BR = [Joint3A_BR(1,4)+Joint1BR_AbsolutePosition(1) Joint3A_BR(2,4)+Joint1BR_AbsolutePosition(2) Joint3A_BR(3,4)+Joint1BR_AbsolutePosition(3)];
    FootAMatrix_BR = calcAi(BR_DH, 1) * calcAi(BR_DH, 2) * calcAi(BR_DH, 3);
    FootPositionBR = [FootAMatrix_BR(1,4)+Joint1BR_AbsolutePosition(1) FootAMatrix_BR(2,4)+Joint1BR_AbsolutePosition(2) FootAMatrix_BR(3,4)+Joint1BR_AbsolutePosition(3)];
    poly_line(Joint1BR,Joint2BR);
    poly_line(Joint2BR,Joint3BR);
    poly_line(Joint3BR,FootPositionBR);
    
    Joint2A_FL = calcAi(FL_DH, 1);
    Joint2FL = [Joint2A_FL(1,4)+Joint1FL_AbsolutePosition(1) Joint2A_FL(2,4)+Joint1FL_AbsolutePosition(2) Joint2A_FL(3,4)+Joint1FL_AbsolutePosition(3)];
    Joint3A_FL = calcAi(FL_DH, 1)*calcAi(FL_DH, 2);
    Joint3FL = [Joint3A_FL(1,4)+Joint1FL_AbsolutePosition(1) Joint3A_FL(2,4)+Joint1FL_AbsolutePosition(2) Joint3A_FL(3,4)+Joint1FL_AbsolutePosition(3)];
    FootAMatrix_FL = calcAi(FL_DH, 1) * calcAi(FL_DH, 2) * calcAi(FL_DH, 3);
    FootPositionFL = [FootAMatrix_FL(1,4)+Joint1FL_AbsolutePosition(1) FootAMatrix_FL(2,4)+Joint1FL_AbsolutePosition(2) FootAMatrix_FL(3,4)+Joint1FL_AbsolutePosition(3)];
    poly_line(Joint1FL_AbsolutePosition,Joint2FL);
    poly_line(Joint2FL,Joint3FL);
    poly_line(Joint3FL,FootPositionFL);
    
    Joint2A_BL = calcAi(BL_DH, 1);
    Joint2BL = [Joint2A_BL(1,4)+Joint1BL_AbsolutePosition(1) Joint2A_BL(2,4)+Joint1BL_AbsolutePosition(2) Joint2A_BL(3,4)+Joint1BL_AbsolutePosition(3)];
    Joint3A_BL = calcAi(BL_DH, 1)*calcAi(BL_DH, 2);
    Joint3BR = [Joint3A_BL(1,4)+Joint1BL_AbsolutePosition(1) Joint3A_BL(2,4)+Joint1BL_AbsolutePosition(2) Joint3A_BL(3,4)+Joint1BL_AbsolutePosition(3)];
    FootAMatrix_BL = calcAi(BL_DH, 1) * calcAi(BL_DH, 2) * calcAi(BL_DH, 3);
    FootPositionBL = [FootAMatrix_BL(1,4)+Joint1BL_AbsolutePosition(1) FootAMatrix_BL(2,4)+Joint1BL_AbsolutePosition(2) FootAMatrix_BL(3,4)+Joint1BL_AbsolutePosition(3)];
    poly_line(Joint1BL_AbsolutePosition,Joint2BL);
    poly_line(Joint2BL,Joint3BR);
    poly_line(Joint3BR,FootPositionBL);
    
        

    
%     disp("***************************************");

   

    
    function poly_line(p1,p2)
        xPosition = [p1(1) p2(1)];
        yPosition = [p1(2) p2(2)];
        zPosition = [p1(3) p2(3)];
        
        fill3(xPosition,yPosition,zPosition,[0 0 0]);
    end
    
    function cylinder(x,y,r,z1,z2)
        circleEdges = 16;
        %top
        angle = linspace(0,2*pi,circleEdges+1);
        pointX = x + r * cos(angle);
        pointY = y + r * sin(angle);
        pointZ = z1 + 0 * angle;
         
        fill3(pointX, pointY, pointZ, [1    0.3300    0.1000]);

        %bottom
        angle = linspace(0,2*pi,circleEdges+1);
        pointX = x + r * cos(angle);
        pointY = y + r * sin(angle);
        pointZ = z2 + 0 * angle;
              
        fill3(pointX, pointY, pointZ, [.7    0.3300    0.1000]);

    end
         
    function poly_rectangle(p1, p2, p3, p4)
        % The points must be in the correct sequence.
        % The coordinates must consider x, y and z-axes.
        xPosition = [p1(1) p2(1) p3(1) p4(1)];
        yPosition = [p1(2) p2(2) p3(2) p4(2)];
        zPosition = [p1(3) p2(3) p3(3) p4(3)];
        fill3(xPosition, yPosition, zPosition, [0.8500    0.3300    0.1000]);
        hold on
    end

    function poly_poly(p1, p2, p3, p4, p5, p6, p7, p8)
        % The points must be in the correct sequence.
        % The coordinates must consider x, y and z-axes.
        xPosition = [p1(1) p2(1) p3(1) p4(1) p5(1) p6(1) p7(1) p8(1)];
        yPosition = [p1(2) p2(2) p3(2) p4(2) p5(2) p6(2) p7(2) p8(2)];
        zPosition = [p1(3) p2(3) p3(3) p4(3) p5(3) p6(3) p7(3) p8(3)];
        fill3(xPosition, yPosition, zPosition, [0.8500    0.3300    0.1000]);
        hold on
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

