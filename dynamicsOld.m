function dx = dynamicsOld(x,u)
if nargin < 2
    u = zeros(1,1);
end
% Ja = 4.7E-5; 
mp = 0.024; r = 0.085; lp = 0.13; Jp = 3.4E-5; g = 9.8; 
% Cp = 0; Ca = 0;
% Cp = 5E-5 ; Ca = 0.1;
Ja = 5.7E-5; Cp = 5E-4; Ca = 0.0015;

cAlpha = cos(x(1)); sAlpha = sin(x(1)); 

deno = 2*(-cAlpha^2*lp^2*mp^2*r^2 + lp^4*mp^2*sAlpha^2 + lp^2*mp^2*r^2 ...
+ Jp*lp^2*mp*sAlpha^2 + Ja*lp^2*mp + Jp*mp*r^2 + Ja*Jp);


alphaD = x(3); thetaD = x(4); s2Alpha = sin(2*x(1));
thetaDD = 2*r*sAlpha*alphaD^2*lp^3*mp^2+2*Jp*r*sAlpha*alphaD^2*lp*mp - 2*s2Alpha*alphaD*lp^4*mp^2*thetaD ...
    - 2*Jp*s2Alpha*alphaD*lp^2*mp*thetaD + 2*Cp*cAlpha*r*alphaD*lp*mp - cAlpha*r*s2Alpha*lp^3*mp^2*thetaD^2 ...
    + 2*cAlpha*g*r*sAlpha*lp^2*mp^2-2*Ca*lp^2*mp*thetaD+2*u*lp^2*mp - 2*Ca*Jp*thetaD+2*Jp*u;
thetaDD = thetaDD/deno;


alphaDD = -(2*cAlpha*alphaD^2*lp^2*mp^2*r^2*sAlpha-2*cAlpha*s2Alpha*alphaD*lp^3*mp^2*r*thetaD + 2*Cp*alphaD*lp^2*mp*sAlpha^2 + ...
    2*Cp*alphaD*mp*r^2 + 2*Cp*Ja*alphaD - s2Alpha*lp^4*mp^2*sAlpha^2*thetaD^2 + 2*g*lp^3*mp^2*sAlpha^3 - s2Alpha*lp^2*mp^2*r^2*thetaD^2 - ...
    Ja*s2Alpha*lp^2*mp*thetaD^2 + 2*g*lp*mp^2*r^2*sAlpha-2*Ca*cAlpha*lp*mp*r*thetaD + 2*u*cAlpha*lp*mp*r + 2*Ja*g*lp*mp*sAlpha);
alphaDD = alphaDD/deno;

dx(1,1) = alphaD;
dx(2,1) = thetaD;
dx(3,1) = alphaDD;
dx(4,1) = thetaDD;

end