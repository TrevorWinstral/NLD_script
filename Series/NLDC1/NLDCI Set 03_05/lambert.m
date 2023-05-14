odefunction = @(t,x) x - x.^3;
% set \Delta t = 0
t_eval = [0:0.1:12];
x0 = 1e-3;
[~, x] = ode45(odefunction, t_eval, x0);
% n = 1, m = 150
% define matrices X and Y
X = x(1:end-1)'; 
Y = x(2:end)'; 
B = (Y*X')*pinv(X*X');
m = size(t_eval,2);
y0 = x0;
for i=1:m
    y0 = [y0, B*y0(end)];
end
hold on; plot(x), plot(y0)


%%

d = load('~/dataPOD.mat');