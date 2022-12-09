function [] = ellipsoid(P,color)
% Plot the ellipsoid { x | x' P x <= 1 }.

if nargin < 2
    color = 'b';
end

PP = chol(P);

N = 100;

theta = linspace(0,2*pi,N);

X = zeros(2,N);

for k = 1:N
    X(:,k) = PP\[cos(theta(k)); sin(theta(k))];
end

fill(X(1,:),X(2,:),color,'FaceAlpha',0.3); hold on;

% [V,D] = eig(P);

% q1 = quiver(0,0,V(1,1),V(2,1),1/sqrt(D(1,1)),'ShowArrowHead','off','color','k');
% q2 = quiver(0,0,V(1,2),V(2,2),1/sqrt(D(2,2)),'ShowArrowHead','off','color','k');
% 
% set(get(get(q1,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');
% set(get(get(q2,'Annotation'),'LegendInformation'),'IconDisplayStyle','off');

end