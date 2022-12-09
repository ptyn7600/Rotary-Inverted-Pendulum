%% ================================================================
clear;clc;
syms thtaDD alphaDD
syms Ja mp r lp sAlpha s2Alpha alphaD thetaD cAlpha Ca Tau
syms Jp g Cp

eq1 = (Ja+mp*r^2)*thtaDD + mp*lp^2*sAlpha^2*thtaDD + mp*lp^2*s2Alpha*alphaD*thetaD...
+ mp*r*lp*alphaDD*cAlpha - mp*r*lp*alphaD^2*sAlpha + Ca*thetaD == Tau;

eq2 = (Jp+mp*lp^2)*alphaDD + mp*r*lp*thtaDD*cAlpha - (1/2)*mp*lp^2*thetaD^2*s2Alpha...
+ mp*g*lp*sAlpha+Cp*alphaD == 0;

eqns = [eq1, eq2];
S = solve(eqns,[thtaDD alphaDD]);


% =======================================================================
const = [Tau; 0];
C = [0; mp*g*lp*sAlpha];
B = [(1/2)*mp*lp^2*s2Alpha*alphaD+Ca (1/2)*mp*lp^2*s2Alpha*thetaD - mp*r*lp*alphaD*sAlpha;...
      (-1/2)*mp*lp^2*thetaD*s2Alpha Cp];
A = [Ja + mp*r^2 + mp*lp^2*sAlpha^2 mp*r*lp*cAlpha; mp*r*lp*cAlpha Jp+mp*lp^2];
anst = A\(const - C - B*[thetaD; alphaD]);

S.thtaDD - anst(1);
S.alphaDD - anst(2)


%% ======================================================================
clear;clc;
syms thtaDD alphaDD
syms Ja mp r lp Alpha Theta alphaD thetaD Ca Tau
syms Jp g Cp

eq1 = (Ja+mp*r^2)*thtaDD + mp*lp^2*((sin(Alpha))^2)*thtaDD + mp*lp^2*sin(2*Alpha)*alphaD*thetaD...
+ mp*r*lp*alphaDD*cos(Alpha) - mp*r*lp*alphaD^2*sin(Alpha) + Ca*thetaD == Tau;

eq2 = (Jp+mp*lp^2)*alphaDD + mp*r*lp*thtaDD*cos(Alpha) - (1/2)*mp*lp^2*thetaD^2*sin(2*Alpha)...
+ mp*g*lp*sin(Alpha)+Cp*alphaD == 0;

eqns = [eq1, eq2];
S = solve(eqns,[thtaDD alphaDD]);

A11 = diff(S.alphaDD,Alpha); A12 = diff(S.alphaDD,Theta); 
A13 = diff(S.alphaDD,alphaD); A14 = diff(S.alphaDD,thetaD);

A21 = diff(S.thtaDD,Alpha); A22 = diff(S.thtaDD,Theta); 
A23 = diff(S.thtaDD,alphaD); A24 = diff(S.thtaDD,thetaD);

J1 = [0 0 1 0; 0 0 0  1; A11 A12 A13 A14; A21 A22 A23 A24];
var = [4.7E-5 0.024 0.085 0.13 0.1 3.4E-5 9.8 5E-5]; %Ja mp r lp Ca Jp g Cp
var = [5.7E-5 0.024 0.085 0.13 0.0015 3.4E-5 9.8 5E-4]; %Ja mp r lp Ca Jp g Cp

B3 = diff(S.alphaDD,Tau); B4 = diff(S.thtaDD,Tau);
J2 = [0; 0; B3; B4];


% My system
A = double(subs(J1,[Alpha alphaD thetaD Ja mp r lp Ca Jp g Cp],[0 0 0 var]));
B = double(subs(J2,[Alpha alphaD thetaD Ja mp r lp Ca Jp g Cp],[0 0 0 var]));
C = [1 0 0 0; 0 1 0 0]; D = 0;

As = double(subs(J1,[Alpha alphaD thetaD Ja mp r lp Ca Jp g Cp],[-pi 0 0 var]));
Bs = double(subs(J2,[Alpha alphaD thetaD Ja mp r lp Ca Jp g Cp],[-pi 0 0 var]));
Cs = [1 0 0 0; 0 1 0 0]; Ds = 0;

