%% Initiate Script
close all
clear all
clc

%% Params & Initial Condition

a = 10;

b = 28; %20;
c = 8/3;
criticalB = a*(a+c+3)/(a-c-1);
disp(['The critical Rayleigh number is ', num2str(criticalB)]);
x0 = [0.101; 0.1; 0.1];
y0 = [0.101; 0.1; 0.1001];

%% Function & Simulation

f = @(t,x) [a * (x(2) - x(1));
            b * x(1) - x(2) - x(1) * x(3);
            x(1) * x(2) - c * x(3)];
        
tmax = 1000;
[t ,x] = ode45(f, [0,tmax], x0);
[t ,y] = ode45(f, [0,tmax], y0);

%% Plot

figure(1)
hold on
% visualize the fixed points as well
x00 = sqrt(c*(b-1));
y00 = x00;
z00 = b-1;

plot3(x(:,1), x(:,2),x(:,3), '-')
plot3(y(:,1), y(:,2),y(:,3), '-')

plot3(0,0,0,'.', 'Markersize', 20,'DisplayName', '$P_1$');
plot3(x00,y00,z00,'.','Markersize', 20, 'DisplayName', '$P_2$');
plot3(-x00,-y00,z00,'.', 'Markersize', 20,'DisplayName', '$P_3$');
title(['Tmax=', num2str(tmax)])
legend('Interpreter','latex');
grid on
