function [ output_feet ] = drawRobotBodyV2(step, direction_M_FB, direction_M_LR, direction_T_LR, head_M_UD, head_T_LR, input_feet, last_LR, last_UD)
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
    JointHeight = .5*(zRobotBodySurface+zRobotBodyThickness);

    
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

    Theta = [ 
        0 -pi/4 -pi/4; 
        0 -pi/4 -pi/4; 
        pi -pi/4 -pi/4; 
        pi -pi/4 -pi/4];
    
    
    
    Joint1_AbsolutePosition = [
        237/2 237/2 JointHeight;
        -237/2 237/2 JointHeight;
        237/2 -237/2 JointHeight;
        -237/2 -237/2 JointHeight]
    
    ground_pt1 = [0 0 0 ;0 0 0;0 0 0; 0 0 0];
    ground_pt2 = [0 0 0 ;0 0 0;0 0 0; 0 0 0];
    ground_pt3 = [0 0 0 ;0 0 0;0 0 0; 0 0 0];
    ground_pt4 = [0 0 0 ;0 0 0;0 0 0; 0 0 0];
    
    max_ground_pt = [0 0 0 ;0 0 0;0 0 0; 0 0 0];
    min_ground_pt = [0 0 0 ;0 0 0;0 0 0; 0 0 0];
    minmax_ground_pt = [0 0 0 ;0 0 0;0 0 0; 0 0 0];
    maxmin_ground_pt = [0 0 0 ;0 0 0;0 0 0; 0 0 0];
    center_ground_pt = [0 0 0 ;0 0 0;0 0 0; 0 0 0];
    
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
    ground_pt1(FR,:) = [170 0 0] + Joint1_AbsolutePosition(FR) + [0 0 -100];
    ground_pt2(FR,:) = [140 0 0] + Joint1_AbsolutePosition(FR) + [0 0 -100];
    ground_pt3(FR,:) = [155 75 0] + Joint1_AbsolutePosition(FR) + [0 0 -100];
    ground_pt4(FR,:) = [155 -75 0] + Joint1_AbsolutePosition(FR) + [0 0 -100];

    ground_pt1(BR,:) = [170 0 0] + Joint1_AbsolutePosition(BR) + [0 0 -100];
    ground_pt2(BR,:) = [140 0 0] + Joint1_AbsolutePosition(BR) + [0 0 -100];
    ground_pt3(BR,:) = [155 75 0] + Joint1_AbsolutePosition(BR) + [0 0 -100];
    ground_pt4(BR,:) = [155 -75 0] + Joint1_AbsolutePosition(BR) + [0 0 -100];

    ground_pt1(FL,:) = [170 0 0] + Joint1_AbsolutePosition(FL) + [0 0 -100];
    ground_pt2(FL,:) = [140 0 0] + Joint1_AbsolutePosition(FL) + [0 0 -100];
    ground_pt3(FL,:) = [155 75 0] + Joint1_AbsolutePosition(FL) + [0 0 -100];
    ground_pt4(FL,:) = [155 -75 0] + Joint1_AbsolutePosition(FL) + [0 0 -100];

    ground_pt1(BL,:) = [170 0 0] + Joint1_AbsolutePosition(BL) + [0 0 -100];
    ground_pt2(BL,:) = [140 0 0] + Joint1_AbsolutePosition(BL) + [0 0 -100];
    ground_pt3(BL,:) = [155 75 0] + Joint1_AbsolutePosition(BL) + [0 0 -100];
    ground_pt4(BL,:) = [155 -75 0] + Joint1_AbsolutePosition(BL) + [0 0 -100];
    
    disp("ground points");
    disp(ground_pt1);
    disp(ground_pt2);
    disp(ground_pt3);
    disp(ground_pt4);
    
    
    

    for leg = [FR BR FL BL]
        poly_rectangle(ground_pt1(leg,:),ground_pt3(leg,:),ground_pt2(leg,:),ground_pt4(leg,:));
        
        max_ground_pt(leg,:) = max(max(ground_pt1(leg,:),ground_pt2(leg,:)),(max(ground_pt3(leg,:),ground_pt4(leg,:))));
        min_ground_pt(leg,:) = min(min(ground_pt1(leg,:),ground_pt2(leg,:)),(min(ground_pt3(leg,:),ground_pt4(leg,:))));
        minmax_ground_pt(leg,:) = [min_ground_pt(leg,x) max_ground_pt(leg,y) 0];
        maxmin_ground_pt(leg,:) = [max_ground_pt(leg,x) min_ground_pt(leg,y) 0];
        center_ground_pt(leg,:) = [(max_ground_pt(leg,x)+min_ground_pt(leg,x))/2 (max_ground_pt(leg,y)+min_ground_pt(leg,y))/2  0];

        poly_rectangle(max_ground_pt(leg,:),minmax_ground_pt(leg,:),min_ground_pt(leg,:),maxmin_ground_pt(leg,:));

        %draws the four first joints
        cylinder(Joint1_AbsolutePosition(leg,x),Joint1_AbsolutePosition(leg,y),10,zRobotBodySurface,zRobotBodyThickness);



        if direction_T_LR == 0
            input_feet(leg,x) = input_feet(leg,x) - direction_M_LR;
            input_feet(leg,y) = input_feet(leg,y) - direction_M_FB;
        else
            input_feet(leg,x) = input_feet(leg,x) - direction_M_LR;
            input_feet(leg,y) = input_feet(leg,y) - direction_M_FB;
            turn(leg) = (atan2(input_feet(leg,y)+Joint1_AbsolutePosition(leg,y),input_feet(leg,x)+Joint1_AbsolutePosition(leg,x))+direction_T_LR_max*3/2/180*pi);
            turnX(leg) = hypot(input_feet(leg,y)+Joint1_AbsolutePosition(leg,y),input_feet(leg,x)+Joint1_AbsolutePosition(leg,x))*cos(turn(leg));
            turnY(leg) = hypot(input_feet(leg,y)+Joint1_AbsolutePosition(leg,y),input_feet(leg,x)+Joint1_AbsolutePosition(leg,x))*sin(turn(leg));
    %         disp("hypot of turnX and turnY");
    %         disp(hypot(turnX,turnY));
            input_feet(leg,x) = turnX(leg) - Joint1_AbsolutePosition(leg,x);
            input_feet(leg,y) = turnY(leg) - Joint1_AbsolutePosition(leg,y);
        end    


        %******************************
        if input_feet(leg,z) > -100
            input_feet(leg,z) = -100;
            if direction_M_FB > 0
                input_feet(leg,y) = input_feet(leg,y) + 5*direction_M_FB;
            elseif direction_M_FB < 0
                input_feet(leg,y) = input_feet(leg,y) + 5*direction_M_FB;
            end
            if direction_M_LR > 0
                input_feet(leg,x) = input_feet(leg,x) + 5*direction_M_LR;
            elseif direction_M_LR < 0
                input_feet(leg,x) = input_feet(leg,x) + 5*direction_M_LR;
            end

        end


        if (step == 1 & leg == FR) | (step == 3 & leg == BR) | (step == 5 & leg == FL) | (step == 7 & leg == BL) 
            if input_feet(leg,x) > max_ground_pt(leg,x) - Joint1_AbsolutePosition(leg,x)
                input_feet(leg,x) = center_ground_pt(leg,x) - Joint1_AbsolutePosition(leg,x);
                input_feet(leg,y) = center_ground_pt(leg,y) - Joint1_AbsolutePosition(leg,y);
                input_feet(leg,z) = center_ground_pt(leg,z)+10 - Joint1_AbsolutePosition(leg,z);
                disp("overstep x");

            elseif input_feet(leg,y) > max_ground_pt(y) -Joint1_AbsolutePosition(leg,y)
                input_feet(leg,x) = center_ground_pt(x) -Joint1_AbsolutePosition(leg,x);
                input_feet(leg,y) = center_ground_pt(y) -Joint1_AbsolutePosition(leg,y);
                input_feet(leg,z) = center_ground_pt(z)+10 -Joint1_AbsolutePosition(leg,z);
                disp("overstep y");
            elseif input_feet(leg,x) < min_ground_pt(x) -Joint1_AbsolutePosition(leg,x)
                input_feet(leg,x) = center_ground_pt(x) -Joint1_AbsolutePosition(leg,x);
                input_feet(leg,y) = center_ground_pt(y) -Joint1_AbsolutePosition(leg,y);
                input_feet(leg,z) = center_ground_pt(z)+10 -Joint1_AbsolutePosition(leg,z);
                disp("understep x");
            elseif input_feet(leg,y) < min_ground_pt(y) -Joint1_AbsolutePosition(leg,y)
                input_feet(leg,x) = center_ground_pt(x) -Joint1_AbsolutePosition(leg,x);
                input_feet(leg,y) = center_ground_pt(y) -Joint1_AbsolutePosition(leg,y);
                input_feet(leg,z) = center_ground_pt(z)+10 -Joint1_AbsolutePosition(leg,z);
                disp("understep y");
            end
        end

        desired_RelativePosition = [input_feet(leg,x) input_feet(leg,y) input_feet(leg,z)];

        S_leg = desired_RelativePosition(z);

        Theta(leg,1) = atan2(desired_RelativePosition(y),desired_RelativePosition(x));
        R_leg = hypot(desired_RelativePosition(x)-a1*cos(Theta(1)),desired_RelativePosition(y)-a1*sin(Theta(1)));

        D_leg = (S_leg^2+R_leg^2-a2^2-a3^2)/(2*a2*a3);
        if D_leg > 1
            D_leg = 1;
        end
        disp('leg')
        disp(leg)
        disp('D_leg')
        disp(D_leg)

        Theta(leg,3) = atan2(-sqrt(1-D_leg^2),D_leg);
        Theta(leg,2) = atan2(S_leg,R_leg)-atan2(a3*sin(Theta(3)),a2+a3*cos(Theta(3)));

        leg_DH = [a1 pi/2 0 Theta(leg,1); a2 0 0 Theta(leg,2); a3 0 0 Theta(leg,3)];

        Joint2A_leg = calcAi(leg_DH, 1);
        Joint2leg = [Joint2A_leg(1,4)+Joint1_AbsolutePosition(leg,x) Joint2A_leg(2,4)+Joint1_AbsolutePosition(leg,y) Joint2A_leg(3,4)+Joint1_AbsolutePosition(leg,3)];
        Joint3A_leg = calcAi(leg_DH, 1)*calcAi(leg_DH, 2);
        Joint3leg = [Joint3A_leg(1,4)+Joint1_AbsolutePosition(leg,1) Joint3A_leg(2,4)+Joint1_AbsolutePosition(leg,2) Joint3A_leg(3,4)+Joint1_AbsolutePosition(leg,3)];
        FootAMatrix_leg = calcAi(leg_DH, 1) * calcAi(leg_DH, 2) * calcAi(leg_DH, 3);
        FootPositionLeg = [FootAMatrix_leg(1,4)+Joint1_AbsolutePosition(leg,x) FootAMatrix_leg(2,4)+Joint1_AbsolutePosition(leg,y) FootAMatrix_leg(3,4)+Joint1_AbsolutePosition(leg,z)];

        output_feet = zeros(4,3);
        output_feet(leg,:) = [FootAMatrix_leg(x,4) FootAMatrix_leg(y,4) FootAMatrix_leg(z,4)];

        poly_line(Joint1_AbsolutePosition(leg,:),Joint2leg);
        poly_line(Joint2leg,Joint3leg);
        poly_line(Joint3leg,FootPositionLeg);
    
    end

    
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

