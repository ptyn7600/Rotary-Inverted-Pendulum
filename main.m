clear;clc;
%% ===================== The initial look of the system
clear;clc;
x0 = [0.3 0 0 0]';
intro(x0);

% ====================== Linearize the system   
clear;clc;
t = 0:0.1:20;
xTilde = [0 0 0 0]';
[A,B] = linearize(xTilde);

x0 = [0.3 0 0 0]';  
[~,x] = ode45(@(t,x) simulate(A,x,xTilde),t,x0);
plot(t',x(:,1), 'LineWidth', 1); title('Alpha angle');
legend('Nonlinear System', 'Linearized System');
% fig2 = figure; plot(t',x(:,2)); title('Theta angle');

%% ====================== OBSERVER
clear; clc; close all;
pos = pi;
L = observerSystem(pos);

% Controller
K = controllerFeedback(pos);

% Full Dynamics System
x0sys    = [pos-0.1 0 0 0]'; 
xhat0 = [pos 0 0 0]'; x0 = [x0sys;xhat0];
t = [0:0.1:10];
C = [1 0 0 0; 0 1 0 0];
D = [0;0];
xtilde = [pos 0 0 0]';
utilde = 0;
x = full_system(t,x0,L,K,xtilde,utilde,C,D);
plot(t',x(:,1), 'LineWidth', 1); title('Alpha angle');


