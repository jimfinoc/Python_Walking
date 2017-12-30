function drawTable(TableDimensions)
% DRAWROBOT(DH_table) Given a DH table plot the robot at the describe
% configuration
% Inputs:
%     TableDimensions: 8x1 matrix with the parameters of the table to be drawn:
%     [xMinTable, yMinTable, xMaxTable, yMaxTable, zTableSurface, zTableThickness, legSquareThickness, legHeight,]
%     example values are [0, 0, 10, 10, 0, 2, 1, 12

    close all
    figure
    hold on
    grid on
    view([-1,-.05,1]);
    axis equal
    
%     numOfJoints = size(DH_table,1);
%     O = zeros(3,numOfJoints+1);
%     for i = 1:numOfJoints
%         O(:,i+1) = calcOi(DH_table,i);
%         plotLink(O(:,i),O(:,i+1));
%      
%     end
%     
%     xlabel('x'); ylabel('y'); zlabel('z');
%     plotBall(O(:,end),1,'red') % The End Effector?
    
    %plot table
    % table surface coordinates
    xMinTable = TableDimensions(1);
    yMinTable = TableDimensions(2);
    xMaxTable = TableDimensions(3);
    yMaxTable = TableDimensions(4);
    % other key table coordinate points
    zTableSurface = TableDimensions(5);
    zTableThickness = TableDimensions(6);
    legSquareThickness = TableDimensions(7);
    legHeight = TableDimensions(8);
    
    % table 
    p1 = [xMinTable yMinTable  zTableSurface ];
    p2 = [xMaxTable yMinTable  zTableSurface ];
    p3 = [xMaxTable yMaxTable  zTableSurface ];
    p4 = [xMinTable yMaxTable  zTableSurface ]; 
    p5 = [xMinTable yMinTable -zTableThickness];
    p6 = [xMaxTable yMinTable -zTableThickness];
    p7 = [xMaxTable yMaxTable -zTableThickness];
    p8 = [xMinTable yMaxTable -zTableThickness];
    % leg 1 data
    p1a = [xMinTable                        yMinTable+legSquareThickness    zTableSurface ];
    p1b = [xMinTable+legSquareThickness     yMinTable                       zTableSurface ];
    p1c = [xMinTable+legSquareThickness     yMinTable+legSquareThickness    zTableSurface ];
    p9 = [xMinTable                         yMinTable                       zTableSurface-legHeight ];
    p9a = [xMinTable                        yMinTable+legSquareThickness    zTableSurface-legHeight ];
    p9b = [xMinTable+legSquareThickness     yMinTable                       zTableSurface-legHeight ];
    p9c = [xMinTable+legSquareThickness     yMinTable+legSquareThickness    zTableSurface-legHeight ];
    % leg 2 data
    p2a = [xMaxTable                        yMinTable+legSquareThickness    zTableSurface ];
    p2b = [xMaxTable-legSquareThickness     yMinTable                       zTableSurface ];
    p2c = [xMaxTable-legSquareThickness     yMinTable+legSquareThickness    zTableSurface ];
    p10 = [xMaxTable                        yMinTable                       zTableSurface-legHeight ];
    p10a = [xMaxTable                       yMinTable+legSquareThickness    zTableSurface-legHeight ];
    p10b = [xMaxTable-legSquareThickness    yMinTable                       zTableSurface-legHeight ];
    p10c = [xMaxTable-legSquareThickness    yMinTable+legSquareThickness    zTableSurface-legHeight ];
    % leg 3 data
    p3a = [xMaxTable                        yMaxTable-legSquareThickness    zTableSurface ];
    p3b = [xMaxTable-legSquareThickness     yMaxTable                       zTableSurface ];
    p3c = [xMaxTable-legSquareThickness     yMaxTable-legSquareThickness    zTableSurface ];
    p11 = [xMaxTable                        yMaxTable                       zTableSurface-legHeight ];
    p11a = [xMaxTable                       yMaxTable-legSquareThickness    zTableSurface-legHeight ];
    p11b = [xMaxTable-legSquareThickness    yMaxTable                       zTableSurface-legHeight ];
    p11c = [xMaxTable-legSquareThickness    yMaxTable-legSquareThickness    zTableSurface-legHeight ];
    % leg 4 data
    p4a =   [xMinTable                        yMaxTable-legSquareThickness    zTableSurface ];
    p4b =   [xMinTable+legSquareThickness     yMaxTable                       zTableSurface ];
    p4c =   [xMinTable+legSquareThickness     yMaxTable-legSquareThickness    zTableSurface ];
    p12 =   [xMinTable                        yMaxTable                       zTableSurface-legHeight ];
    p12a =  [xMinTable                        yMaxTable-legSquareThickness    zTableSurface-legHeight ];
    p12b =  [xMinTable+legSquareThickness     yMaxTable                       zTableSurface-legHeight ];
    p12c =   [xMinTable+legSquareThickness     yMaxTable-legSquareThickness    zTableSurface-legHeight ];
    % draw table
    poly_rectangle(p1, p2, p3, p4) %top surface
    poly_rectangle(p5, p6, p7, p8) %bottom surface
    poly_rectangle(p1, p2, p6, p5) %front surface
    poly_rectangle(p2, p3, p7, p6) %right surface
    poly_rectangle(p3, p4, p8, p7) %back surface
    poly_rectangle(p1, p4, p8, p5) %left surface
    % draw leg 1
    poly_rectangle(p1, p1a, p9a, p9) %outside y surface
    poly_rectangle(p1, p1b, p9b, p9) %outside x surface
    poly_rectangle(p1c, p1a, p9a, p9c) %inside x surface
    poly_rectangle(p1c, p1b, p9b, p9c) %inside y surface
    % draw leg 2
    poly_rectangle(p2, p2a, p10a, p10) %outside y surface
    poly_rectangle(p2, p2b, p10b, p10) %outside x surface
    poly_rectangle(p2c, p2a, p10a, p10c) %inside x surface
    poly_rectangle(p2c, p2b, p10b, p10c) %inside y surface
    % draw leg 3
    poly_rectangle(p3, p3a, p11a, p11) %outside y surface
    poly_rectangle(p3, p3b, p11b, p11) %outside x surface
    poly_rectangle(p3c, p3a, p11a, p11c) %inside x surface
    poly_rectangle(p3c, p3b, p11b, p11c) %inside y surface
    % draw leg 4
    poly_rectangle(p4, p4a, p12a, p12) %outside y surface
    poly_rectangle(p4, p4b, p12b, p12) %outside x surface
    poly_rectangle(p4c, p4a, p12a, p12c) %inside x surface
    poly_rectangle(p4c, p4b, p12b, p12c) %inside y surface

function poly_rectangle(p1, p2, p3, p4)
    % The points must be in the correct sequence.
    % The coordinates must consider x, y and z-axes.
    x = [p1(1) p2(1) p3(1) p4(1)];
    y = [p1(2) p2(2) p3(2) p4(2)];
    z = [p1(3) p2(3) p3(3) p4(3)];
    fill3(x, y, z, [0.8500    0.3300    0.1000]);
    hold on
    end

end
