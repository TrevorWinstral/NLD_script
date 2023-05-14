%% Initialize script

close all
clear
clc

%% Grid of initial conditions

xs = linspace(-pi,pi,100);
ys = linspace(-pi,pi,100);
[X0, Y0] = meshgrid(xs, ys);
nICs = 100 * 100;
%% ODE simulation
tic();
t0 = 20;
tend = 0;


Xvector = [X0(:), Y0(:)];
timeInterval = [t0, (t0 + tend)./2, tend];

[t, z] = ode45(@odefun, timeInterval, Xvector);
zfinal = z(end, :);
XF = reshape(zfinal(1:nICs), size(X0));
YF = reshape(zfinal(nICs + 1:end), size(Y0));


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
elapsed_time = toc();
disp(['Computation time was ', num2str(elapsed_time), ' s.']);
%
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

function [rhs] = odefun(t, X)

    nICs = length(X) / 2;

    a = 0.5; % or 0.5
    k = 0.1; % or 0.1
    
    x = X(1:nICs);
    xd = X(nICs+1 : end);
    rhs = zeros(size(X));
    rhs(1:nICs) = xd;
    rhs(nICs+1 : end) = a*sin(t) - sin(x) - k*xd;
end
