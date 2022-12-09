function dx = dynamics(x,u)
if nargin < 2
    u = zeros(1,1);
end

mp = 0.024; r = 0.085; lp = 0.13; Jp = 3.4E-5; g = 9.8; 
Ja = 5.7E-5; Cp = 5E-4; Ca = 0.015;

cAlpha = cos(x(1)); sAlpha = sin(x(1));
alphaD = x(3); thetaD = x(4); s2Alpha = sin(2*x(1));


A = Ja+mp*r^2+mp*lp*sAlpha^2;
B = mp*r*lp*cAlpha;
C = u - mp*lp^2*s2Alpha*alphaD*thetaD+mp*r*lp*alphaD^2*sAlpha - Ca*thetaD;
E = Jp+mp*lp^2;
F = (1/2)*mp*lp^2*thetaD^2*s2Alpha-mp*g*lp*sAlpha-Cp*alphaD;

alphaDD = (B*C-A*F)/(B^2-A*E);
thetaDD = C/A-(B^2*C-A*B*F)/((B^2-A*E)*A);


dx(1,1) = alphaD;
dx(2,1) = thetaD;
dx(3,1) = alphaDD;
dx(4,1) = thetaDD;

end