function [] = intro(x0)
% Initial condition
% time vector
t = 0:0.1:20;
% My dynamics system
[~,x] = ode45(@(t,x) dynamics(x),t,x0);
fig1 = figure; plot(t',x(:,1), 'LineWidth', 1); title('Alpha angle'); hold on;
xlabel('Time(Seconds)');ylabel('Radian');
% fig2 = figure; plot(t',x(:,2)); title('Theta angle');
end
