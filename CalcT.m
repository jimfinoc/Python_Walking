function [ T_Matrix ] = CalcT( DH_Table )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here


    [row,column] = size(DH_Table)
    A = (zeros(4,4,row));
    T = (zeros(4,4,row));
    
    for i = 1:row
        A(:,:,i) = CalcDH( DH_Table(i,:) );
        if i == 1
            T(:,:,i) = A(:,:,i);
        else
            T(:,:,i) = T(:,:,i-1) * A(:,:,i);
        end
    end
    disp(A)
    disp(T)
    T_Matrix = T;
end
