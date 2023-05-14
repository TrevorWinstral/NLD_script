%% Initialize script

close all
clear
clc

%% Grid of initial conditions

xs = linspace(-pi,pi,100);
ys = linspace(-pi,pi,100);
[X0, Y0] = meshgrid(xs,ys);
nICs = 100 * 100;
%% ODE simulation

t0 = 0;
tend = 2 * pi * 400;


Xvector = [X0(:), Y0(:)];
timeInterval = [t0, (t0 + tend)./2, tend];

[t, z] = ode45(@odefun, timeInterval, Xvector);

zFinal = z(end, :);
XF = reshape(zFinal(1:nICs), size(X0));
YF = reshape(zFinal(nICs + 1:end), size(Y0));

figure(1)
plot(mod(XF(:), 2*pi), YF(:), '.');


axis tight
xlabel('$x$', 'interpreter','latex')
ylabel('$\dot{x}$', 'interpreter','latex')

%% Function to simulate

function [rhs] = odefun(t,X)

    nICs = length(X) / 2;

    a = 0.5; % or 0.5
    k = 0.1; % or 0.1
    
    x = X(1:nICs);
    xd = X(nICs+1 : end);
    rhs = zeros(size(X));
    rhs(1:nICs) = xd;
    rhs(nICs+1 : end) = a*sin(t) - sin(x) - k*xd;
end
