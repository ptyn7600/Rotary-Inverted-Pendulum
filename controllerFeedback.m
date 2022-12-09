function [K] = controllerFeedback(up)
    
pos = up;

%% Controllability
xtilde = [pos 0 0 0]';
[A,B] = linearize(xtilde);
% state dimension
n = size(A,1);
% controllability matrix
P = ctrb(A,B);
% test if the system is controllable
controllable = ( rank(P) == n );
% basis for the controllable subspace (requires symbolic P)
ctrb_space = colspace(sym(P));

%% Design a controller
pos = 0;
xtilde = [pos 0 0 0]';
utilde = 0;
[A,B] = linearize(xtilde);

% time vector
t = [0:0.1:20];

% cost matrices
Q = [500 0 0 0;   % angle of the pendulum
    0 10 0 0;    % angle of the arm
    0 0 1 0;   % velocity of the cart
    0 0 0 1]; % velocity of the arm
R = 10;     % force on the arm

% static state feedback using LQR
K = -lqr(A,B,Q,R);
eig(A+B*K)
% 
% simulate the system
% x0 = xtilde + [0.1 0 0 0]';
% x = static_state_feedback(t,x0,K,xtilde,utilde);
% fig1 = figure; plot(t',x(:,1)); title('Alpha angle'); hold on;
end
