function [ A_Matrix ] = CalcDH( DH_Row )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%   DH_Row in the form of [a,alpha,d,theta]

a = DH_Row(1);
alpha = DH_Row(2);
d = DH_Row(3);
theta = DH_Row(4);

a_part = [ 1 0 0 a; 0 1 0 0 ; 0 0 1 0; 0 0 0 1];
alpha_part = [ 1 0 0 0; 0 cos(alpha) -sin(alpha) 0 ; 0 sin(alpha) cos(alpha) 0; 0 0 0 1];
d_part = [ 1 0 0 0; 0 1 0 0 ; 0 0 1 d; 0 0 0 1];
theta_part = [ cos(theta) -sin(theta) 0 0; sin(theta) cos(theta) 0 0 ; 0 0 1 0; 0 0 0 1];

A_Matrix = theta_part * d_part * a_part * alpha_part;

end

