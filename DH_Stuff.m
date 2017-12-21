a1 = sym("a1");
d1 = sym("d1");
theta1 = sym("theta1");
alpha1 = sym("alpha1");

a2 = sym("a2");
d2 = sym("d2");
theta2 = sym("theta2");
alpha2 = sym("alpha2");


a3 = sym("a3");
d3 = sym("d3");
theta3 = sym("theta3");
alpha3 = sym("alpha3");

a4 = sym("a4");
d4 = sym("d4");
theta4 = sym("theta4");
alpha4 = sym("alpha4");

% DH_Row = [a1 alpha1,d1,theta1];

DH_Table = [a1 alpha1 d1 theta1;a2 alpha2 d2 theta2;a3 alpha3 d3 theta3];
DH_Table = [a1 pi/2 0 theta1;a2 0 0 theta2;a3 0 0 theta3];
DH_Row1 = [a1 pi/2 0 theta1]
DH_Row2 = [a2 0 0 theta2]
DH_Row3 = [a3 0 0 theta3]

% DH_Row = [a1 alpha1,d1,theta1];
DH_Row1 = [0 pi/2 -d1 theta1]
DH_Row2 = [a2 0 0 theta2]
DH_Row3 = [a3 0 0 theta3]
% DH_Row4 = [a4 0 d4 0]
% DH_Table = [DH_Row1 ;DH_Row2 ;DH_Row3;DH_Row4]
DH_Table = [DH_Row1 ;DH_Row2 ;DH_Row3]
CalcT ( DH_Table)

