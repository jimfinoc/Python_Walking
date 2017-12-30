function Oi = calcOi(DH_table,i)
% CALCOI(DH_table,i) Given a DH table and index i, compute the position of
% origin of the ith frame
% Inputs:
%     DH_table: nX4 matrix with the parameters of each link as following:
%     [a , alpha , d , theta] 
%     i: link index
% Outputs:
%     Oi: 3x1 position vector of the origin of the ith frame
% HINT: Use the functions you created in part 1.

    T = calcT0n(DH_table(1:i,:));
    Oi = T*[0,0,0,1]';
    Oi = Oi(1:3);
%     disp("i")%~ JAMES - Looking at the output - label
%     disp(i); %~ JAMES - Looking at the output - data
%     disp("Oi"); %~ JAMES - Looking at the output - label
%     disp (Oi); %~ JAMES - Looking at the output - data
end

% function T = calcT0n(DH_table)
% % CALCT0N(DH_table) Given a DH table, compute transformation from EE to
% % base
% % Inputs:
% %     DH_table: nX4 matrix with the parameters of each link as following:
% %     [a , alpha , d , theta]
% % Outputs:
% %     T: 4x4 transformation matrix from End Effector to base frame
% % HINT: Use the function calcAi you created in part 1a
%     T = eye(4);  % initialize a homogeneous transformation
%     for j = 1:size(DH_table,1)
%         Aj = calcAi(DH_table,j);
%         T = T*Aj;
%     end
%     disp("T"); %~ JAMES - Looking at the output - label
%     disp(T);  %~ JAMES - Looking at the output - data
% end
% 
% function Ai = calcAi(DH_table,i)
% % CALCAI(DH_table,i) Given a DH table and index i, create matrix Ai
% % Inputs:
% %     DH_table: nX4 matrix with the parameters of each link as following:
% %     [a , alpha , d , theta]
% %     i: link index
% % Outputs:
% %     Ai: 4x4 transformation matrix (as explained in class)
% 
%     a_i = DH_table(i,1);
%     alpha_i = DH_table(i,2);
%     d_i = DH_table(i,3);
%     theta_i = DH_table(i,4);
%     Ai = [cos(theta_i)  -sin(theta_i)*cos(alpha_i)     sin(theta_i)*sin(alpha_i)    a_i*cos(theta_i);
%         sin(theta_i)    cos(theta_i)*cos(alpha_i)     -cos(theta_i)*sin(alpha_i)    a_i*sin(theta_i);
%         0               sin(alpha_i)                   cos(alpha_i)                 d_i                 ;
%         0               0                              0                            1                   ];
% end
