function [x] = static_state_feedback(t,x0,K,xtilde,utilde)

u = @(x) utilde + K*(x - xtilde);

[~,x] = ode45(@(t,x) dynamics(x,u(x)),t,x0);

end