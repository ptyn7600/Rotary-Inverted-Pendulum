%%% ======================= Controller
%% Controllability
clear;clc;
x0 = [0 0 0 0]';
[A,B,C,D] = linearize(x0);
% state dimension
n = size(A,1);
% controllability matrix
P = ctrb(A,B);
% test if the system is controllable
controllable = ( rank(P) == n );
% basis for the controllable subspace (requires symbolic P)
ctrb_space = colspace(sym(P));

%% Design a controller
clear; clc; close all;

xtilde = [pi 0 0 0]';
utilde = 0;
x0 = [pi+1 0 0 0]';
[A,B,C,D] = linearize(xtilde);
sys = ss(A,B,C,D);

% time vector
tSpan = [0 20];

% number of states
n = size(A,1);

% cost matrices
Q = [1 0 0 0;   % angle of the pendulum
    0 1 0 0;    % angle of the arm
    0 0 1 0;   % velocity of the cart
    0 0 0 1]; % velocity of the arm
R = 0.1;     % force on the cart

% static state feedback using LQR
K = -lqr(A,B,Q,R);
eig(A+B*K)

% simulate the system
[t,x] = static_state_feedback(tSpan,x0,K,xtilde,utilde);
fig1 = figure; plot(t',x(:,1)); title('Alpha angle'); hold on;


%%% ======================= Observer
%% Observability
clear;clc;
x0 = [0 0 0 0]';
[A,B,C,D] = linearize(x0);
Q = [C;C*A;C*A^2;C*A^3];
n = size(A,1);
observable = ( rank(Q) == n );
eigV = eig(A);
% PBH test at all eigenvalues
detectable1 = rank([A-eigV(1)*eye(4,4);C])== size(A,1);
detectable2 = rank([A-eigV(2)*eye(4,4);C])== size(A,1);
detectable3 = rank([A-eigV(3)*eye(4,4);C])== size(A,1);
detectable4 = rank([A-eigV(4)*eye(4,4);C])== size(A,1);

%% ================================== Observer
% porcess noise
W = [1 0 0 0;   % angle of the pendulum
    0 1 0 0;    % angle of the arm
    0 0 1 0;   % velocity of the cart
    0 0 0 1]; % velocity of the arm
V = 0.5;     % measurement noise

% static state feedback using LQR
L = -lqr(A',C',W,V);
eig(A+L*C)

%% stop here
AA = [A zeros(n); -L*C A+L*C];
BB = [B; B];
CC = eye(8);
DD = zeros(8,1);

% closed-loop system
sys_cl = ss(AA,BB,CC,DD);

t     = linspace(0,100,1000);  % time vector
u     = ones(size(t))*0.5;         % input
x0    = zeros(4,1);            % initial state of the system (unknown!)
xhat0 = randn(4,1);            % initial state of the observer

% simulate the closed-loop system
[y,t] = lsim(sys_cl,u,t,[x0; xhat0]);

% subplot(2,2,1); plot(t,y(:,1),t,y(:,5)); xlabel('t'); ylabel('x_1(t)');
% subplot(2,2,3); plot(t,y(:,2),t,y(:,6)); xlabel('t'); ylabel('x_2(t)');
% subplot(2,2,2); plot(t,y(:,3),t,y(:,7)); xlabel('t'); ylabel('x_3(t)');
% subplot(2,2,4); plot(t,y(:,4),t,y(:,8)); xlabel('t'); ylabel('v_1(t)');
% subplot(3,2,4); plot(t,y(:,5),t,y(:,11)); xlabel('t'); ylabel('v_2(t)');
% subplot(3,2,6); plot(t,y(:,6),t,y(:,12)); xlabel('t'); ylabel('v_3(t)');
plot(t,y(:,1),t,y(:,5)); xlabel('t'); ylabel('x_1(t)');
sgtitle('Observer for Inverted Rotary Pendulum');
legend('Actual','Estimate');