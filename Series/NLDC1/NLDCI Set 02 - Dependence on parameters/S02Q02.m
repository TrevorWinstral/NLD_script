%% Initiate Script

close all
clear all
clc

%% define parameters

epsilon = 0.1;
omega = 2;
F = 1;

% initial condition
t0 = [F / (1 - omega.^2), 0]';

% time steps
tt_approx = 0:0.01:pi;
tt_sim = 0:0.01: 101 * pi;

%% Function and simulation

fun = @(t,x) [x(2); F*cos(omega * t) - epsilon * (x(1).^2 - 1).*x(2) - x(1)];

opts = odeset('RelTol',1e-4,'AbsTol',1e-6);
[~ , xtrue] = ode45(fun, tt_sim, t0, opts);

%% Approximation

xApprox = F * cos(omega .* tt_approx) / (1 - omega.^2);

%% Plot results

xtrue_steady_state = xtrue(end - length(xApprox) + 1: end, 1); % only take the last 315 values

figure(1)
hold on
plot(tt_approx, xtrue_steady_state,'linewidth',1.5,'DisplayName','ODE45');
plot(tt_approx, xApprox,'linewidth',1.5,'DisplayName','Approximation');
xlabel('$t$','interpreter','Latex','FontSize',16)
ylabel('$x$','interpreter','Latex','FontSize',16)
legnd1 = legend;
legnd1.NumColumns = 1;
legnd1.FontSize = 14;
hold off
grid on