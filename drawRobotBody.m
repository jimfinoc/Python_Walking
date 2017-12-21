function [ output_args ] = drawRobotBody()
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    close all
    figure
    hold on
    grid on
    view([1,1,0]);
    axis equal

    xMinRobotBody = -5;
    xMaxRobotBody =5;
    yMinRobotBody =-5;
    yMaxRobotBody =5;
    zRobotBodySurface = 3 ;
    zRobotBodyThickness = zRobotBodySurface - 2;
    
    p1 = [xMinRobotBody yMinRobotBody  zRobotBodySurface ];
    p2 = [xMaxRobotBody yMinRobotBody  zRobotBodySurface ];
    p3 = [xMaxRobotBody yMaxRobotBody  zRobotBodySurface ];
    p4 = [xMinRobotBody yMaxRobotBody  zRobotBodySurface ]; 
    p5 = [xMinRobotBody yMinRobotBody -zRobotBodyThickness];
    p6 = [xMaxRobotBody yMinRobotBody -zRobotBodyThickness];
    p7 = [xMaxRobotBody yMaxRobotBody -zRobotBodyThickness];
    p8 = [xMinRobotBody yMaxRobotBody -zRobotBodyThickness];

    poly_rectangle(p1, p2, p3, p4) %top surface
    poly_rectangle(p5, p6, p7, p8) %bottom surface
    poly_rectangle(p1, p2, p6, p5) %front surface
    poly_rectangle(p2, p3, p7, p6) %right surface
    poly_rectangle(p3, p4, p8, p7) %back surface
    poly_rectangle(p1, p4, p8, p5) %left surface

    
    
    function poly_rectangle(p1, p2, p3, p4)
        % The points must be in the correct sequence.
        % The coordinates must consider x, y and z-axes.
        x = [p1(1) p2(1) p3(1) p4(1)];
        y = [p1(2) p2(2) p3(2) p4(2)];
        z = [p1(3) p2(3) p3(3) p4(3)];
        fill3(x, y, z, [0.8500    0.3300    0.1000]);
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
        z = ones(1,N)*.1;
        [X,Y, Z] = pol2cart(angles,rho,z);
        X=X+center(1);
        Y=Y+center(2);
        Z = Z+center(3);
        h=fill3(X,Y,Z, color);
        %     rotate(h, [center(1),center(2), center(3)], theta); %rotating disk
    end


end

