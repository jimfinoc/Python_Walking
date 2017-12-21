function [ output_args ] = untitled2( input_args )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
X = [-10 -10 -10  10];
Y = [-10  10 -10 -10];
plot(X,Y) %outer box
hold on
footLF = [-5, 5,0] 
footRF = [ 5, 5,0]
footLB = [-5,-5,0]
footRB = [ 5,-5,0]

Xee = []
Xee = [footLF(1) footRF(1) footLB(1) footRB(1)]
Yee = [footLF(2) footRF(2) footLB(2) footRB(2)]
plot(Xee,Yee)

end

