%% Initiation

close all
clear all
clc

%% Main

lambda = 0.5;
x = linspace(-0.5, 0.5, 50);

y = x.^2/(lambda - 1);

figure;
plot(x,y)

maxIter = 1000;

xn = zeros(maxIter + 1, 1);
yn = zeros(maxIter + 1, 1);

% Initial Conditions

xn1(1) = -0.1;
yn1(1) = 0.1;

xn2(1) = 0.1;
yn2(1) = 0.1;

xn3(1) = -0.25;
yn3(1) = 0.25;

xn4(1) = 0.25;
yn4(1) = 0.25;

% Interations

for j = 1:maxIter
    [xn1(j+1), yn1(j+1)] = map(xn1(j), yn1(j), lambda);
end

for j = 1:maxIter
    [xn2(j+1), yn2(j+1)] = map(xn2(j), yn2(j), lambda);
end

for j = 1:maxIter
    [xn3(j+1), yn3(j+1)] = map(xn3(j), yn3(j), lambda);
end

for j = 1:maxIter
    [xn4(j+1), yn4(j+1)] = map(xn4(j), yn4(j), lambda);
end

hold on
plot(xn1, yn1, '*r')
plot(xn2, yn2, '*r')
plot(xn3, yn3, '*g')
plot(xn4, yn4, '*g')
xlabel('$x$','interpreter','latex')
ylabel('$y$','interpreter','latex')
grid on

% plot the time evolution of the trajectories:
figure(2);
hold on;
title('Along the x axis')
plot( xn1, '*r')
plot( xn2, '*r')
plot( xn3, '*g')
plot( xn4, '*g')
xlabel('$n$','interpreter','latex')
ylabel('$x$','interpreter','latex')
grid on;

figure(3);
hold on;
title('Along the y axis')
plot( yn1, '*r')
plot( yn2, '*r')
plot( yn3, '*g')
plot( yn4, '*g')
xlabel('$n$','interpreter','latex')
ylabel('$y$','interpreter','latex')
grid on;

%% Function

function [x1, y1] = map(x0, y0, lambda)
    x1 = x0 + x0 * y0;
    y1 = lambda * y0 - x0^2;
end