%% Initialize script

close all
clear
clc

%% Grid of initial conditions

xs = linspace(-pi,pi,100);
ys = linspace(-pi,pi,100);
[X0, Y0] = meshgrid(xs,ys);

%% ODE simulation

t0 = 20;
tend = 0;

XF = zeros(size(X0));
YF = zeros(size(Y0));

for i = 1:size(X0,1)
    for j = 1:size(X0,2)
        x0 = X0(i,j);
        y0 = Y0(i,j);
        
        [t, z] = ode45(@odefun, [t0 tend], [x0,y0]);
        
        XF(i,j) = z(end,1);
        YF(i,j) = z(end,2);
    end
end

%% Deformation Gradient

[DFxx, DFxy] = gradient(XF, xs, ys);
[DFyx, DFyy] = gradient(YF, xs, ys);

%% Cauchy Green Strain Tensor Components

C11 = DFxx.^2 + DFyx.^2;
C12 = DFxx.*DFxy + DFyx.*DFyy;
C21 = C12;
C22 = DFxy.^2 + DFyy.^2;

%% Largest eigenvalue of Cauchy Green Strain Tensor

detC = C11.*C22 - C12.*C21;
traceC = C11 + C22;

lambda = real(traceC./2 + sqrt((traceC./2).^2 - detC));

%% PLot FTLE

FTLE = log(lambda)/(2*abs(tend-t0));

figure(1)
title('FTLE${}^{20}_0$', 'interpreter', 'latex')
surf(X0,Y0, FTLE, 'EdgeColor','none');
colorbar

axis tight
xlabel('$x$', 'interpreter','latex')
ylabel('$\dot{x}$', 'interpreter','latex')



%% Function to simulate

function [rhs] = odefun(t,X)
    a = 0.0; % or 0.5
    k = 0.0; % or 0.1
    
    x = X(1);
    xd = X(2);
    
    rhs = [xd;
            a*sin(t) - sin(x) - k*xd];
end
