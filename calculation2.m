clear;clc;close all;
syms al thet alD thetD u
mp = 0.024; r = 0.085; lp = 0.13; Jp = 3.4E-5; g = 9.8; 
Ja = 5.7E-5; Cp = 5E-4; Ca = 0.015;

A = Ja+mp*r^2+mp*lp*sin(al)^2;
B = mp*r*lp*cos(al);
C = u - mp*lp^2*sin(2*al)*alD*thetD+mp*r*lp*alD^2*sin(al)-Ca*thetD;
E = Jp+mp*lp^2;
F = (1/2)*mp*lp^2*thetD^2*sin(2*al)-mp*g*lp*sin(al)-Cp*alD;

alphaDD = (B*C-A*F)/(B^2-A*E);
thetaDD = C/A-(B^2*C-A*B*F)/((B^2-A*E)*A);

%% Down Position
fa1 = diff(alphaDD,al); 
fa1 = double(subs(fa1,[al thet alD thetD], [0 0 0 0]));
fa2 = diff(alphaDD,thet); 
fa2 = double(subs(fa2,[al thet alD thetD], [0 0 0 0]));
fa3 = diff(alphaDD,alD); 
fa3  = double(subs(fa3,[al thet alD thetD], [0 0 0 0]));
fa4 = diff(alphaDD,thetD); 
fa4 = double(subs(fa4,[al thet alD thetD], [0 0 0 0]));
answ = [fa1 fa2 fa3 fa4];

fa1 = diff(thetaDD,al); 
fa1 = double(subs(fa1,[al thet alD thetD], [0 0 0 0]));
fa2 = diff(thetaDD,thet); 
fa2 = double(subs(fa2,[al thet alD thetD], [0 0 0 0]));
fa3 = diff(thetaDD,alD); 
fa3  = double(subs(fa3,[al thet alD thetD], [0 0 0 0]));
fa4 = diff(thetaDD,thetD); 
fa4 = double(subs(fa4,[al thet alD thetD], [0 0 0 0]));
answ = [fa1 fa2 fa3 fa4];

fa1 = diff(alphaDD,u); 
fa1 = double(subs(fa1,[al thet alD thetD], [0 0 0 0]));
fa2 = diff(thetaDD,u); 
fa2 = double(subs(fa2,[al thet alD thetD], [0 0 0 0]));

answ = [0 0 fa1 fa2];
%% Up Position
fa1 = diff(alphaDD,al); 
fa1 = double(subs(fa1,[al thet alD thetD], [pi 0 0 0]));
fa2 = diff(alphaDD,thet);
fa2 = double(subs(fa2,[al thet alD thetD], [pi 0 0 0]));
fa3 = diff(alphaDD,alD); 
fa3  = double(subs(fa3,[al thet alD thetD], [pi 0 0 0]));
fa4 = diff(alphaDD,thetD); 
fa4 = double(subs(fa4,[al thet alD thetD], [pi 0 0 0]));
answ = [fa1 fa2 fa3 fa4];

fa1 = diff(thetaDD,al); 
fa1 = double(subs(fa1,[al thet alD thetD], [pi 0 0 0]));
fa2 = diff(thetaDD,thet); 
fa2 = double(subs(fa2,[al thet alD thetD], [pi 0 0 0]));
fa3 = diff(thetaDD,alD); 
fa3  = double(subs(fa3,[al thet alD thetD], [pi 0 0 0]));
fa4 = diff(thetaDD,thetD); 
fa4 = double(subs(fa4,[al thet alD thetD], [pi 0 0 0]));
answ = [fa1 fa2 fa3 fa4];

fa1 = diff(alphaDD,u); 
fa1 = double(subs(fa1,[al thet alD thetD], [pi 0 0 0]));
fa2 = diff(thetaDD,u); 
fa2 = double(subs(fa2,[al thet alD thetD], [pi 0 0 0]));

answ = [0 0 fa1 fa2];
