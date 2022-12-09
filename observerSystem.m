function L = observerSystem(up)
pos = up;
%% Observer
xtilde = [pos 0 0 0]';
[A,B] = linearize(xtilde);
% number of states
n = size(A,1);
% measure alpha angle and theta angle 
C = [1 0 0 0; 0 1 0 0];
D = [0;0];

% check observability
rankQ = rank(obsv(A,C)); observable = (rank(obsv(A,C)) == n);
% PBH test at all eigenvalues
eigV = eig(A);
detectable1 = rank([A-eigV(1)*eye(4,4);C])== size(A,1);
detectable2 = rank([A-eigV(2)*eye(4,4);C])== size(A,1);
detectable3 = rank([A-eigV(3)*eye(4,4);C])== size(A,1);
detectable4 = rank([A-eigV(4)*eye(4,4);C])== size(A,1);

% Use LQR to place the poles
W = [100 0 0 0;   % angle of the pendulum
    0 1 0 0;    % angle of the arm
    0 0 1 0;   % velocity of the cart
    0 0 0 1] ;
V = [1 0 ; 
     0 1];
L = (-lqr(A',C',W,V))';

% closed-loop poles
eig(A+L*C)
end

%% system from input u to output [x; hat(x)] with state [x; hat(x)]
% AA = [A zeros(n); -L*C A+L*C];
% BB = [B; B];
% CC = eye(8);
% DD = zeros(8,1);
% 
% % closed-loop system
% sys_cl = ss(AA,BB,CC,DD);
% 
% t     = linspace(0,80,1000);  % time vector
% u     = zeros(size(t))*0.5;    % input
% x0    = [0+0.3 0 0 0]';            
% % x0 = randn(4,1);               % initial state of the system (unknown!)
% xhat0 = randn(4,1);            % initial state of the observer
% 
% % simulate the closed-loop system
% [y,t] = lsim(sys_cl,u,t,[x0; xhat0]);
% 
% plot(t,y(:,1),t,y(:,5)); xlabel('t'); ylabel('x_1(t)');
% sgtitle('Observer (Alpha Angle)');
% legend('Actual','Estimate');
% 
% figure; 
% plot(t,y(:,2),t,y(:,6)); xlabel('t'); ylabel('x_1(t)');
% sgtitle('Observer (Theta Angle)');
% legend('Actual','Estimate');
% end