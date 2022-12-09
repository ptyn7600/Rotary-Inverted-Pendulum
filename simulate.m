function dx = simulate(A,x,xTilde)
alphaDD = A(3,:)*(x-xTilde);
thetaDD = A(4,:)*(x-xTilde);

dx(1,1) = x(3)-xTilde(3);
dx(2,1) = x(4)-xTilde(4);
dx(3,1) = alphaDD;
dx(4,1) = thetaDD;
end