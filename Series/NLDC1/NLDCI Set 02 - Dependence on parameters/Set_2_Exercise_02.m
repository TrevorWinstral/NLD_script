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
tt_sim = tt_approx;

%% Function and simulation

fun = @(t,x) [x(2); F*cos(omega * t) -  epsilon * (x(1).^2 - 1).*x(2) - x(1)];

opts = odeset('RelTol',1e-4,'AbsTol',1e-6);
[~ , xtrue] = ode45(fun, tt_sim, t0, opts);

%% Approximation

xApprox = F * cos(omega .* tt_approx) / (1 - omega.^2);

%% Plot results

figure(1)
hold on
plot(tt_sim, xtrue(:,1),'linewidth',1.5,'DisplayName','ODE45');
plot(tt_approx, xApprox,'linewidth',1.5,'DisplayName','O(1) Approximation');
xlabel('$t$','interpreter','Latex','FontSize',16)
ylabel('$x$','interpreter','Latex','FontSize',16)
legnd1 = legend;
legnd1.NumColumns = 1;
legnd1.FontSize = 14;
xlim([0, pi])
hold off
grid on

%% Print the error

error = max( abs( xtrue(:,1)' - xApprox));
string_to_print = ['With $\varepsilon$=', num2str(epsilon), ' the maximal error is ', num2str(error)];
text(1, -0.25, string_to_print, 'interpreter','Latex');

%%
C = F/(1-omega.^2);
H = omega*C*(C^2/4 -1)/(1-omega^2);
J = C^3*omega /(4*(1-9*omega^2));
xd01 = epsilon * (H*omega + 3*J*omega);
t1 = t0 + [0; xd01];
xApprox = F * cos(omega .* tt_approx) / (1 - omega.^2) + epsilon * H * sin(omega*tt_approx);
xApprox = xApprox + epsilon * J * sin(3*omega*tt_approx);

fun = @(t,x) [x(2); F*cos(omega * t) -  epsilon * (x(1).^2 - 1).*x(2) - x(1)];

opts = odeset('RelTol',1e-4,'AbsTol',1e-6);
[~ , xtrue] = ode45(fun, tt_sim, t1, opts);



figure(2)
hold on
plot(tt_sim(1:10:end), xtrue(1:10:end,1),'o','DisplayName','ODE45');
plot(tt_approx, xApprox,'linewidth',1.0,'DisplayName','O($\epsilon$) Approximation');
xlabel('$t$','interpreter','Latex','FontSize',16)
ylabel('$x$','interpreter','Latex','FontSize',16)
legnd1 = legend('interpreter','Latex');
legnd1.NumColumns = 1;
legnd1.FontSize = 14;
xlim([0, pi])
hold off
grid on

error = max( abs( xtrue(:,1)' - xApprox));
string_to_print = ['With $\varepsilon$=', num2str(epsilon), ' the maximal error is ', num2str(error)];
text(1, -0.25, string_to_print, 'interpreter','Latex');

